//=============================================================================
// BallisticDiagFrames - DIAGNOSTIC BUILD ONLY, not for merging.
//
// How long frames really take, by the wall clock (the engine caps a frame's
// game step at 0.4 s, so a longer stall never shows in game time), on the
// server and on every client: a BWDBG|frames line every ten seconds, and a
// BWDBG|long frame line for every frame over 60 ms (or three times the
// average, on a slow ticking server) with what came with it. On the server:
// what was spawned and who respawned since the frame before. On a client: the
// players and the weapon, attachment and projectile classes it saw for the
// first time in that frame or the one before.
//
// Spawned by Mut_Ballistic on the server; clients get their own copy.
//=============================================================================
class BallisticDiagFrames extends ReplicationInfo;

var int					WallPrev;
var int					Frames, SumMs, MaxMs, Over50, Over100, Over250, Longs;
var int					AvgMs;			// average frame of the last summary, for the long frame threshold
var float				NextSummary;

// server
var array< class<Actor> >	SpawnClass;
var array<int>			SpawnCount;
var string				Events, PrevEvents;

// client
var array<Pawn>			SeenPawns;
var array< class<Actor> >	SeenClasses;
var string				Notes, PrevNotes;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	NextSummary = Level.TimeSeconds + 10;
	Log(class'BallisticDiag'.static.Head(Level, "diag") $ "frame logging on");
}

// Server: an actor was just spawned (Mut_Ballistic.CheckReplacement)
function NoteSpawn(Actor A)
{
	local int i;

	for (i = 0; i < SpawnClass.Length; i++)
		if (SpawnClass[i] == A.Class)
		{
			SpawnCount[i]++;
			return;
		}
	if (SpawnClass.Length >= 40)
		return;
	SpawnClass[i] = A.Class;
	SpawnCount[i] = 1;
}

// Server: something worth knowing about happened (a respawn)
function NoteEvent(string S)
{
	if (Len(Events) < 800)
		Events = Events $ S $ "; ";
}

simulated function Note(string S)
{
	if (Len(Notes) < 800)
		Notes = Notes $ S $ "; ";
}

simulated function FirstClass(class<Actor> C)
{
	local int i;

	for (i = 0; i < SeenClasses.Length; i++)
		if (SeenClasses[i] == C)
			return;
	SeenClasses[i] = C;
	Note("first " $ C.Name);
}

// Client: new players, and classes met for the first time
simulated function ClientWatch()
{
	local Pawn P;
	local InventoryAttachment A;
	local Projectile Pr;
	local Weapon W;
	local array< class<Actor> > FrameClasses;
	local int i;

	for (i = SeenPawns.Length - 1; i >= 0; i--)
		if (SeenPawns[i] == None || SeenPawns[i].bDeleteMe)
			SeenPawns.Remove(i, 1);
	foreach DynamicActors(class'Pawn', P)
	{
		for (i = 0; i < SeenPawns.Length && SeenPawns[i] != P; i++);
		if (i < SeenPawns.Length)
			continue;
		SeenPawns[i] = P;
		Note("new pawn " $ class'BallisticDiag'.static.Who(P) $ " (" $ P.Class.Name $ ", " $ P.Mesh $ ")");
		FirstClass(P.Class);
	}

	// many projectiles share a class: each class once a frame
	foreach DynamicActors(class'InventoryAttachment', A)
	{
		for (i = 0; i < FrameClasses.Length && FrameClasses[i] != A.Class; i++);
		if (i == FrameClasses.Length)
			FrameClasses[i] = A.Class;
	}
	foreach DynamicActors(class'Projectile', Pr)
	{
		for (i = 0; i < FrameClasses.Length && FrameClasses[i] != Pr.Class; i++);
		if (i == FrameClasses.Length && i < 32)
			FrameClasses[i] = Pr.Class;
	}
	foreach DynamicActors(class'Weapon', W)
	{
		for (i = 0; i < FrameClasses.Length && FrameClasses[i] != W.Class; i++);
		if (i == FrameClasses.Length && i < 48)
			FrameClasses[i] = W.Class;
	}
	for (i = 0; i < FrameClasses.Length; i++)
		FirstClass(FrameClasses[i]);
}

function string SpawnList()
{
	local int i;
	local string S;

	for (i = 0; i < SpawnClass.Length; i++)
		S = S $ SpawnClass[i].Name $ " x" $ SpawnCount[i] $ ", ";
	return S;
}

simulated function Summary()
{
	local string S;
	local PlayerController PC;
	local Controller C;
	local Projectile Pr;
	local int Players, Bots, Projectiles;

	AvgMs = SumMs / Max(1, Frames);
	S = class'BallisticDiag'.static.Head(Level, "frames") $ "frames " $ Frames $ "|avg ms " $ AvgMs $ "|max ms " $ MaxMs
		$ "|over 50 " $ Over50 $ "|over 100 " $ Over100 $ "|over 250 " $ Over250 $ "|long frames logged " $ Longs;
	if (Level.NetMode != NM_Client)
	{
		for (C = Level.ControllerList; C != None; C = C.NextController)
		{
			if (PlayerController(C) != None && C.PlayerReplicationInfo != None && !C.PlayerReplicationInfo.bOnlySpectator)
				Players++;
			else if (AIController(C) != None && C.PlayerReplicationInfo != None)
				Bots++;
		}
		S = S $ "|players " $ Players $ "|bots " $ Bots;
	}
	if (Level.NetMode != NM_DedicatedServer)
	{
		PC = Level.GetLocalPlayerController();
		if (PC != None && PC.PlayerReplicationInfo != None)
			S = S $ "|my ping " $ (4 * PC.PlayerReplicationInfo.Ping) $ "|packet loss " $ PC.PlayerReplicationInfo.PacketLoss;
	}
	foreach DynamicActors(class'Projectile', Pr)
		Projectiles++;
	Log(S $ "|projectiles " $ Projectiles);

	Frames = 0;
	SumMs = 0;
	MaxMs = 0;
	Over50 = 0;
	Over100 = 0;
	Over250 = 0;
	Longs = 0;
	NextSummary = Level.TimeSeconds + 10;
}

simulated function Tick(float DT)
{
	local int Wall, Ms;
	local string S;

	Wall = class'BallisticDiag'.static.WallMs(Level);
	if (WallPrev > 0)
	{
		Ms = Wall - WallPrev;
		if (Ms < 0)
			Ms += 86400000;
	}
	WallPrev = Wall;

	if (Level.NetMode != NM_DedicatedServer)
		ClientWatch();

	if (Ms > 0)
	{
		Frames++;
		SumMs += Ms;
		if (Ms > MaxMs)
			MaxMs = Ms;
		if (Ms > 50)
			Over50++;
		if (Ms > 100)
			Over100++;
		if (Ms > 250)
			Over250++;
		if (Ms > Max(60, 3 * AvgMs))
		{
			Longs++;
			S = class'BallisticDiag'.static.Head(Level, "long frame") $ "real ms " $ Ms $ "|game step ms " $ int(1000 * DT);
			if (Level.NetMode != NM_Client)
				S = S $ "|spawned " $ SpawnList() $ "|events " $ PrevEvents $ Events;
			if (Level.NetMode != NM_DedicatedServer)
				S = S $ "|seen " $ PrevNotes $ Notes;
			Log(S);
		}
	}
	PrevEvents = Events;
	Events = "";
	PrevNotes = Notes;
	Notes = "";
	SpawnClass.Length = 0;
	SpawnCount.Length = 0;

	if (Level.TimeSeconds >= NextSummary)
		Summary();
}

defaultproperties
{
	NetUpdateFrequency=1.000000
}
