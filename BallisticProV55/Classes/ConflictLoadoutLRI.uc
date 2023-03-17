//=============================================================================
// Conflict Loadout Linked Replication Info
//
// LinkedReplicationInfo used by Conflict Loadout.
// Adds list of weapons to send to client, requirements for the weapons for
// evolution mode, player's skill info, selected loadout lit, saved loadout
// list and a few other settings...
//
// Also handles the client's setup of the Gear menu for the moment. Might
// have to be moved to an Interaction for time reasons, doesn't work
// correctly offline
//
// by Nolan "Dark Carnivour" Richert.
// edited for mutator support by Azarael
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConflictLoadoutLRI extends BallisticPlayerReplicationInfo 
	DependsOn(Mut_Loadout)
	DependsOn(ConflictLoadoutConfig)
    exportstructs;

/*
	Game:	ServerFullList
	PRI:	ClientInv
	Menu:	LoadPage->PRI:S:RequestFullList->C->GiveClientFullList->FullListIsReady  ->MenuDone->PRI:S:SetInventory->InventoryIsReady
*/

enum ELoadoutUpdateMode
{
	LUM_Immediate,
	LUM_Delayed
};

var ELoadoutUpdateMode	LoadoutUpdateMode;
var int					ListenRetryCount;

var Mut_ConflictLoadout LoadoutMut;						// The mutator itself

var bool				bInventoryInitialized;
var bool				bPendingLoadout;
var array<string> 		PendingLoadout;						// If set to pending mode, next loadout

var int                 InitialWeaponIndex;
var int                 PendingInitialWeaponIndex;

var array<string> 		Loadout;								// Current loadout
var array<string>		Layout;									// Current layout of each item
var array<string>		Camo;									// Current camo of each item

struct InventoryEntry
{
    var string  ClassName;
    var string  ItemName;
    var byte    InventoryGroup;
    var byte    InventorySize;
};

var array<InventoryEntry> 		FullInventoryList;					// List of all weapons available
var array<Mut_Loadout.LORequirements> RequirementsList;	// Requirements for the weapons. order and length must match 'FullInventoryList'

var array<class<ConflictItem> > AppliedItems;

// Server side skill variables.
var int		PlayerDamage;
var float	SniperKills;
var float	ShotgunKills;
var float	HazardKills;

var int		DeathsHoldingSniper;
var int		DeathsHoldingShotgun;
var int		DeathsHoldingHazard;

// Skill info package sent to client.
struct SkillInfo
{
	var() int		ElapsedTime;
	var() float		DamageRate;
	var() float		SniperEff;
	var() float		ShotgunEff;
	var() float		HazardEff;
};
var SkillInfo MySkillInfo;

var byte LoadoutOption;		// 0: standard, 1: Evolution, 2:Buy system

var bool	bHasList;			// Client var to verify if Weapon list is good and up-to-date
var bool	bHasSkillInfo;		// Client var to verify if skill info has been sent
var Controller myController; //Required as this is a LinkedReplicationInfo

var float LastLoadoutTime, ChangeInterval; //vars to prevent rapid update

var localized string MenuName, MenuHelp; // Stuff for the menu

var private editconst bool bMenuModified, bMenuAdd;

replication
{
	reliable if (Role == ROLE_Authority)
		myController;
	reliable if (Role == ROLE_Authority)
		GiveClientSkillInfo, ClientReceiveWeaponReq, ClientReceiveEnd, ClientPurge;
	reliable if (Role < ROLE_Authority)
		ServerSetInventory, RequestFullList, RequestSkillInfo;
	reliable if (Role == ROLE_Authority && bNetDirty)
		LoadoutOption;
}

// what is this?
simulated function ClientPurge(bool bPurgeActors)
{
	local Actor A;

	if (Role == ROLE_Authority)
		return;
	foreach AllActors(class'Actor', A)
	{
		if ( (!bPurgeActors && A.IsA('Pawn')) || (bPurgeActors && !A.IsA('Controller') && !A.IsA('ReplicationInfo') && !A.IsA('GameInfo')) )
			A.Reset();
	}
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Role == ROLE_Authority)
		myController = Controller(Owner);
}

simulated function PostNetBeginPlay()
{
	local Mutator M;

	Super.PostNetBeginPlay();
	bMenuAdd = True;

	if (Role == ROLE_Authority)
	{
		//Find the mutator
		for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
		{
			if (Mut_ConflictLoadout(M) != None)
			{
				LoadoutMut = Mut_ConflictLoadout(M);
				LoadoutOption = LoadoutMut.LoadoutOption;
			}
		}
		
		if (myController != None && Level.NetMode != NM_DedicatedServer)
			Loadout = class'ConflictLoadoutConfig'.default.SavedInventory;
	}
	
	// awkward switch because of a timing issue
	// within PostNetBeginPlay, we have the controller, but we don't have the viewport
	// the viewport is used by IsLocallyControlled() to know whether we're on the remote side
	// this leaves us having to retry on listen servers
	switch (Level.NetMode)
	{
		case NM_StandAlone:
		case NM_Client:
		case NM_ListenServer:
			SetTimer(0.5, true);
			break;	
		case NM_DedicatedServer:
			break;	
	}	
}

//===============================================================
// Timer
//
// Used on Listen servers to handle the hoster's replication
//===============================================================
simulated function Timer()
{
	if (
		PlayerController(myController) != None 
		&& PlayerController(myController).PlayerReplicationInfo != None
		&& Viewport(PlayerController(myController).Player) != None
	)
	{
		SendSavedInventory();
		SetTimer(0.0, false);
	}
	
	else if (Level.NetMode == NM_ListenServer)
	{
		ListenRetryCount--;
		
		if (ListenRetryCount == 0)
			SetTimer(0.0, false);
	}
}

simulated function OnInventoryUpdated()
{		
	SendSavedInventory();
}

simulated function SendSavedInventory()
{	
	local string s, ls, cs;
    local int i;

	s = class'ConflictLoadoutConfig'.static.BuildSavedInventoryString();
	ls = class'ConflictLoadoutConfig'.static.BuildSavedLayoutString();
	cs = class'ConflictLoadoutConfig'.static.BuildSavedCamoString();
    i = class'ConflictLoadoutConfig'.static.GetSavedInitialWeaponIndex();
	ServerSetInventory(s, ls, cs, i);
}

simulated function Tick(float deltatime)
{	
	if (Level.NetMode == NM_DedicatedServer)
		Disable('Tick');
	if (!bMenuAdd || myController == None)
		return;
	if (Level.NetMode != NM_DedicatedServer && !bMenuModified)
		ModifyMenu();
	if (bMenuModified)
		Disable('Tick');
}

final private simulated function ModifyMenu()
{
   local UT2K4PlayerLoginMenu Menu;
   local GUITabPanel Panel;
   
	if (AIController(myController) != None)
	{
		Disable('Tick');
		return;
	}
   
   Menu = UT2K4PlayerLoginMenu(GUIController(PlayerController(myController).Player.GUIController).FindPersistentMenuByName( UnrealPlayer(myController).LoginMenuClass ));
   
   if( Menu != None )
   {
	  // You can use the panel reference to do the modifications to the tab etc.
	  // conflict tab is always first
      Panel = Menu.c_Main.InsertTab(0, MenuName, string( class'MidGameTab_Conflict' ),, MenuHelp);
	  bMenuModified=True;
	  Disable('Tick');
   }
}

function UpdateSkillInfo()
{
	if (Game_BWConflict(Level.Game) != None)
		MySkillInfo.ElapsedTime = Game_BWConflict(level.Game).TotalMatchTime;
	else if (Role == ROLE_Authority)
		MySkillInfo.ElapsedTime = Level.Game.GameReplicationInfo.ElapsedTime;
	else MySkillInfo.ElapsedTime = PlayerController(myController).GameReplicationInfo.ElapsedTime;
	
	if (myController.PlayerReplicationInfo.Deaths == 0)
	{
		MySkillInfo.SniperEff  = SniperKills  * 2;
		MySkillInfo.ShotgunEff = ShotgunKills * 2;
		MySkillInfo.HazardEff  = HazardKills  * 2;
	}
	else
	{
		MySkillInfo.SniperEff  = SniperKills  / ((DeathsHoldingSniper+1)/1.3  + myController.PlayerReplicationInfo.Deaths/4.0);
		MySkillInfo.ShotgunEff = ShotgunKills / ((DeathsHoldingShotgun+1)/1.3 + myController.PlayerReplicationInfo.Deaths/4.0);
		MySkillInfo.HazardEff  = HazardKills  / ((DeathsHoldingHazard+1)/1.3  + myController.PlayerReplicationInfo.Deaths/4.0);
	}
	if (myController.PlayerReplicationInfo.Kills == 0)
		MySkillInfo.DamageRate = 0;
	else
		MySkillInfo.DamageRate = float(PlayerDamage) / myController.PlayerReplicationInfo.Kills;
}

// Client wants skill info update
function RequestSkillInfo()
{
	UpdateSkillInfo();
	GiveClientSkillInfo(MySkillInfo);
}

// Skill info sent from server
simulated function GiveClientSkillInfo(SkillInfo SI)
{
	MySkillInfo = SI;
	bHasSkillInfo = true;
}

//===================================================
// RequestFullList
// Sends any Conflict weapon which is allocated to at least one team.
// The requirements are always sent, but only Team will be changed
// if Evolution Loadout is not on.
//===================================================
function RequestFullList()
{
	local int i;

	for (i=0;i<LoadoutMut.ConflictWeapons.Length;i++)
	{
		// Don't send a weapon allocated to neither team, but send the others
		if (!LoadoutMut.ConflictWeapons[i].bRed && !LoadoutMut.ConflictWeapons[i].bBlue)
			continue;
		ClientReceiveWeaponReq(LoadoutMut.ConflictWeapons[i].ClassName, LoadoutMut.FullRequirementsList[i]);
	}
	ClientReceiveEnd();
}

simulated function ClientReceiveWeaponReq(string ClassString, Mut_Loadout.LORequirements Requirements)
{
    local InventoryEntry entry;

    entry.ClassName = ClassString;

	FullInventoryList[FullInventoryList.length] = entry;
	RequirementsList[RequirementsList.length] = Requirements;
}

simulated function ClientReceiveEnd()
{
	bHasList = true;
	
	SortList();
}

// Get Name, BigIconMaterial and classname of weapon at index? in group?
simulated function bool LoadWIFromCache(string ClassStr, out BC_WeaponInfoCache.WeaponInfo WepInfo)
{
	local int i;

	WepInfo = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(ClassStr, i);
	
	if (i == -1)
	{
		log("Error loading item for Conflict: "$ClassStr, 'Warning');
		return false;
	}
	
	return true;
}

static final function InventoryEntry GenerateFromWeaponInfo(BC_WeaponInfoCache.WeaponInfo WI)
{
    local InventoryEntry IE;

    IE.ClassName 		 = WI.ClassName;
    IE.ItemName			 = WI.ItemName;
	IE.InventoryGroup	 = WI.InventoryGroup;
	IE.InventorySize	 = WI.InventorySize;

    return IE;
}

//=======================================================================
// SortList
// Sorts weapons by inventory group, inventory size and name.
// Can't use cache here - InventorySize may change often.
// Forced to DynamicLoadObject
//
// TODO: Possibly send cache revision in BallisticReplicationInfo
// to cause a repop and limit the amount of building
//=======================================================================
simulated function SortList()
{
	local int i, j;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local InventoryEntry Current;
	local array<InventoryEntry> Sorted;
	local array<string> ConflictItems;
	
	local int CurrentGroup, SortedGroup;

	for (i=0; i < FullInventoryList.length; i++)
	{
        /*
        // handle conflict items
		if (InStr(FullInventoryList[i].ClassName, "CItem") != -1)
        {
			ConflictItems[ConflictItems.Length] = FullInventoryList[i].ClassName;
            continue;
        }
        */

        if (!LoadWIFromCache(FullInventoryList[i].ClassName, WI))
        {
            Log("ConflictLoadoutLRI: Couldn't load "$FullInventoryList[i].ClassName$" from cache.");

            FullInventoryList.Remove(i, 1);
            --i;

            continue;
        }

        // convert weapon class to inventory entry
        Current = GenerateFromWeaponInfo(WI);

        if (Sorted.Length == 0)
        {
            Sorted[Sorted.Length] = Current;
            continue;
        }

        CurrentGroup = Current.InventoryGroup;
        
        if (CurrentGroup == 0)
            CurrentGroup = 10;
            
        for (j = 0; j < Sorted.Length; ++j)
        {
            // first check relative inventory group
            SortedGroup = Sorted[j].InventoryGroup;
            
            if (SortedGroup == 0)
                SortedGroup = 10;
            
            // valid insertion if group is less
            if (CurrentGroup < SortedGroup)
                break;
            
            if (CurrentGroup > SortedGroup)
                continue;

            // same inventory group - check relative inventory size

            // valid insertion if inventory size is less
            if (Current.InventorySize < Sorted[j].InventorySize)
                break;

            if (Current.InventorySize > Sorted[j].InventorySize)
                continue;

            // same inventory size - check string ordering
            if (StrCmp(Current.ItemName, Sorted[j].ItemName, 6, True) <= 0)
                break;
        }

        Sorted.Insert(j, 1);
        Sorted[j] = Current;
	}
	
	for (i = 0; i < Sorted.Length; ++i)
    {
		FullInventoryList[i] = Sorted[i];
    }
	
    /*
	j = i;
		
	for (i = 0; i < ConflictItems.Length; ++i)
	{
		FullInventoryList[j].ClassName = ConflictItems[i];
        FullInventoryList[j].InventorySize = 1;
        FullInventoryList[j].InventoryGroup = 12;
		++j;	
	}
    */
}

//===================================================
// SetDelayedMode
// Enables delayed loadout updates
//===================================================
function SetDelayedMode()
{
	LoadoutUpdateMode = LUM_Delayed;
}

function SetImmediateMode()
{
	if (bPendingLoadout)
		UpdatePendingLoadout();

	LoadoutUpdateMode = LUM_Immediate;
}

function UpdateInitialWeaponIndex()
{
    if (Loadout.Length == 0)
        InitialWeaponIndex = 0;
    else 
        InitialWeaponIndex = Min(InitialWeaponIndex, Loadout.Length - 1);
}

//===================================================
// ServerSetInventory
// Sent from client to update server's loadout. Splits the received
// string into an array and validates with UpdateInventory.
//===================================================
function ServerSetInventory(string ClassesString, string LayoutsString, string CamosString, int initial_wep_index)
{
	if (!bInventoryInitialized)
	{
		bInventoryInitialized = true;
		Split(ClassesString, "|", Loadout);
		Split(LayoutsString, "|", Layout);
		Split(CamosString, "|", Camo);
        InitialWeaponIndex = initial_wep_index;
		UpdateInventory();
		return;
	}

	switch (LoadoutUpdateMode)
	{
		case LUM_Immediate:
			Split(ClassesString, "|", Loadout);
			Split(LayoutsString, "|", Layout);
			Split(CamosString, "|", Camo);
            InitialWeaponIndex = initial_wep_index;
			UpdateInventory();
			break;
		case LUM_Delayed:
			Split(ClassesString, "|", PendingLoadout);
			Split(LayoutsString, "|", Layout);
			Split(CamosString, "|", Camo);
            PendingInitialWeaponIndex = initial_wep_index;
			bPendingLoadout = true;
			break;
	}
}

//===================================================
// OnRoundChanged
// Performs delayed loadout updates, if the mode is on
//===================================================
function UpdatePendingLoadout()
{
	if (LoadoutUpdateMode == LUM_Immediate || !bPendingLoadout)
		return;

	Loadout = PendingLoadout;
    InitialWeaponIndex = PendingInitialWeaponIndex;

	bPendingLoadout = false;
	UpdateInventory();
}

//===================================================
// UpdateInventory
// Validates the loadout and attempts to change the player's held
// equipment.
//===================================================
function UpdateInventory()
{
	local string s;

	Validate(Loadout, Layout, Camo);

	if (Loadout.length == 0)
	{
 		s = LoadoutMut.GetFallbackWeapon(self);
 		if (s != "")
 			Loadout[0] = s;
 	}

    UpdateInitialWeaponIndex();
}

//===================================================
// Validate a list of weapons and take out the bad ones
//===================================================
simulated function Validate(out array<string> ClassNames, out array<string> LayoutIndex, out array<string> CamoIndex)
{
	local int i;
	for (i = 0; i < ClassNames.length; i++)
	{
		if (!ValidateWeapon(ClassNames[i]))
		{
			ClassNames.remove(i,1);
			LayoutIndex.remove(i,1);
			CamoIndex.remove(i,1);
			i--;
		}
	}
}

//===================================================
// ValidateWeapon
// Checks if the weapon is valid based on the player's team and skill.
//===================================================
simulated function bool ValidateWeapon (string WeaponName)
{
	local int i;

	if (Role == ROLE_Authority)
	{
		for (i=0;i<LoadoutMut.ConflictWeapons.Length;i++)
        {
			if (LoadoutMut.ConflictWeapons[i].ClassName ~= WeaponName)
			{
				if (!TeamAllowed(LoadoutMut.ConflictWeapons[i]))
					return false;

				return WeaponRequirementsOk(LoadoutMut.FullRequirementsList[i]);
            }
		}
	}
	else
	{
		for (i = 0; i < FullInventoryList.Length; i++)
        {
			if (FullInventoryList[i].ClassName ~= WeaponName)
				return WeaponRequirementsOk(RequirementsList[i]);
        }
	}
	return false;
}

simulated function bool TeamAllowed(Mut_ConflictLoadout.ConflictWeapon weapon)
{
	if (myController == None)
	{
		log("TEAMALLOWED - NO CONTROLLER!");
		return false;
	}

	if (myController.PlayerReplicationInfo.Team != None)
	{
		switch (myController.PlayerReplicationInfo.Team.TeamIndex)
		{
			case 0:
				return weapon.bRed;
			case 1:
				return weapon.bBlue;
			default:
				return weapon.bRed || weapon.bBlue;
		}
	}
	else // dm
	{
		return weapon.bRed || weapon.bBlue;
	}
}

//===================================================
// WeaponRequirementsOK
//
// Called to verify a weapon is available to the player.
// Manages team-related and Evolution factors.
// Todo: Add support for weapon prices.
//===================================================
simulated function bool WeaponRequirementsOk (Mut_Loadout.LORequirements Requirements)
{
	if (myController == None)
	{
		log("WEPREQS - NO CONTROLLER!");
		return false;
	}
	if (LoadoutOption == 0 || LoadoutOption == 2)
		return true;
	if (myController.PlayerReplicationInfo.Score < Requirements.Frags)
		return false;
	if (Role == ROLE_Authority)
	{
		if (Level.Game.GameReplicationInfo.ElapsedTime < Requirements.MatchTime)
			return false;
		if (myController.PlayerReplicationInfo.Deaths == 0)
		{
			if (myController.PlayerReplicationInfo.Score / 0.1 < Requirements.Efficiency)
				return false;
			if (SniperKills * 2 < Requirements.SniperEff)
				return false;
			if (ShotgunKills * 2 < Requirements.ShotgunEff)
				return false;
			if (HazardKills * 2 < Requirements.HazardEff)
				return false;
		}
		else
		{	if (myController.PlayerReplicationInfo.Score / myController.PlayerReplicationInfo.Deaths < Requirements.Efficiency)
				return false;
			if (SniperKills  / ((DeathsHoldingSniper+1)/1.3  + myController.PlayerReplicationInfo.Deaths/4.0) < Requirements.SniperEff)
				return false;
			if (ShotgunKills / ((DeathsHoldingShotgun+1)/1.3 + myController.PlayerReplicationInfo.Deaths/4.0) < Requirements.ShotgunEff)
				return false;
			if (HazardKills  / ((DeathsHoldingHazard+1)/1.3  + myController.PlayerReplicationInfo.Deaths/4.0) < Requirements.HazardEff)
				return false;
		}
		if (myController.PlayerReplicationInfo.Kills == 0)
		{
			if (0 < Requirements.DamageRate)
				return false;
		}
		else if (float(PlayerDamage) / myController.PlayerReplicationInfo.Kills < Requirements.DamageRate)
			return false;
	}
	else
	{
		if (MySkillInfo.ElapsedTime < Requirements.MatchTime)
			return false;
		if (myController.PlayerReplicationInfo.Deaths == 0)
		{
			if (myController.PlayerReplicationInfo.Score / 0.1 < Requirements.Efficiency)
				return false;
		}
		else
		{
			if (myController.PlayerReplicationInfo.Score / myController.PlayerReplicationInfo.Deaths < Requirements.Efficiency)
				return false;
		}
		if (MySkillInfo.SniperEff  < Requirements.SniperEff)
			return false;
		if (MySkillInfo.ShotgunEff < Requirements.ShotgunEff)
			return false;
		if (MySkillInfo.HazardEff  < Requirements.HazardEff)
			return false;
		if (MySkillInfo.DamageRate < Requirements.DamageRate)
			return false;
	}
	return true;
}

defaultproperties
{
	ListenRetryCount=10

	LoadoutUpdateMode=LUM_Immediate

	Loadout(0)="BallisticProV55.M50AssaultRifle"
	Loadout(1)="BallisticProV55.MRS138Shotgun"
	Loadout(2)="BallisticProV55.MD24Pistol"
	Loadout(3)="BallisticProV55.MD24Pistol"
	Loadout(4)="BallisticProV55.X4Knife"
	Loadout(5)="BallisticProV55.NRP57Grenade"
	Layout(0)="0"
	Layout(1)="0"
	Layout(2)="0"
	Layout(3)="0"
	Layout(4)="0"
	Layout(5)="0"
	Camo(0)="0"
	Camo(1)="0"
	Camo(2)="0"
	Camo(3)="0"
	Camo(4)="0"
	Camo(5)="0"
	
	ChangeInterval=60.000000
	MenuName="Gear"
	MenuHelp="Choose your starting equipment here."
	bOnlyRelevantToOwner=True
	bAlwaysTick=True
}
