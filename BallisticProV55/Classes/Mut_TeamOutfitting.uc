//=============================================================================
// Mut_TeamOutfitting.
//
// It's Loadout, but per-team.
//=============================================================================
class Mut_TeamOutfitting extends Mut_Ballistic
	config(BallisticProV55);

var() config string 			LoadOut[5];			// Loadout info saved seperately on each client
var() config string			Killstreaks[2];
var() config bool				bAllowKillstreaks;

var   Array<ClientTeamOutfittingInterface>	COIPond;			// Jump right in, they won't bite - probably...
var   PlayerController							PCPendingCOI;	// The PlayerController that is about to get its COI

const NUM_GROUPS = 14;

//Would have preferred to use structs for this, but Random Weapon would have been a bitch.
var() globalconfig array<string>	RedLoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	RedLoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	RedLoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	RedLoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	RedLoadoutGroup4;	// Weapons available in Grenade Box
var() globalconfig array<string>	RedLoadoutGroup5;	// Killstreak One
var() globalconfig array<string>	RedLoadoutGroup6;	// Killstreak Two

var() globalconfig array<string>	BlueLoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	BlueLoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	BlueLoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	BlueLoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	BlueLoadoutGroup4;	// Weapons available in Grenade Box
var() globalconfig array<string>	BlueLoadoutGroup5;	// Killstreak One
var() globalconfig array<string>	BlueLoadoutGroup6;	// Killstreak Two


var() globalconfig bool				bAllowAllWeaponry; // Allow weaponry even if it's not present in the loadout groups

struct dummypos
{
	var array<byte> Positions;
};

var()  array<dummypos>	DummyGroups[NUM_GROUPS];

var   class<weapon>				NetLoadout0;
var   class<weapon>				NetLoadout1;
var   class<weapon>				NetLoadout2;
var   class<weapon>				NetLoadout3;
var   class<weapon>				NetLoadout4;
var   class<weapon>				NetLoadout5;
var   class<weapon>				NetLoadout6;
var   class<weapon>				NetLoadout7;

var   class<Weapon>			NetLoadoutWeapons[255];
var   byte							NetLoadoutGroups;

//Find and save the position of any dummy weapons (for random weapon)
function BeginPlay()
{
	local byte i, j, k;
	
	Super.BeginPlay();
	
	for (i=0; i < (NUM_GROUPS/2); i++)
		for (j=0; j < 2; j++)
			for (k=0; k < GetGroup(i,j).Length; k++)
				if (Right(GetGroup(i,j)[k], 5) ~= "Dummy")
					DummyGroups[i].Positions[DummyGroups[i].Positions.Length] = k;
}
	
function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (bAllowKillstreaks)
		SpawnStreakGR();
}

function SpawnStreakGR()
{
	local BallisticTeamOutfittingKillstreakRules G;
	
	G = spawn(class'BallisticTeamOutfittingKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	G.Mut = self;
}

simulated function string GetGroupItem(byte GroupNum, int ItemNum, byte inTeam)
{
	if (inTeam == 1)
	{
		switch (GroupNum)
		{
			case	0:	return BlueLoadoutGroup0[ItemNum];
			case	1:	return BlueLoadoutGroup1[ItemNum];
			case	2:	return BlueLoadoutGroup2[ItemNum];
			case	3:	return BlueLoadoutGroup3[ItemNum];
			case	4:	return BlueLoadoutGroup4[ItemNum];
			case	5:	return BlueLoadoutGroup5[ItemNum];
			case	6:	return BlueLoadoutGroup6[ItemNum];
		}
	}
	else
	{
		switch (GroupNum)
		{
			case	0:	return RedLoadoutGroup0[ItemNum];
			case	1:	return RedLoadoutGroup1[ItemNum];
			case	2:	return RedLoadoutGroup2[ItemNum];
			case	3:	return RedLoadoutGroup3[ItemNum];
			case	4:	return RedLoadoutGroup4[ItemNum];
			case	5:	return RedLoadoutGroup5[ItemNum];
			case	6:	return RedLoadoutGroup6[ItemNum];
		}
	}
}

simulated function array<string> GetGroup(byte GroupNum, byte inTeam)
{
	if (inTeam == 1)
	{
		switch (GroupNum)
		{
			case	0:	return BlueLoadoutGroup0;
			case	1:	return BlueLoadoutGroup1;
			case	2:	return BlueLoadoutGroup2;
			case	3:	return BlueLoadoutGroup3;
			case	4:	return BlueLoadoutGroup4;
			case	5:	return BlueLoadoutGroup5;
			case	6:	return BlueLoadoutGroup6;
		}
	}
	else
	{
		switch (GroupNum)
		{
			case	0:	return RedLoadoutGroup0;
			case	1:	return RedLoadoutGroup1;
			case	2:	return RedLoadoutGroup2;
			case	3:	return RedLoadoutGroup3;
			case	4:	return RedLoadoutGroup4;
			case	5:	return RedLoadoutGroup5;
			case	6:	return RedLoadoutGroup6;
		}
	}
}

static function array<string> SGetGroup (byte GroupNum, byte inTeam)
{
	if (inTeam == 1)
	{
		switch (GroupNum)
		{
		case	0:	return default.BlueLoadoutGroup0;
		case	1:	return default.BlueLoadoutGroup1;
		case	2:	return default.BlueLoadoutGroup2;
		case	3:	return default.BlueLoadoutGroup3;
		case	4:	return default.BlueLoadoutGroup4;
		case	5:	return default.BlueLoadoutGroup5;
		case	6:	return default.BlueLoadoutGroup6;
		}
	}
	else
	{
		switch (GroupNum)
		{
		case	0:	return default.RedLoadoutGroup0;
		case	1:	return default.RedLoadoutGroup1;
		case	2:	return default.RedLoadoutGroup2;
		case	3:	return default.RedLoadoutGroup3;
		case	4:	return default.RedLoadoutGroup4;
		case	5:	return default.RedLoadoutGroup5;
		case	6:	return default.RedLoadoutGroup6;
		}
	}
}

// Give the players their weapons.
// Bots are equipped here.
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
			Stuff[i] = GetGroup(i,Other.GetTeamNum())[Rand(GetGroup(i,Other.GetTeamNum()).length)];
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
				Stuff[i] = GetGroup(i, Other.GetTeamNum())[0];
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
	return class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel;
}

function FlagStreak(PlayerController C, byte Level)
{
	class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel = class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo).RewardLevel | Level;
}

function ResetActiveStreaks(PlayerController C)
{
	local BallisticPlayerReplicationInfo BPRI;
	
	BPRI = class'Mut_Ballistic'.static.GetBPRI(C.PlayerReplicationInfo);
	if (BPRI != None)
	{
		BPRI.ActiveStreak = 0;
		BPRI.InvKillScore = 0;
	}
}
	
// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local int i;
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
		COIPond[i] = Spawn(class'ClientTeamOutfittinginterface',Sender);
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
					BPRI = class'Mut_Ballistic'.static.GetBPRI(Sender.PlayerReplicationInfo);
					if (BPRI != None && BPRI.RewardLevel > 0)
						GrantKillstreakReward(COIPond[i], Sender.Pawn, BPRI);
					break;
				}
			}
		}
	}
	
	super.Mutate(MutateString, Sender);
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
				k = Rand(GetGroup(i, Other.GetTeamNum()).length - DummyGroups[i + (Other.GetTeamNum() * (NUM_GROUPS/2))].Positions.length); //FIXME
				
				for (m = 0; m < DummyGroups[i].Positions.Length; m++)
					if (k == DummyGroups[i].Positions[m])
						k++;
			
				Stuff[i] = GetGroup(i, Other.GetTeamNum())[k];
					
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
					Stuff[i] = GetGroup(i, Other.GetTeamNum())[0];
			}
		}
		
		else if (Right(GetItemName(Stuff[i]), 5) == "Dummy")
			DummyFlags = DummyFlags | (1 << i);
		
		for (j=0;j<GetGroup(i, Other.GetTeamNum()).length;j++)
			if (GetGroup(i, Other.GetTeamNum())[j] ~= Stuff[i])
				break;
		if (j >= GetGroup(i, Other.GetTeamNum()).length)
			Stuff[i] = GetGroup(i, Other.GetTeamNum())[Rand(GetGroup(i, Other.GetTeamNum()).length)];
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

function GrantKillstreakReward(ClientTeamOutfittingInterface COI, Pawn Other, BallisticPlayerReplicationInfo BPRI)
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
				Level.Game.Broadcast(self, Other.PlayerReplicationInfo.PlayerName@"received a Level"@BPRI.RewardLevel@"spree reward:"@S);
			
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

function string SpawnStreakWeapon(string WeaponString, Pawn Other, byte GroupSlot)
{
	local class<Weapon> KR;
	local int j, k, m;
	
	//Dummies are likely to come in here if the target also has Donation set
	if (InStr(WeaponString, "Dummy") != -1)
	{
		k = Rand(GetGroup(GroupSlot, Other.GetTeamNum()).length - DummyGroups[GroupSlot].Positions.length);
				
		for (m = 0; m < DummyGroups[GroupSlot].Positions.Length; m++)
			if (k == DummyGroups[GroupSlot].Positions[m])
				k++;
			
		WeaponString = GetGroup(GroupSlot, Other.GetTeamNum())[k];		
	}

	else
	{		
		//Check validity.
		for (j=0; j <= GetGroup(GroupSlot,Other.GetTeamNum()).length; j++)
		{
			if ( j == GetGroup(GroupSlot,Other.GetTeamNum()).length )
			{
				PlayerController(Other.Controller).ClientMessage("The selected Killstreak reward weapon is not available on this server, giving the default weapon.");
				WeaponString = GetGroup(GroupSlot,Other.GetTeamNum())[0];
				break;
			}
			
			if (GetGroup(GroupSlot,Other.GetTeamNum())[j] ~= WeaponString)
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

    if( (newClass!=None) && P != None)
    {
		newWeapon = Weapon(P.FindInventoryType(newClass));
		if (newWeapon == None || BallisticHandgun(newWeapon) != None)
		{
			newWeapon = P.Spawn(newClass,,,P.Location);
			if( newWeapon != None )
				newWeapon.GiveTo(P);
			if (P.Weapon == None && P.PendingWeapon == None)
			{
				P.PendingWeapon = newWeapon;
				P.ChangedWeapon();
			}
			
			return newWeapon;
		}
		else newWeapon.MaxOutAmmo(); //double loading
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
	COIPond[COIPond.length] = Spawn(class'ClientTeamOutfittingInterface',PCPendingCOI);
	COIPond[COIPond.length-1].Initialize(self, PCPendingCOI);
	PCPendingCOI = None;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i, j, k;
	
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
		for (i=0;i<8;i++)
			for(j=0;j<2;j++)
				for (k=0;k<GetGroup(i,j).length;k++)
					if (GetGroup(i,j)[k] ~= string(Other.class))
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

//Don't allow this mutator to be used in one-team GTs
function bool MutatorIsAllowed()
{
    return Level.Game.bTeamGame;
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
     RedLoadoutGroup0(0)="BallisticProV55.X3Knife"
     RedLoadoutGroup0(1)="BallisticProV55.A909SkrithBlades"
     RedLoadoutGroup0(2)="BallisticProV55.EKS43Katana"
     RedLoadoutGroup0(3)="BallisticProV55.X4Knife"
     RedLoadoutGroup1(0)="BallisticProV55.M806Pistol"
     RedLoadoutGroup1(1)="BallisticProV55.A42SkrithPistol"
     RedLoadoutGroup1(2)="BallisticProV55.MRT6Shotgun"
     RedLoadoutGroup1(3)="BallisticProV55.XK2SubMachinegun"
     RedLoadoutGroup1(4)="BallisticProV55.D49Revolver"
     RedLoadoutGroup1(5)="BallisticProV55.RS8Pistol"
     RedLoadoutGroup1(6)="BallisticProV55.XRS10SubMachinegun"
     RedLoadoutGroup1(7)="BallisticProV55.Fifty9MachinePistol"
     RedLoadoutGroup1(8)="BallisticProV55.AM67Pistol"
     RedLoadoutGroup1(9)="BallisticProV55.GRS9Pistol"
     RedLoadoutGroup1(10)="BallisticProV55.leMatRevolver"
     RedLoadoutGroup1(11)="BallisticProV55.BOGPPistol"
     RedLoadoutGroup1(12)="BallisticProV55.MD24Pistol"
     RedLoadoutGroup2(0)="BallisticProV55.M50AssaultRifle"
     RedLoadoutGroup2(1)="BallisticProV55.M763Shotgun"
     RedLoadoutGroup2(2)="BallisticProV55.A73SkrithRifle"
     RedLoadoutGroup2(3)="BallisticProV55.M353Machinegun"
     RedLoadoutGroup2(4)="BallisticProV55.M925Machinegun"
     RedLoadoutGroup2(5)="BallisticProV55.G5Bazooka"
     RedLoadoutGroup2(6)="BallisticProV55.R78Rifle"
     RedLoadoutGroup2(7)="BallisticProV55.MRS138Shotgun"
     RedLoadoutGroup2(8)="BallisticProV55.SRS900Rifle"
     RedLoadoutGroup2(9)="BallisticProV55.M806Pistol"
     RedLoadoutGroup2(10)="BallisticProV55.A42SkrithPistol"
     RedLoadoutGroup2(11)="BallisticProV55.MRT6Shotgun"
     RedLoadoutGroup2(12)="BallisticProV55.XK2SubMachinegun"
     RedLoadoutGroup2(13)="BallisticProV55.D49Revolver"
     RedLoadoutGroup2(14)="BallisticProV55.RS8Pistol"
     RedLoadoutGroup2(15)="BallisticProV55.XRS10SubMachinegun"
     RedLoadoutGroup2(16)="BallisticProV55.Fifty9MachinePistol"
     RedLoadoutGroup2(17)="BallisticProV55.AM67Pistol"
     RedLoadoutGroup2(18)="BallisticProV55.SARAssaultRifle"
     RedLoadoutGroup2(19)="BallisticProV55.R9RangerRifle"
     RedLoadoutGroup2(20)="BallisticProV55.leMatRevolver"
     RedLoadoutGroup2(21)="BallisticProV55.GRS9Pistol"
     RedLoadoutGroup2(22)="BallisticProV55.MarlinRifle"
     RedLoadoutGroup2(23)="BallisticProV55.E23PlasmaRifle"
     RedLoadoutGroup2(24)="BallisticProV55.M46AssaultRifle"
     RedLoadoutGroup2(25)="BallisticProV55.A500Reptile"
     RedLoadoutGroup2(26)="BallisticProV55.MD24Pistol"
     RedLoadoutGroup2(27)="BallisticProV55.BOGPPistol"
     RedLoadoutGroup2(28)="BallisticProV55.XMK5SubMachinegun"
     RedLoadoutGroup3(0)="BallisticProV55.M50AssaultRifle"
     RedLoadoutGroup3(1)="BallisticProV55.M763Shotgun"
     RedLoadoutGroup3(2)="BallisticProV55.A73SkrithRifle"
     RedLoadoutGroup3(3)="BallisticProV55.M353Machinegun"
     RedLoadoutGroup3(4)="BallisticProV55.M925Machinegun"
     RedLoadoutGroup3(5)="BallisticProV55.G5Bazooka"
     RedLoadoutGroup3(6)="BallisticProV55.R78Rifle"
     RedLoadoutGroup3(7)="BallisticProV55.MRS138Shotgun"
     RedLoadoutGroup3(8)="BallisticProV55.SRS900Rifle"
     RedLoadoutGroup3(9)="BallisticProV55.SARAssaultRifle"
     RedLoadoutGroup3(10)="BallisticProV55.R9RangerRifle"
     RedLoadoutGroup3(11)="BallisticProV55.MarlinRifle"
     RedLoadoutGroup3(12)="BallisticProV55.MRocketLauncher"
     RedLoadoutGroup3(13)="BallisticProV55.MACWeapon"
     RedLoadoutGroup3(14)="BallisticProV55.RSDarkStar"
     RedLoadoutGroup3(15)="BallisticProV55.RSNovaStaff"
     RedLoadoutGroup3(16)="BallisticProV55.E23PlasmaRifle"
     RedLoadoutGroup3(17)="BallisticProV55.M46AssaultRifle"
     RedLoadoutGroup3(18)="BallisticProV55.XMK5SubMachinegun"
     RedLoadoutGroup3(19)="BallisticProV55.A500Reptile"
     RedLoadoutGroup4(0)="BallisticProV55.NRP57Grenade"
     RedLoadoutGroup4(1)="BallisticProV55.FP7Grenade"
     RedLoadoutGroup4(2)="BallisticProV55.FP9Explosive"
     RedLoadoutGroup4(3)="BallisticProV55.BX5Mine"
     RedLoadoutGroup4(4)="BallisticProV55.T10Grenade"
     RedLoadoutGroup5(0)="BallisticProV55.RX22AFlamer"
     RedLoadoutGroup5(1)="BallisticProV55.M290Shotgun"
     RedLoadoutGroup6(0)="BallisticProV55.MRocketLauncher"
     RedLoadoutGroup6(1)="BallisticProV55.M75Railgun"
     BlueLoadoutGroup0(0)="BallisticProV55.X3Knife"
     BlueLoadoutGroup0(1)="BallisticProV55.A909SkrithBlades"
     BlueLoadoutGroup0(2)="BallisticProV55.EKS43Katana"
     BlueLoadoutGroup0(3)="BallisticProV55.X4Knife"
     BlueLoadoutGroup1(0)="BallisticProV55.M806Pistol"
     BlueLoadoutGroup1(1)="BallisticProV55.A42SkrithPistol"
     BlueLoadoutGroup1(2)="BallisticProV55.MRT6Shotgun"
     BlueLoadoutGroup1(3)="BallisticProV55.XK2SubMachinegun"
     BlueLoadoutGroup1(4)="BallisticProV55.D49Revolver"
     BlueLoadoutGroup1(5)="BallisticProV55.RS8Pistol"
     BlueLoadoutGroup1(6)="BallisticProV55.XRS10SubMachinegun"
     BlueLoadoutGroup1(7)="BallisticProV55.Fifty9MachinePistol"
     BlueLoadoutGroup1(8)="BallisticProV55.AM67Pistol"
     BlueLoadoutGroup1(9)="BallisticProV55.GRS9Pistol"
     BlueLoadoutGroup1(10)="BallisticProV55.leMatRevolver"
     BlueLoadoutGroup1(11)="BallisticProV55.BOGPPistol"
     BlueLoadoutGroup1(12)="BallisticProV55.MD24Pistol"
     BlueLoadoutGroup2(0)="BallisticProV55.M50AssaultRifle"
     BlueLoadoutGroup2(1)="BallisticProV55.M763Shotgun"
     BlueLoadoutGroup2(2)="BallisticProV55.A73SkrithRifle"
     BlueLoadoutGroup2(3)="BallisticProV55.M353Machinegun"
     BlueLoadoutGroup2(4)="BallisticProV55.M925Machinegun"
     BlueLoadoutGroup2(5)="BallisticProV55.G5Bazooka"
     BlueLoadoutGroup2(6)="BallisticProV55.R78Rifle"
     BlueLoadoutGroup2(7)="BallisticProV55.MRS138Shotgun"
     BlueLoadoutGroup2(8)="BallisticProV55.SRS900Rifle"
     BlueLoadoutGroup2(9)="BallisticProV55.M806Pistol"
     BlueLoadoutGroup2(10)="BallisticProV55.A42SkrithPistol"
     BlueLoadoutGroup2(11)="BallisticProV55.MRT6Shotgun"
     BlueLoadoutGroup2(12)="BallisticProV55.XK2SubMachinegun"
     BlueLoadoutGroup2(13)="BallisticProV55.D49Revolver"
     BlueLoadoutGroup2(14)="BallisticProV55.RS8Pistol"
     BlueLoadoutGroup2(15)="BallisticProV55.XRS10SubMachinegun"
     BlueLoadoutGroup2(16)="BallisticProV55.Fifty9MachinePistol"
     BlueLoadoutGroup2(17)="BallisticProV55.AM67Pistol"
     BlueLoadoutGroup2(18)="BallisticProV55.SARAssaultRifle"
     BlueLoadoutGroup2(19)="BallisticProV55.R9RangerRifle"
     BlueLoadoutGroup2(20)="BallisticProV55.leMatRevolver"
     BlueLoadoutGroup2(21)="BallisticProV55.GRS9Pistol"
     BlueLoadoutGroup2(22)="BallisticProV55.MarlinRifle"
     BlueLoadoutGroup2(23)="BallisticProV55.E23PlasmaRifle"
     BlueLoadoutGroup2(24)="BallisticProV55.M46AssaultRifle"
     BlueLoadoutGroup2(25)="BallisticProV55.A500Reptile"
     BlueLoadoutGroup2(26)="BallisticProV55.MD24Pistol"
     BlueLoadoutGroup2(27)="BallisticProV55.BOGPPistol"
     BlueLoadoutGroup2(28)="BallisticProV55.XMK5SubMachinegun"
     BlueLoadoutGroup3(0)="BallisticProV55.M50AssaultRifle"
     BlueLoadoutGroup3(1)="BallisticProV55.M763Shotgun"
     BlueLoadoutGroup3(2)="BallisticProV55.A73SkrithRifle"
     BlueLoadoutGroup3(3)="BallisticProV55.M353Machinegun"
     BlueLoadoutGroup3(4)="BallisticProV55.M925Machinegun"
     BlueLoadoutGroup3(5)="BallisticProV55.G5Bazooka"
     BlueLoadoutGroup3(6)="BallisticProV55.R78Rifle"
     BlueLoadoutGroup3(7)="BallisticProV55.MRS138Shotgun"
     BlueLoadoutGroup3(8)="BallisticProV55.SRS900Rifle"
     BlueLoadoutGroup3(9)="BallisticProV55.SARAssaultRifle"
     BlueLoadoutGroup3(10)="BallisticProV55.R9RangerRifle"
     BlueLoadoutGroup3(11)="BallisticProV55.MarlinRifle"
     BlueLoadoutGroup3(12)="BallisticProV55.MRocketLauncher"
     BlueLoadoutGroup3(13)="BallisticProV55.MACWeapon"
     BlueLoadoutGroup3(14)="BallisticProV55.RSDarkStar"
     BlueLoadoutGroup3(15)="BallisticProV55.RSNovaStaff"
     BlueLoadoutGroup3(16)="BallisticProV55.E23PlasmaRifle"
     BlueLoadoutGroup3(17)="BallisticProV55.M46AssaultRifle"
     BlueLoadoutGroup3(18)="BallisticProV55.XMK5SubMachinegun"
     BlueLoadoutGroup3(19)="BallisticProV55.A500Reptile"
     BlueLoadoutGroup4(0)="BallisticProV55.NRP57Grenade"
     BlueLoadoutGroup4(1)="BallisticProV55.FP7Grenade"
     BlueLoadoutGroup4(2)="BallisticProV55.FP9Explosive"
     BlueLoadoutGroup4(3)="BallisticProV55.BX5Mine"
     BlueLoadoutGroup4(4)="BallisticProV55.T10Grenade"
     BlueLoadoutGroup5(0)="BallisticProV55.RX22AFlamer"
     BlueLoadoutGroup5(1)="BallisticProV55.M290Shotgun"
     BlueLoadoutGroup6(0)="BallisticProV55.MRocketLauncher"
     BlueLoadoutGroup6(1)="BallisticProV55.M75Railgun"
     bHideLockers=True
     FriendlyName="BallisticPro: Team Loadout"
     Description="Team-based Ballistic Loadout."
}
