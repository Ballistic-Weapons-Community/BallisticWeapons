//=============================================================================
// ClientLoadoutInterface.
//
// Communication actor between loadout mutator and a client
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class ClientLoadoutInterface extends Actor DependsOn(Mut_Loadout);

var Mut_Loadout Mut;		// The Loadout mutator
var PlayerController PC;	// PlayerController associated with this COI
var float			LastLoadoutTime;
var() config float	ChangeInterval;

var array<string>	Group0;
var array<string>	Group1;
var array<string>	Group2;
var array<string>	Group3;
var array<string>	Group4;

var() array<Mut_Loadout.LOItem>	Items;

var bool			bWeaponsReady;
//var float			MyDamageRate;
var int				ElapsedTime;
var float			LastTimeUT;

//var float			MySniperEff, MyShotgunEff, MyHazardEff;

struct LoadoutInfo
{
//	var() int		ElapsedTime;
	var() float		DamageRate;
	var() float		SniperEff;
	var() float		ShotgunEff;
	var() float		HazardEff;
};
var LoadoutInfo MyLoadoutInfo;

var string	LastLoadout[5];

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSetLoadout, ServerLoadoutChanged;
	reliable if (Role == ROLE_Authority)
		ClientStartLoadout, ClientOpenLoadoutMenu, ReceiveWeapon, ReceiveWeaponEnd;
	reliable if (Role == ROLE_Authority)
		PC;
	reliable if (Role == ROLE_Authority && bNetDirty)
		ElapsedTime;//, MyDamageRate, MySniperEff, MyShotgunEff, MyHazardEff;
}

simulated function int GetItemsLength()
{
	if (Role == ROLE_Authority)
	{
		return Mut.Items.Length;
	}
	else
	{
		return Items.Length;
	}
	return -1;
}

simulated function Mut_Loadout.LOItem GetItem(int ItemNum)
{
	if (Role == ROLE_Authority)
		return Mut.Items[ItemNum];
	return Items[Itemnum];
}

simulated function ReceiveWeaponEnd ()
{
	bWeaponsReady = true;
}
simulated function ReceiveWeapon (Mut_Loadout.LOItem Item)
{
	Items[Items.length] = Item;
}

function SendWeapons()
{
	local int i;

	for (i=0;i<Mut.Items.length;i++)
	{
		if (Mut.Items[i].ItemName == "")
			continue;
		ReceiveWeapon(mut.Items[i]);
	}
	ReceiveWeaponEnd();
}

function Initialize(Mut_Loadout MO, PlayerController P)
{
	Mut = MO;
	PC = P;

	bWeaponsReady=true;
	if (level.NetMode != NM_StandAlone && Viewport(P.Player) == None)
		SendWeapons();

	OpenLoadoutMenu();
//	ClientOpenLoadoutMenu();

	SetTimer(1.0,true);
}

function OpenLoadoutMenu()
{
	if (PC.PlayerReplicationInfo.Kills == 0)
		MyLoadoutInfo.DamageRate = 0;
	else
		MyLoadoutInfo.DamageRate = float(Mut.LoadoutRules.GetPlayerDamage(PC.PlayerReplicationInfo.PlayerID)) / PC.PlayerReplicationInfo.Kills;
	if (PC.PlayerReplicationInfo.Deaths < 1)
	{
		MyLoadoutInfo.SniperEff =	Mut.LoadoutRules.GetSniperEff(PC.PlayerReplicationInfo.PlayerID) * 2;
		MyLoadoutInfo.ShotgunEff =	Mut.LoadoutRules.GetShotgunEff(PC.PlayerReplicationInfo.PlayerID) * 2;
		MyLoadoutInfo.HazardEff =	Mut.LoadoutRules.GetHazardEff(PC.PlayerReplicationInfo.PlayerID) * 2;
	}
	else
	{
		MyLoadoutInfo.SniperEff =	Mut.LoadoutRules.GetSniperEff(PC.PlayerReplicationInfo.PlayerID) / PC.PlayerReplicationInfo.Deaths;
		MyLoadoutInfo.ShotgunEff =	Mut.LoadoutRules.GetShotgunEff(PC.PlayerReplicationInfo.PlayerID) / PC.PlayerReplicationInfo.Deaths;
		MyLoadoutInfo.HazardEff =	Mut.LoadoutRules.GetHazardEff(PC.PlayerReplicationInfo.PlayerID) / PC.PlayerReplicationInfo.Deaths;
	}

//	PC.ClientMessage("TotalDamage: "$float(Mut.LoadoutRules.GetPlayerDamage(PC.PlayerReplicationInfo.PlayerID))$", MyDamageRate: "$MyDamageRate);

	ClientOpenLoadoutMenu(MyLoadoutInfo);
}

simulated function ClientOpenLoadoutMenu(LoadoutInfo LOI)
{
	MyLoadoutInfo = LOI;

	if (PC ==None || PC.Player == None)
		return;
	PC.ClientOpenMenu ("BallisticProV55.BallisticLoadOutMenu");
	if (PC.Player.GUIController != None)
		BallisticLoadOutMenu(GUIController(PC.Player.GUIController).ActivePage).COI = self;
}
event Tick(float DT)
{
	if (Role == ROLE_Authority && level.TimeSeconds - LastTimeUT > 5)
	{
		ElapsedTime = Level.Game.GameReplicationInfo.ElapsedTime;
		LastTimeUT = level.TimeSeconds;
	}
}
event Timer()
{
	if (PC == None)
		Destroy();
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

// Called from menu to inform us that the client's loadout has changed
simulated function LoadoutChanged(string Stuff[5])
{
	ServerLoadoutChanged(Stuff[0], Stuff[1], Stuff[2], Stuff[3], Stuff[4]);
}
// Called from client when its loadout changes
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
		ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4);
		LastLoadoutTime = level.TimeSeconds;
	}
	//else if ((ONSOnslaughtGame(level.Game)!=None))
	//	for(i=0;i<ONSOnslaughtGame(level.Game).PowerCores.length;i++)
	//		if ( (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByRed && PC.GetTeamNum() == 0) || (ONSOnslaughtGame(level.Game).PowerCores[i].bPoweredByBlue && PC.GetTeamNum() == 1) )
	//			if (VSize(ONSOnslaughtGame(level.Game).PowerCores[i].Location - PC.Pawn.Location) < 384)
	//			{
	//				ServerSetLoadout(Stuff0, Stuff1, Stuff2, Stuff3, Stuff4);
	//				LastLoadoutTime = level.TimeSeconds;
	//				return;
	//			}
}
// Called from server. Tells client to send back loadout info
simulated function ClientStartLoadout()
{
	ServerSetLoadout(class'Mut_Loadout'.default.LoadOut[0],class'Mut_Loadout'.default.LoadOut[1],class'Mut_Loadout'.default.LoadOut[2],class'Mut_Loadout'.default.LoadOut[3],class'Mut_Loadout'.default.LoadOut[4]);
}
// Loadout info sent back from client after it was requested by server
//function ServerSetLoadout(string Stuff[5])
function ServerSetLoadout(string Stuff0, string Stuff1, string Stuff2, string Stuff3, string Stuff4)
{
	local string Stuff[5];
	Stuff[0] = Stuff0;
	Stuff[1] = Stuff1;
	Stuff[2] = Stuff2;
	Stuff[3] = Stuff3;
	Stuff[4] = Stuff4;
	if (PC.Pawn != None)
		Mut.OutfitPlayer(PC.Pawn, Stuff, LastLoadout);

	LastLoadout[0] = Stuff[0];
	LastLoadout[1] = Stuff[1];
	LastLoadout[2] = Stuff[2];
	LastLoadout[3] = Stuff[3];
	LastLoadout[4] = Stuff[4];
}

defaultproperties
{
     ChangeInterval=60.000000
     bHidden=True
     bOnlyRelevantToOwner=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
