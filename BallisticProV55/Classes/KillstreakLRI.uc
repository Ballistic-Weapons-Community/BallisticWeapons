//=============================================================================
// ClientKillstreakInterface.
//
// Replication channel for killstreak information to the mutator.
//=============================================================================
class KillstreakLRI extends LinkedReplicationInfo;

const MAX_GROUPS = 2;

var int					ListenRetryCount;

var Mut_Killstreak 		Mut;
var Controller 			myController;

//Groups of weapon names on the client's side.
var array<string>		Streak1s;
var array<string>		Streak2s;

var array<string> 		Killstreaks[2];
var array<byte> 		Layouts[2];
var array<byte> 		Camos[2];

var bool				bWeaponsReady, bPendingLoadoutSave, bClientAttemptedGetStreakList;

var class<Weapon> 		LastStreaks[2];

var localized string 	MenuName, MenuHelp; // Stuff for the menu

var private editconst bool	bMenuModified, bMenuAdd;

var byte 				RewardLevel; 		// streaks in reserve
var byte 				ActiveStreak; 		// active streaks - not replicated
var int 				InvKillScore;		// Used for Invasion streaks

replication
{
	reliable if (Role < ROLE_Authority)
		ServerUpdateStreakChoices, ServerGetStreakList;
	reliable if (Role == ROLE_Authority)
		ClientGetStreakChoices, ClientProcessWeapon, ClientProcessWeaponEnd, LastStreaks;
	reliable if (Role == ROLE_Authority && bNetInitial)
		myController;
	reliable if (Role == ROLE_Authority)
		RewardLevel;
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
			if (Mut_Killstreak(M) != None)
			{
				Mut = Mut_Killstreak(M);
				break;	
			}
		}
	}
	
	// awkward switch because of a timing issue
	// within PostNetBeginPlay, we have the controller, but we don't have the viewport
	// the viewport is used by IsLocallyControlled() to know whether we're on the remote side
	// this leaves us having to retry on listen servers
	switch (Level.NetMode)
	{
		case NM_StandAlone:
		case NM_Client:
			ServerGetStreakList();
			break;
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
	if (Level.NetMode != NM_ListenServer)	
	{	
		SetTimer(0.0, false);
		return;
	}
	
	if (PlayerController(myController) != None && Viewport(PlayerController(myController).Player) != None)
	{
		ServerGetStreakList();
		SetTimer(0.0, false);
	}
	
	else if (Level.NetMode == NM_ListenServer)
	{
		ListenRetryCount--;
		
		if (ListenRetryCount == 0)
			SetTimer(0.0, false);
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
	local int index;

	if (AIController(myController) != None)
	{
		Disable('Tick');
		return;
	}

	Menu = UT2K4PlayerLoginMenu(GUIController(PlayerController(myController).Player.GUIController).FindPersistentMenuByName( UnrealPlayer(myController).LoginMenuClass ));

	if( Menu != None )
	{
		// Look for Conflict's gear tab
		index = Menu.c_Main.TabIndex("Gear");

		if (index == -1)
			index = 0; // make first if gear tab is not present

		else 
			index += 1; // insert after gear tab

		Panel = Menu.c_Main.InsertTab(index, MenuName, string( GetMenuClass() ),, MenuHelp);
		bMenuModified=True;
		Disable('Tick');
	}
}

protected simulated function class GetMenuClass()
{
	return class'MidGameTab_Killstreaks';
}

function ServerGetStreakList()
{
	SendStreaks();
}

// Returns the weapon group.
simulated function array<string> GetGroup(byte GroupNum)
{
	if (Role == ROLE_Authority)
		return Mut.GetGroup(GroupNum);

	switch (GroupNum)
	{
		case	0:	return Streak1s;
		case	1:	return Streak2s;
	}
}

//Returns the weapon at the specific index.
simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	if (Role == ROLE_Authority)
		return Mut.GetGroupItem(GroupNum, ItemNum);
	switch (GroupNum)
	{
		case	0:	return Streak1s[ItemNum];
		case	1:	return Streak2s[ItemNum];
	}
}

//Returns the number of weapons in the group.
simulated function int GroupLength(byte GroupNum)
{
	if (Role == ROLE_Authority)
	{
		switch (GroupNum)
		{
			case 0: return Mut.Streak1s.length;
			case 1: return Mut.Streak2s.length;
		}
	}
	else
	{
		switch (GroupNum)
		{
			case 0: return Streak1s.length;
			case 1: return Streak2s.length;
		}
	}

	return -1;
}


function bool IsInList (out array<string> List, string Test, optional out int Index)
{
	for(Index = 0 ; Index < List.length; Index++)
		if (List[Index] == Test)
			return true;

	return false;
}

//Goes through the available loadout weapons, adding them to the array and continuing if the loaded weapon is invalid.
//Boxes indicate which group the weapon is in.
//Uses bitwise operations on Boxes to handle weapons which exist in multiple groups at once.
function SendStreaks()
{
	local int i, j;
	local array<string> Weaps;
	local array<byte>	Boxes;

	if (bClientAttemptedGetStreakList)
		return;

	bClientAttemptedGetStreakList = true;

	//Go through the available loadout weapons, adding them to the Weaps array. Continue if there is no weapon in the slot
	for (i = 0; i < Mut.Streak1s.length; i++)
	{
		if (Mut.Streak1s[i] == "")
			continue;
			
		Weaps[Weaps.length] = Mut.Streak1s[i];
		Boxes[Boxes.length] = 1;
	}

	for (i = 0; i < Mut.Streak2s.length; i++)
	{
		if (Mut.Streak2s[i] == "")
			continue;
		
		//If the current weapon is already in the weapon list, update its Boxes entry to indicate it's in multiple slots
		//This shouldn't really happen
		if (IsInList(Weaps, Mut.Streak2s[i], j))
			Boxes[j] += 2;
		else
		{
			//Insert weapon at end
			Weaps[Weaps.length] = Mut.Streak2s[i];
			//Insert slot info
			Boxes[Boxes.length] = 2;
		}
	}

	for (i = 0; i < Weaps.length; i++)
		ClientProcessWeapon(Weaps[i], Boxes[i]);
		
	//Last weapon, terminate
	ClientProcessWeaponEnd();
}

//Uses "Boxes" to determine which groups a weapon to be added to
//Flags are checked per weapon and if fifth flag is up, the weapons
//have all been sent
simulated function ClientProcessWeapon (string WeaponName, byte Boxes)
{
	if ((Boxes & 1) > 0)
		Streak1s[Streak1s.length] = WeaponName;
	if ((Boxes & 2) > 0)
		Streak2s[Streak2s.length] = WeaponName;
}

simulated function ClientProcessWeaponEnd()
{
	bWeaponsReady = true;
	
	UpdateStreakChoices();
}

simulated function UpdateStreakChoices()
{
	ServerUpdateStreakChoices(
		class'KillstreakConfig'.default.Killstreaks[0], 
		class'KillstreakConfig'.default.Killstreaks[1],
		class'KillstreakConfig'.default.Layouts[0],
		class'KillstreakConfig'.default.Layouts[1],
		class'KillstreakConfig'.default.Camos[0],
		class'KillstreakConfig'.default.Camos[1]
		
	);
}

// Called from server. Tells client to send back loadout info.
// Called at respawn of player.
simulated function ClientGetStreakChoices()
{
	UpdateStreakChoices();
}

function ServerUpdateStreakChoices(string Streak1, string Streak2, byte Layout1, byte Layout2, byte Camo1, byte Camo2)
{
	local int i;
	
	Killstreaks[0] = Streak1;
	Killstreaks[1] = Streak2;
	Layouts[0] = Layout1;
	Layouts[1] = Layout2;
	Camos[0] = Camo1;
	Camos[1] = Camo2;
		
	for (i=0; i < MAX_GROUPS; i++)
	{
		LastStreaks[i] = class<Weapon>(DynamicLoadObject(Killstreaks[i], Class'Class', True));

		if (BallisticPlayer(myController) != None)
			BallisticPlayer(myController).LastStreaks[i] = LastStreaks[i];
	}
}

defaultproperties
{
	ListenRetryCount = 10
	MenuName="Killstreaks"
    MenuHelp="Choose your killstreak weapons here."
	bOnlyRelevantToOwner=True
	bAlwaysTick=True
}
