//=============================================================================
// EliminationPRI.
//
// LinkedReplicationInfo used by Spatial Loadout.
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
class ConflictLoadoutLRI extends BallisticPlayerReplicationInfo DependsOn(Mut_Loadout) config(BallisticProV55);
/*
	Game:	ServerFullList
	PRI:	ClientInv
	Menu:	LoadPage->PRI:S:RequestFullList->C->GiveClientFullList->FullListIsReady  ->MenuDone->PRI:S:SetInventory->InventoryIsReady
*/

var Mut_ConflictLoadout LoadoutMut;					// The mutator itself
var config array<string> SavedInventory;			// old inv saved to config
var array<string> Loadout;								// Current loadout
var array<string> FullInventoryList;					// List of all weapons available
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
	local string s;
	local int i;
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
			Loadout = SavedInventory;
		
		return;
	}

	//Send saved inventory to server
	if (PlayerController(myController) != None && Viewport(PlayerController(myController).Player) != None)
	{
		for (i=0; i<SavedInventory.Length; i++)
		{
			if (s == "")
				s = SavedInventory[i];
			else
				s = s $ "|" $ SavedInventory[i];
		}
		ServerSetInventory(s);
	}
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
      Panel = Menu.c_Main.InsertTab(0, MenuName, string( class'BallisticTab_ConflictLoadoutPro' ),, MenuHelp);
	  Menu.c_Main.ActivateTabByName(MenuName, true);
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
	FullInventoryList[FullInventoryList.length] = ClassString;
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

simulated function SortList()
{
	local int i, j;
	local BC_WeaponInfoCache.WeaponInfo WI;
	local array<BC_WeaponInfoCache.WeaponInfo> SortedWIs;
	local array<string> ConflictItems;
	
	local int wiGroup, existingGroup;
	
	for (i=0; i < FullInventoryList.length; i++)
	{
		if (InStr(FullInventoryList[i], "CItem") != -1)
			ConflictItems[ConflictItems.Length] = FullInventoryList[i];
	
		else 
		{
			if (LoadWIFromCache(FullInventoryList[i], WI))
			{
				if (SortedWIs.Length == 0)
					SortedWIs[SortedWIs.Length] = WI;
				else 
				{	
					wiGroup = WI.InventoryGroup;
					
					if (wiGroup == 0)
						wiGroup = 10;
						
					for (j = 0; j < SortedWIs.Length; ++j)
					{
						existingGroup = SortedWIs[j].InventoryGroup;
						
						if (existingGroup == 0)
							existingGroup = 10;
						
						if (wiGroup < existingGroup)
						{
							SortedWIs.Insert(j, 1);
							SortedWIs[j] = WI;
							break;
						}
						
						if (wiGroup == existingGroup)
						{
							if (StrCmp(WI.ItemName, SortedWIs[j].ItemName, 6, True) <= 0)
							{	
								SortedWIs.Insert(j, 1);
								SortedWIs[j] = WI;
								break;
							}
						}
						
						if (j == SortedWIs.Length - 1)
						{
							SortedWIs[SortedWIs.Length] = WI;
							break;
						}
					}
				}
			}
		}
	}
	
	for (i = 0; i < SortedWIs.Length; ++i)
		FullInventoryList[i] = SortedWIs[i].ClassName;
	
	j = i;
		
	for (i = 0; i < ConflictItems.Length; ++i)
	{
		FullInventoryList[j] = ConflictItems[i];
		++j;	
	}
}

//===================================================
// ServerSetInventory
// Sent from client to update server's loadout. Splits the received
// string into an array and validates with UpdateInventory.
//===================================================
function ServerSetInventory(string ClassesString)
{
	Split(ClassesString, "|", Loadout);
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

	Validate(Loadout);

	if (Loadout.length == 0)
	{
 		s = LoadoutMut.GetRandomWeapon(self);
 		if (s != "")
 			Loadout[0] = s;
 	}

	//Update immediately if allowed
	if (Level.TimeSeconds > LastLoadoutTime + ChangeInterval)
	{
		LoadoutMut.InventoryChanged(self);
		LastLoadoutTime = Level.TimeSeconds;
	}
}

//===================================================
// Validate a list of weapons and take out the bad ones
//===================================================
simulated function Validate(out array<string> ClassNames)
{
	local int i;
	for (i=0;i<ClassNames.length;i++)
	{
		if (!ValidateWeapon(Classnames[i]))
		{
			ClassNames.remove(i,1);
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

	if (Role == Role_Authority)
	{
		for (i=0;i<LoadoutMut.ConflictWeapons.Length;i++)
			if (LoadoutMut.ConflictWeapons[i].ClassName ~= WeaponName)
			{
				return WeaponRequirementsOk(LoadoutMut.FullRequirementsList[i]);
				return true;
			}
	}
	else
	{
		for (i=0;i<FullInventoryList.Length;i++)
			if (FullInventoryList[i] ~= WeaponName)
				return WeaponRequirementsOk(RequirementsList[i]);
	}
	return false;
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
	if (myController.PlayerReplicationInfo.Team != None && Requirements.InTeam != 2 && Requirements.InTeam != myController.PlayerReplicationInfo.Team.TeamIndex)
		return false;
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
     SavedInventory(0)="BallisticProV55.M50AssaultRifle"
     SavedInventory(1)="BallisticProV55.M806Pistol"
     SavedInventory(2)="BallisticProV55.X3Knife"
     SavedInventory(3)="BallisticProV55.NRP57Grenade"
	 
     Loadout(0)="BallisticProV55.M50AssaultRifle"
     Loadout(1)="BallisticProV55.M806Pistol"
     Loadout(2)="BallisticProV55.X3Knife"
     Loadout(3)="BallisticProV55.NRP57Grenade"
	 
     ChangeInterval=60.000000
     MenuName="Gear"
     MenuHelp="Choose your starting equipment here."
     bOnlyRelevantToOwner=True
     bAlwaysTick=True
}
