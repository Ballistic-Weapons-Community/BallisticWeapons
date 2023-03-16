//=============================================================================
// ClientOutfittingInterface.
//
// COIs Provide a means of transferring equipment loadout info from a single
// client to the outfitting mutator.
//
// Modified for killstreak support by Azarael

//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.

//=============================================================================
class ClientOutfittingInterface extends Actor
	config(BallisticProV55);
	
const NUM_GROUPS = 5;


var Mut_Outfitting 		Mut;		// The outfitting mutator
var PlayerController 	PC;	// PlayerController associated with this COI
var float				LastLoadoutTime;
var() config float		ChangeInterval;

//Groups of weapon names on the client's side.
var array<string>		Group0;
var array<string>		Group1;
var array<string>		Group2;
var array<string>		Group3;
var array<string>		Group4;

var array<string> 		KillstreakRewards[2];

var bool				bWeaponsReady, bPendingLoadoutSave;

var String 				LastLoadout[NUM_GROUPS];

var class<Weapon> 		LastLoadoutClasses[NUM_GROUPS];

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSetLoadout, ServerLoadoutChanged;
	reliable if (Role == ROLE_Authority)
		ClientStartLoadout, ClientOpenLoadoutMenu, ReceiveWeapon, ClientSaveLoadoutClasses, LastLoadoutClasses;
	reliable if (Role == ROLE_Authority)
		PC;
}

//Returns the weapon group.
simulated function array<string> GetGroup(byte GroupNum)
{
	if (Role == ROLE_Authority)
		return Mut.GetGroup(GroupNum);

	switch (GroupNum)
	{
		case	0:	return Group0;
		case	1:	return Group1;
		case	2:	return Group2;
		case	3:	return Group3;
		case	4:	return Group4;
	}
}

//Returns the weapon at the specific index.
simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	if (Role == ROLE_Authority)
		return Mut.GetGroupItem(GroupNum, ItemNum);
	switch (GroupNum)
	{
		case	0:	return Group0[ItemNum];
		case	1:	return Group1[ItemNum];
		case	2:	return Group2[ItemNum];
		case	3:	return Group3[ItemNum];
		case	4:	return Group4[ItemNum];
	}
}

//Returns the number of weapons in the group.
simulated function int GroupLength(byte GroupNum)
{
	if (Role == ROLE_Authority)
	{
		switch (GroupNum)
		{
			case 0: return class'Mut_Outfitting'.default.LoadoutGroup0.length;
			case 1: return class'Mut_Outfitting'.default.LoadoutGroup1.length;
			case 2: return class'Mut_Outfitting'.default.LoadoutGroup2.length;
			case 3: return class'Mut_Outfitting'.default.LoadoutGroup3.length;
			case 4: return class'Mut_Outfitting'.default.LoadoutGroup4.length;
		}
	}
	else
	{
		switch (GroupNum)
		{
			case 0: return Group0.length;
			case 1: return Group1.length;
			case 2: return Group2.length;
			case 3: return Group3.length;
			case 4: return Group4.length;
		}
	}

	return -1;
}


function bool IsInList (out array<string> List, string Test, optional out int Index)
{
	for(Index=0;Index<List.length;Index++)
		if (List[Index] == Test)
			return true;
	return false;
}

//Goes through the available loadout weapons, adding them to the array and continuing if the loaded weapon is invalid.
//Boxes indicate which group the weapon is in.
//Uses bitwise operations on Boxes to handle weapons which exist in multiple groups at once.
function SendWeapons ()
{
	local int i, j;
	local array<string> Weaps;
	local array<byte>	Boxes;

	//Go through the available loadout weapons, adding them to the Weaps array. Continue if there is no weapon in the slot
	for (i=0;i<Mut.LoadoutGroup0.length;i++)
	{
		if (Mut.LoadoutGroup0[i] == "")
			continue;
		Weaps[Weaps.length] = Mut.LoadoutGroup0[i];
		Boxes[Boxes.length] = 1;
	}

	for (i=0;i<Mut.LoadoutGroup1.length;i++)
	{
		if (Mut.LoadoutGroup1[i] == "")
			continue;
		
		//If the current weapon is already in the weapon list, update its Boxes entry to indicate it's in multiple slots
		if (IsInList(Weaps, Mut.LoadoutGroup1[i], j))
			Boxes[j] += 2;
		else
		{
			//Insert weapon at end
			Weaps[Weaps.length] = Mut.LoadoutGroup1[i];
			//Insert slot info
			Boxes[Boxes.length] = 2;
		}
	}
	for (i=0;i<Mut.LoadoutGroup2.length;i++)
	{
		if (Mut.LoadoutGroup2[i] == "")
			continue;
		//Third bit
		if (IsInList(Weaps, Mut.LoadoutGroup2[i], j))
			Boxes[j] += 4;
		else
		{
			Weaps[Weaps.length] = Mut.LoadoutGroup2[i];
			Boxes[Boxes.length] = 4;
		}
	}
	for (i=0;i<Mut.LoadoutGroup3.length;i++)
	{
		if (Mut.LoadoutGroup3[i] == "")
			continue;
		//Fourth bit
		if (IsInList(Weaps, Mut.LoadoutGroup3[i], j))
			Boxes[j] += 8;
		else
		{
			Weaps[Weaps.length] = Mut.LoadoutGroup3[i];
			Boxes[Boxes.length] = 8;
		}
	}
	for (i=0;i<Mut.LoadoutGroup4.length;i++)
	{
		if (Mut.LoadoutGroup4[i] == "")
			continue;
		if (IsInList(Weaps, Mut.LoadoutGroup4[i], j))
			Boxes[j] += 16;
		else
		{
			Weaps[Weaps.length] = Mut.LoadoutGroup4[i];
			Boxes[Boxes.length] = 16;
		}
	}
	
	for (i=0;i<Weaps.length-1;i++)
		ReceiveWeapon(Weaps[i], Boxes[i]);
	//Last weapon, terminate
	ReceiveWeapon(Weaps[Weaps.length-1], Boxes[Weaps.length-1], True);
}

//Uses "Boxes" to determine which groups a weapon to be added to
//Flags are checked per weapon and if fifth flag is up, the weapons
//have all been sent
simulated function ReceiveWeapon (string WeaponName, byte Boxes, optional bool bTerminate)
{
	if ((Boxes & 1) > 0)
		Group0[Group0.length] = WeaponName;
	if ((Boxes & 2) > 0)
		Group1[Group1.length] = WeaponName;
	if ((Boxes & 4) > 0)
		Group2[Group2.length] = WeaponName;
	if ((Boxes & 8) > 0)
		Group3[Group3.length] = WeaponName;
	if ((Boxes & 16) > 0)
		Group4[Group4.length] = WeaponName;
		
	if (bTerminate)
		bWeaponsReady = true;
}

function Initialize(Mut_Outfitting MO, PlayerController P)
{
	Mut = MO;
	PC = P;

	bWeaponsReady=true;
	if (level.NetMode != NM_StandAlone && Viewport(P.Player) == None)
		SendWeapons();

	ClientOpenLoadoutMenu();

	SetTimer(1.0,true);
}

simulated function ClientOpenLoadoutMenu()
{
	if (PC ==None || PC.Player == None)
		return;
	PC.ClientOpenMenu ("BallisticProV55.BallisticOutfittingMenu");
	if (PC.Player.GUIController != None)
		BallisticOutfittingMenu(GUIController(PC.Player.GUIController).ActivePage).SetupCOI(self);		
}

simulated event Timer()
{
	local int i;
	
	if (PC == None && Role == ROLE_Authority)
		Destroy();
	if (bPendingLoadoutSave)
	{
		bPendingLoadoutSave=False;
		for (i=0; i < NUM_GROUPS; i++)
			default.LastLoadoutClasses[i] = LastLoadoutClasses[i];
		if (Role == ROLE_Authority)
			SetTimer(1, true);
	}
}

event Destroyed()
{
	local int i;

	for (i=0;i<Mut.COIPond.length;i++)
	{
		if (Mut.COIPond[i] == self)
		{
			Mut.COIPond.Remove(i, 1);
			break;
		}
	}

	super.Destroyed();
}

// Called from menu to inform us that the client's loadout has changed.
simulated function LoadoutChanged(string Stuff[NUM_GROUPS])
{
	ServerLoadoutChanged(Stuff[0], Stuff[1], Stuff[2], Stuff[3], Stuff[4]);
}

// Called from client when its loadout changes.
function ServerLoadoutChanged(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4)
{
	local int i;
	// FIXME: There's some hardcoded crap here for Invasion, CTF and Onslaught!
	if (PC.Pawn == None || PC.Pawn.Health < 1)
		return;
	
	if ( (Level.TimeSeconds - PC.Pawn.SpawnTime < DeathMatch(Level.Game).SpawnProtectionTime * 5) ||
		 (level.TimeSeconds - LastLoadoutTime > ChangeInterval) ||
		 (Invasion(level.Game)!=None && !Invasion(level.Game).bWaveInProgress) ||
		 (CTFGame(level.Game)!=None && PC.GetTeamNum()<2 && VSize(CTFTeamAI(CTFGame(level.Game).Teams[PC.GetTeamNum()].AI).FriendlyFlag.HomeBase.Location - PC.Pawn.Location) < 384) )
	{
		ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4,0,0,0,0,0,0,0,0,0,0);
		LastLoadoutTime = level.TimeSeconds;
	}

	else if ((ONSOnslaughtGame(level.Game)!=None))
		for(i=0;i<ONSOnslaughtGame(level.Game).PowerCores.length;i++)
			if ( (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByRed && PC.GetTeamNum() == 0) || (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByBlue && PC.GetTeamNum() == 1) )
				if (VSize(ONSOnslaughtGame(level.Game).PowerCores[i].Location - PC.Pawn.Location) < 384)
				{
					ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4,0,0,0,0,0,0,0,0,0,0);
					LastLoadoutTime = level.TimeSeconds;
					return;
				}
}

// Called from server. Tells client to send back loadout info.
// Called at respawn of player.
simulated function ClientStartLoadout()
{
	ServerSetLoadout(
	class'Mut_Outfitting'.default.LoadOut[0],
	class'Mut_Outfitting'.default.LoadOut[1],
	class'Mut_Outfitting'.default.LoadOut[2],
	class'Mut_Outfitting'.default.LoadOut[3],
	class'Mut_Outfitting'.default.LoadOut[4],
	class'Mut_Outfitting'.default.Layout[0],
	class'Mut_Outfitting'.default.Layout[1],
	class'Mut_Outfitting'.default.Layout[2],
	class'Mut_Outfitting'.default.Layout[3],
	class'Mut_Outfitting'.default.Layout[4],
	class'Mut_Outfitting'.default.Camo[0],
	class'Mut_Outfitting'.default.Camo[1],
	class'Mut_Outfitting'.default.Camo[2],
	class'Mut_Outfitting'.default.Camo[3],
	class'Mut_Outfitting'.default.Camo[4]
	);
}

simulated function ClientSaveLoadoutClasses()
{
	bPendingLoadoutSave=True;
	SetTimer(0.5, false);
}

// Loadout info sent back from client after it was requested by server.
// Outfit the client with the standard weapons.
function ServerSetLoadout(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4, int L0, int L1, int L2, int L3, int L4, int C0, int C1, int C2, int C3, int C4) //good lord whyyy
{
	local int i;
	local string Stuff[5];
	local int Layout[5];
	local int Camo[5];
	
	Stuff[0] = Stuff0;
	Stuff[1] = Stuff1;
	Stuff[2] = Stuff2;
	Stuff[3] = Stuff3;
	Stuff[4] = Stuff4;
	
	Layout[0] = L0;
	Layout[1] = L1;
	Layout[2] = L2;
	Layout[3] = L3;
	Layout[4] = L4;
	
	Camo[0] = C0;
	Camo[1] = C1;
	Camo[2] = C2;
	Camo[3] = C3;
	Camo[4] = C4;

	if (PC.Pawn != None)
		Mut.OutfitPlayer(PC.Pawn, Stuff, LastLoadout, Layout, Camo);
		
	for (i=0; i< NUM_GROUPS; i++)
	{
		LastLoadout[i] = Stuff[i];
		LastLoadoutClasses[i] = class<Weapon>(DynamicLoadObject(Stuff[i], Class'Class', True));
		
		if (BallisticPlayer(PC) != None)
			BallisticPlayer(PC).LastLoadoutClasses[i] = LastLoadoutClasses[i];
	}
	
	ClientSaveLoadoutClasses();
}

/*
// Loadout info sent back from client after it was requested by server.
// Outfit the client with the standard weapons.
function ServerSetLoadout(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4)
{
	local int i;
	local string Stuff[5];
	
	Stuff[0] = Stuff0;
	Stuff[1] = Stuff1;
	Stuff[2] = Stuff2;
	Stuff[3] = Stuff3;
	Stuff[4] = Stuff4;

	if (PC.Pawn != None)
		Mut.OutfitPlayer(PC.Pawn, Stuff, LastLoadout);
		
	
	for (i=0; i< NUM_GROUPS; i++)
	{
		LastLoadout[i] = Stuff[i];
		LastLoadoutClasses[i] = class<Weapon>(DynamicLoadObject(Stuff[i], Class'Class', True));
		
		if (BallisticPlayer(PC) != None)
			BallisticPlayer(PC).LastLoadoutClasses[i] = LastLoadoutClasses[i];
	}
	
	ClientSaveLoadoutClasses();
}
*/

defaultproperties
{
     ChangeInterval=60.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     NetUpdateFrequency=2.000000
}
