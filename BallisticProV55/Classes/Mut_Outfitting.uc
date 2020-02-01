//=============================================================================
// Mut_Outfitting.
//
// This mutator implements all normal ballistic features, but instead of
// picking up weapons placed in the map, players choose several to start with.
// They can choose one in each of several catagories (melee, sidearm, primary,
// secondary, grenade). Weapon pickups are replaced with ammo packs and ammo
// pickups are removed. Players can still pickup weapons dropped by enemies.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_Outfitting extends Mut_Ballistic
	config(BallisticProV55);

var() globalconfig string 			LoadOut[5];			// Loadout info saved seperately on each client
var() globalconfig string			Killstreaks[2];
var() globalconfig bool				bDebugMode;
var() globalconfig bool				bAllowKillstreaks;

var   Array<ClientOutfittingInterface>	COIPond;	// Jump right in, they won't bite - probably...
var   PlayerController			PCPendingCOI;		// The PlayerController that is about to get its COI

const NUM_GROUPS = 8;

var() globalconfig array<string>	LoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	LoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	LoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	LoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	LoadoutGroup4;	// Weapons available in Grenade Box
var() globalconfig array<string>	LoadoutGroup5;	// Killstreak One
var() globalconfig array<string>	LoadoutGroup6;	// Killstreak Two

struct dummypos
{
	var array<byte> Positions;
};

var()  array<dummypos>	DummyGroups[7];

var   class<weapon>				NetLoadout0;
var   class<weapon>				NetLoadout1;
var   class<weapon>				NetLoadout2;
var   class<weapon>				NetLoadout3;
var   class<weapon>				NetLoadout4;
var   class<weapon>				NetLoadout5;
var   class<weapon>				NetLoadout6;

var   class<Weapon>			NetLoadoutWeapons[255];
var   byte							NetLoadoutGroups;

//Find and save the position of any dummy weapons (for random weapon)

simulated function PreBeginPlay()
{
	local byte i, j;
	
	Super.PreBeginPlay();
	
	if (Role == ROLE_Authority)
		for (i=0; i < NUM_GROUPS; i++)
			for (j=0; j < GetGroup(i).Length; j++)
				if (Right(GetGroup(i)[j], 5) ~= "Dummy")
					DummyGroups[i].Positions[DummyGroups[i].Positions.Length] = j;
}
	

function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (bAllowKillstreaks)
	{
		if (Invasion(Level.Game) != None)
			SpawnInvStreakGR();
		else SpawnStreakGR();
	}
}

function SpawnStreakGR()
{
	local BallisticOutfittingKillstreakRules G;
	
	G = spawn(class'BallisticOutfittingKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	G.Mut = self;
}


function SpawnInvStreakGR()
{
	local BallisticOutfittingInvKillstreakRules H;
	
	H = spawn(class'BallisticOutfittingInvKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = H;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(H);
	H.Mut = self;
}


simulated function string GetGroupItem(byte GroupNum, int ItemNum)
{
	switch (GroupNum)
	{
		case	0:	return LoadoutGroup0[ItemNum];
		case	1:	return LoadoutGroup1[ItemNum];
		case	2:	return LoadoutGroup2[ItemNum];
		case	3:	return LoadoutGroup3[ItemNum];
		case	4:	return LoadoutGroup4[ItemNum];
		case	5:	return LoadoutGroup5[ItemNum];
		case	6:	return LoadoutGroup6[ItemNum];
	}
}

simulated function array<string> GetGroup(byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return LoadoutGroup0;
		case	1:	return LoadoutGroup1;
		case	2:	return LoadoutGroup2;
		case	3:	return LoadoutGroup3;
		case	4:	return LoadoutGroup4;
		case	5:	return LoadoutGroup5;
		case	6:	return LoadoutGroup6;
	}
}

static function array<string> SGetGroup (byte GroupNum)
{
	switch (GroupNum)
	{
		case	0:	return default.LoadoutGroup0;
		case	1:	return default.LoadoutGroup1;
		case	2:	return default.LoadoutGroup2;
		case	3:	return default.LoadoutGroup3;
		case	4:	return default.LoadoutGroup4;
		case	5:	return default.LoadoutGroup5;
		case	6:	return default.LoadoutGroup6;
	}
}

// Give the players their weapons
function ModifyPlayer(Pawn Other)
{
	local int i;
	local class<weapon> W;
	local string Stuff[5];

	Super.ModifyPlayer(Other);
	
	if (Other.LastStartTime > Level.TimeSeconds + 2)
		return;

	//Bots get their weapons here.
	if (Other.Controller != None && Bot(Other.Controller) != None)
	{
		for (i=0;i<5;i++)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
		ChangeLoadout(Other, Stuff);		
		for (i=2;i<5;i+=0)
		{
			if (Stuff[i] == "")		
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			if (Right(Stuff[i], 5) ~= "Dummy")
				Stuff[i] = GetGroup(i)[0];
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
			{
				if (i == 0)
					i = 4;
				else if (i == 3)
					break;
				else
					i--;
				continue;
			}
			SpawnWeapon(W, Other);
			if (i == 0)
				i = 4;
			else if (i == 3)
				break;
			else
				i--;
		}
	}
	
	else if (Other.Controller != None && PlayerController(Other.Controller) != None)
		for (i=0;i<COIPond.length;i++)
			if (COIPond[i].PC == Other.Controller)
			{	COIPond[i].ClientStartLoadout();	return;	}
}

function byte GetStreakLevel(PlayerController C)
{
	return class.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel;
}

function FlagStreak(PlayerController C, byte Level)
{
	class.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel = class.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel | Level;
}

function ResetActiveStreaks(PlayerController C)
{
	local BallisticPlayerReplicationInfo BPRI;
	
	BPRI = class.static.GetBPRI(C.PlayerReplicationInfo);
	if (BPRI != None)
	{
		BPRI.ActiveStreak = 0;
		BPRI.InvKillScore = 0;
	}
}
	
// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local int i, count;
		local array<String> split_string;
	local BallisticPlayerReplicationInfo BPRI;

	if (MutateString ~= "Loadout" && Sender != None)
	{
		for (i=0;i<COIPond.length;i++)
		{
			if (COIPond[i].PC == Sender)
			{
				COIPond[i].ClientOpenLoadoutMenu();
				return;
			}
		}
		COIPond[i] = Spawn(class'ClientOutfittinginterface',Sender);
		COIPond[i].Initialize(self, Sender);
	}
	
	else if (MutateString ~= "Killstreak" && Sender != None)
	{
		if (!bAllowKillstreaks)
			Sender.ClientMessage("Killstreaks are disabled.");
		else
		{
			for (i=0;i<COIPond.length;i++)
			{
				if (COIPond[i].PC == Sender && xPawn(Sender.Pawn) != None)
				{
					BPRI = class.static.GetBPRI(Sender.PlayerReplicationInfo);
					if (BPRI != None && BPRI.RewardLevel > 0)
						GrantKillstreakReward(COIPond[i], Sender.Pawn, BPRI);
					break;
				}
			}
		}
	}
	
	else
	{
		count = Split(MutateString, " ", split_string);

		if (split_string[0] ~= "AddWeapon")
			AddWeapon(Sender, split_string);
		else if (split_string[0] ~= "RemoveWeapon")
			RemoveWeapon(Sender, split_string);
	}
	
	super.Mutate(MutateString, Sender);
}

function AddWeapon(PlayerController Sender, array<String> split_string)
{	
	local int i, loadout_group;
	local array<String> weapons;
	
	local BC_WeaponInfoCache.WeaponInfo WI;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate AddWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate AddWeapon: Usage: mutate addweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	WI = class'BC_WeaponInfoCache'.static.AutoWeaponInfo(split_string[2]);
	
	if (!(WI.ClassName ~= split_string[2]))
	{
		Sender.ClientMessage("Mutate AddWeapon: Weapon not found:"@split_string[2]);
		return;
	}

	loadout_group = int(split_string[1]);
	
	if (loadout_group > 6)
	{
		Sender.ClientMessage("Mutate AddWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = SGetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= WI.ClassName)
		{
			Sender.ClientMessage("Mutate AddWeapon: Loadout group"@loadout_group@"already contains"@WI.ClassName); 
			return;	
		}
	}
	
	weapons[weapons.Length] = split_string[2];
	
	switch(loadout_group)
	{
	case 0:
		class'Mut_Outfitting'.default.LoadoutGroup0 = weapons;
		break;
	case 1:
		class'Mut_Outfitting'.default.LoadoutGroup1 = weapons;
		break;
	case 2:
		class'Mut_Outfitting'.default.LoadoutGroup2 = weapons;
		break;
	case 3:
		class'Mut_Outfitting'.default.LoadoutGroup3 = weapons;
		break;
	case 4:
		class'Mut_Outfitting'.default.LoadoutGroup4 = weapons;
		break;
	case 5:
		class'Mut_Outfitting'.default.LoadoutGroup5 = weapons;
		break;
	case 6:
		class'Mut_Outfitting'.default.LoadoutGroup6 = weapons;
		break;
	}	
	
	Sender.ClientMessage("Mutate AddWeapon: Success - added"@WI.ClassName@"to loadout group"@loadout_group); 
	
	StaticSaveConfig();
}

function RemoveWeapon(PlayerController Sender, array<String> split_string)
{	
	local bool success;
	local int i, loadout_group;
	local array<String> weapons;

	success = false;
	
	if (Level.NetMode != NM_Standalone && !Sender.PlayerReplicationInfo.bAdmin)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Administrator permissions required");
		return;
	}
	
	if (split_string.Length != 3)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Usage: mutate removeweapon <loadout_group_index> <weapon_class_name>");
		return;
	}	
	
	loadout_group = int(split_string[1]);
	
	if (loadout_group > 6)
	{
		Sender.ClientMessage("Mutate RemoveWeapon: Invalid loadout group"@loadout_group);
		return;
	}
	
	weapons = SGetGroup(loadout_group);
	
	for (i = 0; i < weapons.Length; ++i)
	{
		if (weapons[i] ~= split_string[2])
		{
			weapons.Remove(i, 1);
			--i;
			success = true;
		}
	}
	
	if (success)
	{
		switch(loadout_group)
		{
		case 0:
			class'Mut_Outfitting'.default.LoadoutGroup0 = weapons;
			break;
		case 1:
			class'Mut_Outfitting'.default.LoadoutGroup1 = weapons;
			break;
		case 2:
			class'Mut_Outfitting'.default.LoadoutGroup2 = weapons;
			break;
		case 3:
			class'Mut_Outfitting'.default.LoadoutGroup3 = weapons;
			break;
		case 4:
			class'Mut_Outfitting'.default.LoadoutGroup4 = weapons;
			break;
		case 5:
			class'Mut_Outfitting'.default.LoadoutGroup5 = weapons;
			break;
		case 6:
			class'Mut_Outfitting'.default.LoadoutGroup6 = weapons;
			break;
		}	
		
		StaticSaveConfig();
		
		Sender.ClientMessage("Mutate RemoveWeapon: Success - removed"@split_string[2]@"from loadout group"@loadout_group); 
	}
	
	else 
	{
		Sender.ClientMessage("Mutate RemoveWeapon:"@split_string[2]@"not found in loadout group"@loadout_group); 
	}
}

// Goes through inventory and gets rid of stuff that ain't in the loadout
function ChangeLoadout (Pawn P, out string Stuff[5], optional string OldStuff[5])
{
	local Inventory Inv;
	local int Count, i, j;
	local Array<Inventory> BadInv;

	for (Inv=P.Inventory; Inv!=None && Count < 1000; Inv=Inv.Inventory)
	{
		if (Weapon(Inv) != None && Translauncher(Inv)==None)
		{
			for (i=0;i<5;i++)
				if (OldStuff[i] ~= string(Inv.class))
				{
					for (j=0;j<5;j++)
						if (Stuff[j] ~= string(Inv.class))
						{
							Stuff[j] = "";
							break;
						}
					if (j>=5)
						BadInv[BadInv.length] = Inv;
					OldStuff[i] = "";
					break;
				}
		}
		Count++;
	}
	while (BadInv.length > 0)
	{
		if (BadInv[0] != None)
			BadInv[0].Destroy();
		BadInv.Remove(0, 1);
	}
}

// Makes sure client loadout is allowed, then cleans stuff out the inventory and adds the new weapons
function OutfitPlayer(Pawn Other, string Stuff[5], optional string OldStuff[5])
{
	local byte i, j, k, m, DummyFlags;
	local bool bMatch;
	local class<weapon> W;
	
	if (Vehicle(Other) != None && Vehicle(Other).Driver != None)
		Other = Vehicle(Other).Driver;

	// Make sure everything is legit
	for (i=0;i<5;i++)
	{
		// Random weapon handling
		// Tries ten times to pick a weapon which isn't a dummy
		// (i.e. itself) and doesn't match any previous weapon
		// if it fails to do so, returns the first weapon in the group
		if (GetItemName(Stuff[i]) ~= "RandomWeaponDummy")
		{
			for(j=0; j < 10; j++)
			{
				k = Rand(GetGroup(i).length - DummyGroups[i].Positions.length);
				
				for (m = 0; m < DummyGroups[i].Positions.Length; m++)
					if (k == DummyGroups[i].Positions[m])
						k++;
			
				Stuff[i] = GetGroup(i)[k];
					
				bMatch = False;
					
				for (m=0; m<i; m++)
				{
					if (Stuff[i] ~= Stuff[m])
					{
						bMatch = True;
						break;
					}
				}

				if (!bMatch)
					break;

				else if (j == 9)
					Stuff[i] = GetGroup(i)[0];
			}
		}
		
		else if (Right(GetItemName(Stuff[i]), 5) == "Dummy")
			DummyFlags = DummyFlags | (1 << i);
		
		for (j=0;j<GetGroup(i).length;j++)
			if (GetGroup(i)[j] ~= Stuff[i])
				break;
		if (j >= GetGroup(i).length)
			Stuff[i] = GetGroup(i)[Rand(GetGroup(i).length)];
	}
	// Clean out other weapons...
	ChangeLoadout(Other, Stuff, OldStuff);
	// Now spawn it all
	if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = Stuff[1];
		xPawn(Other).RequiredEquipment[1] = Stuff[0];
	}
	
	for (i=2;i<5;i+=0)
	{
		if (!bool(DummyFlags & (1 << i)))
		{
			if (Stuff[i] != "")
			{
				W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
				if (W == None)
					log("Could not load outfitted weapon "$Stuff[i]);
				else
					SpawnWeapon(W, Other);
			}
		}
		if (i == 0)
			i = 4;
		else if (i == 3)
			break;
		else
			i--;
	}
	
	if (DummyFlags != 0)
	{
		j = 0;
		for (i=1; i < 32; i = i << 1)
		{
			if (bool(DummyFlags & i))
			{
				W = class<Weapon>(DynamicLoadObject(Stuff[j], class'Class'));
				if (class<DummyWeapon>(W) != None)
					class<DummyWeapon>(W).static.ApplyEffect(Other, 0, true);
			}
			j++;
		}
	}
}

function GrantKillstreakReward(ClientOutfittingInterface COI, Pawn Other, BallisticPlayerReplicationInfo BPRI)
{
	local class<DummyWeapon> Dummy;
	local string S;
	local byte Index, TargetGroup;
	
	if (bool(BPRI.RewardLevel & 2))
	{
		Index = 1;
		TargetGroup = 6;
	}
	else
	{
		Index = 0;
		TargetGroup = 5;
	}
	
	//Handle dummies
	if (InStr(COI.KillstreakRewards[Index], "Dummy") != -1)
	{

		if (COI.KillstreakRewards[Index] == "BallisticProV55.TeamLevelUpDummy")
		{
			if (!Level.Game.bTeamGame)
				PlayerController(Other.Controller).ClientMessage("You can only donate in a team game.");
			else if(!DonateWeapon(Index+1, Other))
				PlayerController(Other.Controller).ClientMessage("Unable to donate at this time.");
			else	BPRI.RewardLevel = BPRI.RewardLevel & ~(Index + 1);
			return;
		}
		
		Dummy = class<DummyWeapon>(DynamicLoadObject(COI.KillstreakRewards[Index], class'Class'));
		if (Dummy != None && Dummy.static.ApplyEffect(Other, Index, true))
		{
			Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@BPRI.RewardLevel@"spree reward:"@Dummy.default.ItemName);
			BPRI.ActiveStreak = BPRI.ActiveStreak | (Index + 1);
			BPRI.RewardLevel = BPRI.RewardLevel & ~(Index + 1);
		}
			
		return;
	}

	else
	{
		S = SpawnStreakWeapon(COI.KillstreakRewards[Index], Other, TargetGroup);
		
		if (S != "")
		{
			if (InStr(S, "FMD") == -1 && InStr(S, "MAU") == -1)
				Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@Index+1@"spree reward:"@S);
			
			BPRI.ActiveStreak = BPRI.ActiveStreak | (Index + 1);
			BPRI.RewardLevel = BPRI.RewardLevel & ~(Index + 1);
		}
	}
}

function bool DonateWeapon(byte Index, Pawn Other)
{
	local int i;
	local PlayerController C;
	local array<Pawn> Options;
	local Pawn Used;
	local BallisticPlayerReplicationInfo BPRI;
	
	for (i=0;	i < COIPond.Length;	i++)	
	{
		C = COIPond[i].PC;
		if (COIPond[i].KillstreakRewards[0] == "BallisticProV55.TeamLevelUpDummy" || COIPond[i].KillstreakRewards[1] == "BallisticProV55.TeamLevelUpDummy") //Donation isn't intended to be used as an advantage
			continue;
		if (BallisticPawn(C.Pawn) != None //ballisticpawn
		&& C != Other.Controller  //not us
		&& C.PlayerReplicationInfo != None //has pri
		&& C.PlayerReplicationInfo.Team == Other.PlayerReplicationInfo.Team) //on the same team
		{
			if (!bool(class.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel & Index)) //doesn't already have a streak of the level we're trying to pass
				Options[Options.Length] = C.Pawn;
		}
	}
	
	if (Options.Length == 0)
		return false;
	
	if (Options.Length == 1)
		Used = Options[0];
	
	else Used = Options[Rand(Options.Length)];
		
	for (i=0;i<COIPond.length;i++)
	{
		if (COIPond[i].PC == Used.Controller)
		{
			BPRI = class.static.GetBPRI(Used.PlayerReplicationInfo);
			if (BPRI != None)
				BPRI.RewardLevel = BPRI.RewardLevel | Index;
			else return false;
			Other.ClientMessage("You passed your Killstreak"@Index@"to"@Used.PlayerReplicationInfo.PlayerName$".");
			Used.ClientMessage("Received Killstreak"@Index@"from"@Other.PlayerReplicationInfo.PlayerName$".");
			Used.ReceiveLocalizedMessage(class'BallisticKillstreakMessage', -Index);
			Other.Controller.AwardAdrenaline(40 * Index);

			return true;
		}
	}
	return false;
}

function String SpawnStreakWeapon(string WeaponString, Pawn Other, byte GroupSlot)
{
	local class<Weapon> KR;
	local int j, k, m;
	
	//Dummies are likely to come in here if the target also has Donation set
	if (InStr(WeaponString, "Dummy") != -1)
	{
		k = Rand(GetGroup(GroupSlot).length - DummyGroups[GroupSlot].Positions.length);
				
		for (m = 0; m < DummyGroups[GroupSlot].Positions.Length; m++)
			if (k == DummyGroups[GroupSlot].Positions[m])
				k++;
			
		WeaponString = GetGroup(GroupSlot)[k];		
	}
	else
	{		
		//Check validity.
		for (j=0; j <= GetGroup(GroupSlot).length; j++)
		{
			if ( j == GetGroup(GroupSlot).length )
			{
				PlayerController(Other.Controller).ClientMessage("The selected Killstreak reward weapon is not available on this server, giving the default weapon.");
				WeaponString = GetGroup(GroupSlot)[0];
				break;
			}
			
			if (GetGroup(GroupSlot)[j] ~= WeaponString)
				break;
		}
	}
	
	KR = class<Weapon>(DynamicLoadObject(WeaponString,class'Class'));
		
	if (KR == None)
		return "";
	
	else
	{
		SpawnWeapon(KR, Other);
		if (class<BallisticWeapon>(KR) != None && !class<BallisticWeapon>(KR).default.bNoMag)
		{
			SpawnAmmo(KR.default.FireModeClass[0].default.AmmoClass, Other);
			if (KR.default.FireModeClass[0].default.AmmoClass != KR.default.FireModeClass[1].default.AmmoClass)
				SpawnAmmo(KR.default.FireModeClass[1].default.AmmoClass, Other);
		}
		
		if (BallisticPawn(Other) != None)
			BallisticPawn(Other).bActiveKillstreak = True;
			
		return KR.default.ItemName;
	}
}

static function Weapon SpawnWeapon(class<weapon> newClass, Pawn P)
{
	local Weapon newWeapon;
	//local BallisticPlayerReplicationInfo BPRI;
	//local Inventory Inv;

    if( (newClass!=None) && P != None)
    {
		newWeapon = Weapon(P.FindInventoryType(newClass));
		if (newWeapon == None || BallisticHandgun(newWeapon) != None)
		{
			newWeapon = P.Spawn(newClass,,,P.Location);
			if( newWeapon != None )
			{
				newWeapon.GiveTo(P);
			}
			if (BallisticHandgun(newWeapon) != None && BallisticHandgun(newWeapon).default.bShouldDualInLoadout)
			{
				newWeapon = P.Spawn(newClass,,,P.Location);
				if( newWeapon != None )
					newWeapon.GiveTo(P);
			}
			//Hack for bots - stops them complaining
			if (Bot(P.Controller) != None && P.Weapon == None && P.PendingWeapon == None)
			{
				P.PendingWeapon = newWeapon;
				P.ChangedWeapon();
			}
			
			return newWeapon;
		}
		else
		{
			newWeapon.AddAmmo(newClass.default.AmmoClass[0].default.InitialAmount, 0);
			newWeapon.AddAmmo(newClass.default.AmmoClass[1].default.InitialAmount, 1);
			if (BallisticWeapon(newWeapon) != None)
			{
				BallisticWeapon(newWeapon).MagAmmo = BallisticWeapon(newWeapon).default.MagAmmo;
				BallisticWeapon(newWeapon).bNeedReload = False;
				if (!P.IsLocallyControlled())
					BallisticWeapon(newWeapon).ClientWeaponReloaded();
			}
		}
    }
	
	return None;
}


// Do not spawn a default weapon yet...
function class<Weapon> MyDefaultWeapon()
{
	return None;
}

function Class<Inventory> GetInventoryClass(string InventoryClassName)
{
	return None;
}

simulated event Timer()
{
	super.Timer();
	if (PCPendingCOI == None)
		return;
	COIPond[COIPond.length] = Spawn(class'ClientOutfittinginterface',PCPendingCOI);
	COIPond[COIPond.length-1].Initialize(self, PCPendingCOI);
	PCPendingCOI = None;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j;
	
	bSuperRelevant = 0;
	
	// Give players their COI. Everyone needs a COI, right?
	if (PlayerController(Other) != None)
	{
		if (PCPendingCOI != None)
			Timer();
		SetTimer(0.1, false);
		PCPendingCOI = PlayerController(Other);
	}

	else if (xPawn(Other) != None)
	{
		xPawn(Other).RequiredEquipment[0] = "";
		xPawn(Other).RequiredEquipment[1] = "";
		return true;
	}
	
	// Only allow weapons that are in the loadout groups
	else if (Weapon(Other) != None && (!Weapon(Other).bNoInstagibReplace) && Translauncher(Other)==None)
	{
		for (i=0;i<7;i++)
			for (j=0;j<GetGroup(i).length;j++)
				if (GetGroup(i)[j] ~= string(Other.class))
					return true;
		return false;
	}
	// No weapon pickups unless they are dropped. Dropped BWs are owned by the weapon that dropped them
	else if (WeaponPickup(Other) != None && Other.Owner == None)
		return false;
	// No ammo pickups
	else if (Ammo(Other) != None && IP_AmmoPack(Other) == None)
	{
		Pickup(Other).myMarker.bBlocked = True;
		return false;
	}
	// Lockers replaced with ammo packs
	else if (WeaponLocker(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
		{
			WeaponLocker(Other).myMarker.bBlocked = True;
			Other.GotoState('Disabled');
			return false;
		}
	}
	// No bases. Weapon pickups replaced with ammo packs
	else if (xWeaponBase(Other) != None)
	{
		if (!SpawnNewItem(-1, Other, class'IP_AmmoPack'))
			return false;
	}
	else if (xPickupBase(Other) != None)
	{
		Other.bHidden=true;
		if (xPickupBase(Other).myMarker != None)
			xPickupBase(Other).myMarker.bBlocked = True;
		if (xPickupBase(Other).myEmitter != None)
			xPickupBase(Other).myEmitter.Destroy();
	}
	// Do terrible, evil, horrendous ballistic deeds unto the other stuff
	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     LoadOut(0)="BallisticProV55.X3Knife"
     LoadOut(1)="BallisticProV55.M806Pistol"
     LoadOut(2)="BallisticProV55.M763Shotgun"
     LoadOut(3)="BallisticProV55.M50AssaultRifle"
     LoadOut(4)="BallisticProV55.NRP57Grenade"
     Killstreaks(0)="BallisticProV55.RX22AFlamer"
     Killstreaks(1)="BallisticProV55.MRocketLauncher"
     bAllowKillstreaks=True
     LoadoutGroup0(0)="BallisticProV55.X3Knife"
     LoadoutGroup0(1)="BallisticProV55.A909SkrithBlades"
     LoadoutGroup0(2)="BallisticProV55.EKS43Katana"
     LoadoutGroup0(3)="BallisticProV55.X4Knife"
     LoadoutGroup1(0)="BallisticProV55.M806Pistol"
     LoadoutGroup1(1)="BallisticProV55.A42SkrithPistol"
     LoadoutGroup1(2)="BallisticProV55.MRT6Shotgun"
     LoadoutGroup1(3)="BallisticProV55.XK2SubMachinegun"
     LoadoutGroup1(4)="BallisticProV55.D49Revolver"
     LoadoutGroup1(5)="BallisticProV55.RS8Pistol"
     LoadoutGroup1(6)="BallisticProV55.XRS10SubMachinegun"
     LoadoutGroup1(7)="BallisticProV55.Fifty9MachinePistol"
     LoadoutGroup1(8)="BallisticProV55.AM67Pistol"
     LoadoutGroup1(9)="BallisticProV55.GRS9Pistol"
     LoadoutGroup1(10)="BallisticProV55.leMatRevolver"
     LoadoutGroup1(11)="BallisticProV55.BOGPPistol"
     LoadoutGroup1(12)="BallisticProV55.MD24Pistol"
     LoadoutGroup2(0)="BallisticProV55.M50AssaultRifle"
     LoadoutGroup2(1)="BallisticProV55.M763Shotgun"
     LoadoutGroup2(2)="BallisticProV55.A73SkrithRifle"
     LoadoutGroup2(3)="BallisticProV55.M353Machinegun"
     LoadoutGroup2(4)="BallisticProV55.M925Machinegun"
     LoadoutGroup2(5)="BallisticProV55.G5Bazooka"
     LoadoutGroup2(6)="BallisticProV55.R78Rifle"
     LoadoutGroup2(7)="BallisticProV55.M75Railgun"
     LoadoutGroup2(8)="BallisticProV55.M290Shotgun"
     LoadoutGroup2(9)="BallisticProV55.MRS138Shotgun"
     LoadoutGroup2(10)="BallisticProV55.SRS900Rifle"
     LoadoutGroup2(11)="BallisticProV55.M806Pistol"
     LoadoutGroup2(12)="BallisticProV55.A42SkrithPistol"
     LoadoutGroup2(13)="BallisticProV55.MRT6Shotgun"
     LoadoutGroup2(14)="BallisticProV55.XK2SubMachinegun"
     LoadoutGroup2(15)="BallisticProV55.D49Revolver"
     LoadoutGroup2(16)="BallisticProV55.RS8Pistol"
     LoadoutGroup2(17)="BallisticProV55.XRS10SubMachinegun"
     LoadoutGroup2(18)="BallisticProV55.Fifty9MachinePistol"
     LoadoutGroup2(19)="BallisticProV55.AM67Pistol"
     LoadoutGroup2(20)="BallisticProV55.SARAssaultRifle"
     LoadoutGroup2(21)="BallisticProV55.R9RangerRifle"
     LoadoutGroup2(22)="BallisticProV55.leMatRevolver"
     LoadoutGroup2(23)="BallisticProV55.GRS9Pistol"
     LoadoutGroup2(24)="BallisticProV55.MarlinRifle"
     LoadoutGroup2(25)="BallisticProV55.E23PlasmaRifle"
     LoadoutGroup2(26)="BallisticProV55.M46AssaultRifle"
     LoadoutGroup2(27)="BallisticProV55.A500Reptile"
     LoadoutGroup2(28)="BallisticProV55.MD24Pistol"
     LoadoutGroup2(29)="BallisticProV55.BOGPPistol"
     LoadoutGroup2(30)="BallisticProV55.XMK5SubMachinegun"
     LoadoutGroup3(0)="BallisticProV55.M50AssaultRifle"
     LoadoutGroup3(1)="BallisticProV55.M763Shotgun"
     LoadoutGroup3(2)="BallisticProV55.A73SkrithRifle"
     LoadoutGroup3(3)="BallisticProV55.M353Machinegun"
     LoadoutGroup3(4)="BallisticProV55.M925Machinegun"
     LoadoutGroup3(5)="BallisticProV55.G5Bazooka"
     LoadoutGroup3(6)="BallisticProV55.R78Rifle"
     LoadoutGroup3(7)="BallisticProV55.M75Railgun"
     LoadoutGroup3(8)="BallisticProV55.M290Shotgun"
     LoadoutGroup3(9)="BallisticProV55.MRS138Shotgun"
     LoadoutGroup3(10)="BallisticProV55.SRS900Rifle"
     LoadoutGroup3(11)="BallisticProV55.HVCMk9LightningGun"
     LoadoutGroup3(12)="BallisticProV55.RX22AFlamer"
     LoadoutGroup3(13)="BallisticProV55.XMV850Minigun"
     LoadoutGroup3(14)="BallisticProV55.SARAssaultRifle"
     LoadoutGroup3(15)="BallisticProV55.R9RangerRifle"
     LoadoutGroup3(16)="BallisticProV55.MarlinRifle"
     LoadoutGroup3(17)="BallisticProV55.MRocketLauncher"
     LoadoutGroup3(18)="BallisticProV55.MACWeapon"
     LoadoutGroup3(19)="BallisticProV55.RSDarkStar"
     LoadoutGroup3(20)="BallisticProV55.RSNovaStaff"
     LoadoutGroup3(21)="BallisticProV55.E23PlasmaRifle"
     LoadoutGroup3(22)="BallisticProV55.M46AssaultRifle"
     LoadoutGroup3(23)="BallisticProV55.XMK5SubMachinegun"
     LoadoutGroup3(24)="BallisticProV55.A500Reptile"
     LoadoutGroup4(0)="BallisticProV55.NRP57Grenade"
     LoadoutGroup4(1)="BallisticProV55.FP7Grenade"
     LoadoutGroup4(2)="BallisticProV55.FP9Explosive"
     LoadoutGroup4(3)="BallisticProV55.BX5Mine"
     LoadoutGroup4(4)="BallisticProV55.T10Grenade"
     LoadoutGroup5(0)="BallisticProV55.RX22AFlamer"
     LoadoutGroup6(0)="BallisticProV55.MRocketLauncher"
     bHideLockers=True
     FriendlyName="BallisticPro: Loadout"
     Description="Play Ballistic Weapons, but instead of picking up weapons, you can choose five to start with, Melee, Sidearm, Primary, Secondary and Grenade. Ammo Packs replace weapon pickups and extra weapons can be taken from your enemies.||http://www.runestorm.com"
}
