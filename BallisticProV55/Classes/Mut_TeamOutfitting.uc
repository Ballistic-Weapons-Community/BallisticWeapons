//=============================================================================
// Mut_TeamOutfitting.
//
// It's Loadout, but per-team.
//=============================================================================
class Mut_TeamOutfitting extends Mut_Ballistic
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var() globalconfig string 			LoadOut[5];			// Loadout info saved seperately on each client
var() globalconfig int 				Layout[5];			// Layout number saved seperately on each client
var() globalconfig int 				Camo[5];			// Camo number saved seperately on each client

var   Array<ClientTeamOutfittingInterface>	COIPond;			// Jump right in, they won't bite - probably...
var   PlayerController						PCPendingCOI;	// The PlayerController that is about to get its COI

const NUM_GROUPS = 10;

//Would have preferred to use structs for this, but Random Weapon would have been a bitch.
var() globalconfig array<string>	RedLoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	RedLoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	RedLoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	RedLoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	RedLoadoutGroup4;	// Weapons available in Grenade Box

var() globalconfig array<string>	BlueLoadoutGroup0;	// Weapons available in Melee Box
var() globalconfig array<string>	BlueLoadoutGroup1;	// Weapons available in Sidearm Box
var() globalconfig array<string>	BlueLoadoutGroup2;	// Weapons available in Primary Box
var() globalconfig array<string>	BlueLoadoutGroup3;	// Weapons available in Secondayr Box
var() globalconfig array<string>	BlueLoadoutGroup4;	// Weapons available in Grenade Box


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

var   class<Weapon>			NetLoadoutWeapons[255];
var   byte							NetRedLoadoutGroups;

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
			SpawnWeaponLayout(W, Other, 255, 255); //Bots have random layouts

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
	
// Use the console command "Mutate Loadout" to open the loadout menu
function Mutate(string MutateString, PlayerController Sender)
{
	local int i;

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
function OutfitPlayer(Pawn Other, string Stuff[5], optional string OldStuff[5], optional int Layouts[5], optional int Camos[5])
{
	local byte i, j, k, m;
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
		if (Stuff[i] != "")
		{
			W = class<weapon>(DynamicLoadObject(Stuff[i],class'Class'));
			if (W == None)
				log("Could not load outfitted weapon "$Stuff[i]);
			else
				SpawnWeaponLayout(W, Other, Layouts[i], Camos[i]);
		}

		if (i == 0)
			i = 4;
		else if (i == 3)
			break;
		else
			i--;
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

static function Weapon SpawnWeaponLayout(class<weapon> newClass, Pawn P, int LayoutIndex, int CamoIndex)
{
	local Weapon newWeapon;

    if( (newClass!=None) && P != None)
    {
		newWeapon = Weapon(P.FindInventoryType(newClass));
		if (newWeapon == None || BallisticHandgun(newWeapon) != None)
		{
			newWeapon = P.Spawn(newClass,,,P.Location);
			if( newWeapon != None )
			{
				if (BallisticWeapon(newWeapon) != None)
				{
					BallisticWeapon(newWeapon).GenerateLayout(LayoutIndex);
					BallisticWeapon(newWeapon).GenerateCamo(CamoIndex);
				}
				newWeapon.GiveTo(P);
			}
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
	 Layout(0)=0
	 Layout(1)=0
	 Layout(2)=0
	 Layout(3)=0
	 Layout(4)=0
	 Camo(0)=0
	 Camo(1)=0
	 Camo(2)=0
	 Camo(3)=0
	 Camo(4)=0
     LoadOut(0)="BallisticProV55.X3Knife"
     LoadOut(1)="BallisticProV55.M806Pistol"
     LoadOut(2)="BallisticProV55.M763Shotgun"
     LoadOut(3)="BallisticProV55.M50AssaultRifle"
     LoadOut(4)="BallisticProV55.NRP57Grenade"
     
	 RedLoadoutGroup0(0)=BallisticProV55.X3Knife
	 RedLoadoutGroup0(1)=BallisticProV55.A909SkrithBlades
	 RedLoadoutGroup0(2)=BallisticProV55.EKS43Katana
	 RedLoadoutGroup0(3)=BallisticProV55.X4Knife
	 RedLoadoutGroup0(4)=BWBP_OP_Pro.BallisticShieldWeapon
	 RedLoadoutGroup0(5)=BWBP_OP_Pro.DefibFists
	 RedLoadoutGroup0(6)=BWBP_OP_Pro.FlameSword
	 RedLoadoutGroup0(7)=BWBP_OP_Pro.MAG78Longsword
	 RedLoadoutGroup0(8)=BWBP_OP_Pro.WrenchWarpDevice
	 RedLoadoutGroup0(9)=BWBP_SKC_Pro.BlackOpsWristBlade
	 RedLoadoutGroup0(10)=BWBP_SKC_Pro.DragonsToothSword
	 RedLoadoutGroup0(11)=BWBP_SKC_Pro.N3XPlaz
	 RedLoadoutGroup0(12)=BWBP_SKC_Pro.X8Knife
	 RedLoadoutGroup1(0)=BallisticProV55.M806Pistol
	 RedLoadoutGroup1(1)=BallisticProV55.A42SkrithPistol
	 RedLoadoutGroup1(2)=BallisticProV55.MRT6Shotgun
	 RedLoadoutGroup1(3)=BallisticProV55.D49Revolver
	 RedLoadoutGroup1(4)=BallisticProV55.RS8Pistol
	 RedLoadoutGroup1(5)=BallisticProV55.AM67Pistol
	 RedLoadoutGroup1(6)=BallisticProV55.leMatRevolver
	 RedLoadoutGroup1(7)=BallisticProV55.BOGPPistol
	 RedLoadoutGroup1(8)=BallisticProV55.MD24Pistol
	 RedLoadoutGroup1(9)=BWBP_JCF_Pro.HKMKSpecPistol
	 RedLoadoutGroup1(10)=BWBP_OP_Pro.PD97Bloodhound
	 RedLoadoutGroup1(11)=BWBP_SKC_Pro.AH104Pistol
	 RedLoadoutGroup1(12)=BWBP_SKC_Pro.AH250Pistol
	 RedLoadoutGroup1(13)=BWBP_SKC_Pro.PS9mPistol
	 RedLoadoutGroup1(14)=BWBP_SKC_Pro.RS04Pistol
	 RedLoadoutGroup1(15)=BWBP_SKC_Pro.SX45Pistol
	 RedLoadoutGroup1(16)=BWBP_SKC_Pro.T9CNMachinePistol
	 RedLoadoutGroup2(0)=BallisticProV55.M763Shotgun
	 RedLoadoutGroup2(1)=BallisticProV55.A73SkrithRifle
	 RedLoadoutGroup2(2)=BallisticProV55.M353Machinegun
	 RedLoadoutGroup2(3)=BallisticProV55.M925Machinegun
	 RedLoadoutGroup2(4)=BallisticProV55.G5Bazooka
	 RedLoadoutGroup2(5)=BallisticProV55.R78Rifle
	 RedLoadoutGroup2(6)=BallisticProV55.M75Railgun
	 RedLoadoutGroup2(7)=BallisticProV55.M290Shotgun
	 RedLoadoutGroup2(8)=BallisticProV55.MRS138Shotgun
	 RedLoadoutGroup2(9)=BallisticProV55.SRS900Rifle
	 RedLoadoutGroup2(10)=BallisticProV55.XK2SubMachinegun
	 RedLoadoutGroup2(11)=BallisticProV55.XRS10SubMachinegun 
	 RedLoadoutGroup2(12)=BallisticProV55.Fifty9MachinePistol
 	 RedLoadoutGroup2(13)=BallisticProV55.GRS9Pistol
 	 RedLoadoutGroup2(14)=BallisticProV55.MarlinRifle
 	 RedLoadoutGroup2(15)=BallisticProV55.E23PlasmaRifle
	 RedLoadoutGroup2(16)=BallisticProV55.A500Reptile
	 RedLoadoutGroup2(17)=BallisticProV55.XMK5SubMachinegun
	 RedLoadoutGroup2(18)=BWBP_APC_Pro.E5PlasmaRifle
	 RedLoadoutGroup2(19)=BWBP_APC_Pro.GASCPistol
	 RedLoadoutGroup2(20)=BWBP_APC_Pro.ProtoSMG
	 RedLoadoutGroup2(21)=BWBP_APC_Pro.SRKSubMachinegun
	 RedLoadoutGroup2(22)=BWBP_SKC_Pro.FMPMachinePistol
	 RedLoadoutGroup2(23)=BWBP_SKC_Pro.GRSXXPistol
	 RedLoadoutGroup2(24)=BWBP_SKC_Pro.MRDRMachinePistol
	 RedLoadoutGroup2(25)=BWBP_SKC_Pro.TyphonPDW
	 RedLoadoutGroup2(26)=BWBP_SWC_Pro.MDKSubMachinegun
	 RedLoadoutGroup2(27)=BWBP_APC_Pro.ZX98AssaultRifle
	 RedLoadoutGroup2(28)=BWBP_JCF_Pro.M7A3AssaultRifle
	 RedLoadoutGroup2(29)=BWBP_OP_Pro.CX61AssaultRifle
	 RedLoadoutGroup2(30)=BWBP_SKC_Pro.AK490BattleRifle
	 RedLoadoutGroup2(31)=BWBP_SKC_Pro.AK91ChargeRifle
	 RedLoadoutGroup2(32)=BWBP_SKC_Pro.CYLOFirestormAssaultWeapon
	 RedLoadoutGroup2(33)=BWBP_SKC_Pro.CYLOUAW
	 RedLoadoutGroup2(34)=BWBP_SKC_Pro.G51Carbine
	 RedLoadoutGroup2(35)=BWBP_SKC_Pro.LK05Carbine
	 RedLoadoutGroup2(36)=BWBP_SKC_Pro.MARSAssaultRifle
	 RedLoadoutGroup2(37)=BWBP_SKC_Pro.SRXRifle
	 RedLoadoutGroup2(38)=BallisticProV55.M46AssaultRifle
	 RedLoadoutGroup2(39)=BallisticProV55.M50AssaultRifle
	 RedLoadoutGroup2(40)=BallisticProV55.SARAssaultRifle
	 RedLoadoutGroup2(41)=BWBP_OP_Pro.ProtonStreamer
	 RedLoadoutGroup2(42)=BWBP_OP_Pro.Raygun
	 RedLoadoutGroup2(43)=BWBP_OP_Pro.XOXOStaff
	 RedLoadoutGroup2(44)=BWBP_SKC_Pro.A49SkrithBlaster
	 RedLoadoutGroup2(45)=BWBP_SKC_Pro.AY90SkrithBoltcaster
	 RedLoadoutGroup2(46)=BWBP_SKC_Pro.HVPCMk5PlasmaCannon
	 RedLoadoutGroup2(47)=BWBP_SKC_Pro.HVPCMk66PlasmaCannon
	 RedLoadoutGroup2(48)=BWBP_SKC_Pro.Supercharger_AssaultWeapon
	 RedLoadoutGroup2(49)=BWBP_SKC_Pro.XM20Carbine
	 RedLoadoutGroup2(50)=BWBP_SWC_Pro.A2WSkrithLance
	 RedLoadoutGroup2(51)=BWBP_SWC_Pro.SkrithStaff
	 RedLoadoutGroup2(52)=BallisticProV55.HVCMk9LightningGun
	 RedLoadoutGroup2(53)=BallisticProV55.RSDarkStar
	 RedLoadoutGroup2(54)=BallisticProV55.RSNovaStaff
	 RedLoadoutGroup2(55)=BWBP_APC_Pro.PKMMachinegun
	 RedLoadoutGroup2(56)=BWBP_APC_Pro.TridentMachinegun
	 RedLoadoutGroup2(57)=BWBP_OP_Pro.M575Machinegun
	 RedLoadoutGroup2(58)=BWBP_OP_Pro.MX32Weapon
	 RedLoadoutGroup2(59)=BWBP_OP_Pro.Z250Minigun
	 RedLoadoutGroup2(60)=BWBP_SKC_Pro.AR23HeavyRifle
	 RedLoadoutGroup2(61)=BWBP_SKC_Pro.FG50MachineGun
	 RedLoadoutGroup2(62)=BWBP_SKC_Pro.MG36Carbine
	 RedLoadoutGroup2(63)=BWBP_SWC_Pro.A800SkrithMinigun
	 RedLoadoutGroup2(64)=BWBP_SWC_Pro.BRINKAssaultRifle
	 RedLoadoutGroup2(65)=BallisticProV55.XMV850Minigun
	 RedLoadoutGroup2(66)=BWBP_APC_Pro.FM13Shotgun
	 RedLoadoutGroup2(67)=BWBP_APC_Pro.FM14Shotgun
	 RedLoadoutGroup2(68)=BWBP_APC_Pro.Wrenchgun
	 RedLoadoutGroup2(69)=BWBP_JCF_Pro.SPASShotgun
	 RedLoadoutGroup2(70)=BWBP_OP_Pro.RCS715Shotgun
	 RedLoadoutGroup2(71)=BWBP_OP_Pro.TrenchGun
	 RedLoadoutGroup2(72)=BWBP_SKC_Pro.CoachGun
	 RedLoadoutGroup2(73)=BWBP_SKC_Pro.MK781Shotgun
	 RedLoadoutGroup2(74)=BWBP_SKC_Pro.SK410Shotgun
	 RedLoadoutGroup2(75)=BWBP_SKC_Pro.SKASShotgun
	 RedLoadoutGroup2(76)=BWBP_APC_Pro.HB4GrenadeBlaster
	 RedLoadoutGroup2(77)=BWBP_APC_Pro.HydraBazooka
	 RedLoadoutGroup2(78)=BWBP_JCF_Pro.RGPXBazooka
	 RedLoadoutGroup2(79)=BWBP_OP_Pro.AkeronLauncher
	 RedLoadoutGroup2(80)=BWBP_SKC_Pro.BulldogAssaultCannon
	 RedLoadoutGroup2(81)=BWBP_SKC_Pro.FLASHLauncher
	 RedLoadoutGroup2(82)=BWBP_SKC_Pro.LAWLauncher
	 RedLoadoutGroup2(83)=BWBP_SKC_Pro.LonghornLauncher
	 RedLoadoutGroup2(84)=BWBP_SKC_Pro.MGLauncher
	 RedLoadoutGroup2(85)=BWBP_SKC_Pro.PugAssaultCannon
	 RedLoadoutGroup2(86)=BWBP_SKC_Pro.PumaRepeater
	 RedLoadoutGroup2(87)=BWBP_SKC_Pro.SMATLauncher
	 RedLoadoutGroup2(88)=BWBP_SKC_Pro.ThumperGrenadeLauncher
	 RedLoadoutGroup2(89)=BallisticProV55.MACWeapon
	 RedLoadoutGroup2(90)=BallisticProV55.MRocketLauncher
	 RedLoadoutGroup2(91)=BallisticProV55.RX22AFlamer
	 RedLoadoutGroup2(92)=BWBP_APC_Pro.R9000ERifle
	 RedLoadoutGroup2(93)=BWBP_JCF_Pro.M99Rifle
	 RedLoadoutGroup2(94)=BWBP_OP_Pro.CX85AssaultWeapon
	 RedLoadoutGroup2(95)=BWBP_OP_Pro.KF8XCrossbow
	 RedLoadoutGroup2(96)=BWBP_OP_Pro.LightningRifle
	 RedLoadoutGroup2(97)=BWBP_OP_Pro.R9A1RangerRifle
	 RedLoadoutGroup2(98)=BWBP_SKC_Pro.AS50Rifle
	 RedLoadoutGroup2(99)=BWBP_SKC_Pro.LS14Carbine
	 RedLoadoutGroup2(100)=BWBP_SKC_Pro.M2020GaussDMR
	 RedLoadoutGroup2(101)=BWBP_SKC_Pro.VSKTranqRifle
	 RedLoadoutGroup2(102)=BWBP_SKC_Pro.X82Rifle
     RedLoadoutGroup2(103)="BallisticProV55.M806Pistol"
     RedLoadoutGroup2(104)="BallisticProV55.A42SkrithPistol"
     RedLoadoutGroup2(105)="BallisticProV55.MRT6Shotgun"
     RedLoadoutGroup2(106)="BallisticProV55.XK2SubMachinegun"
     RedLoadoutGroup2(107)="BallisticProV55.D49Revolver"
     RedLoadoutGroup2(108)="BallisticProV55.RS8Pistol"
     RedLoadoutGroup2(109)="BallisticProV55.XRS10SubMachinegun"
     RedLoadoutGroup2(110)="BallisticProV55.Fifty9MachinePistol"
     RedLoadoutGroup2(111)="BallisticProV55.AM67Pistol"
     RedLoadoutGroup2(112)="BallisticProV55.GRS9Pistol"
     RedLoadoutGroup2(113)="BallisticProV55.leMatRevolver"
     RedLoadoutGroup2(114)="BallisticProV55.BOGPPistol"
     RedLoadoutGroup2(115)="BallisticProV55.MD24Pistol"
	 RedLoadoutGroup2(116)="BallisticProV55.RandomWeaponDummy"
     RedLoadoutGroup2(117)="BallisticProV55.NoneWeaponDummy"
	 RedLoadoutGroup2(118)=BWBP_JCF_Pro.HKMKSpecPistol
	 RedLoadoutGroup2(119)=BWBP_OP_Pro.PD97Bloodhound
	 RedLoadoutGroup2(120)=BWBP_SKC_Pro.AH104Pistol
	 RedLoadoutGroup2(121)=BWBP_SKC_Pro.AH250Pistol
	 RedLoadoutGroup2(122)=BWBP_SKC_Pro.PS9mPistol
	 RedLoadoutGroup2(123)=BWBP_SKC_Pro.RS04Pistol
	 RedLoadoutGroup2(124)=BWBP_SKC_Pro.SX45Pistol
	 RedLoadoutGroup2(125)=BWBP_SKC_Pro.T9CNMachinePistol
	 RedLoadoutGroup3(0)=BallisticProV55.M763Shotgun
	 RedLoadoutGroup3(1)=BallisticProV55.A73SkrithRifle
	 RedLoadoutGroup3(2)=BallisticProV55.M353Machinegun
	 RedLoadoutGroup3(3)=BallisticProV55.M925Machinegun
	 RedLoadoutGroup3(4)=BallisticProV55.G5Bazooka
	 RedLoadoutGroup3(5)=BallisticProV55.R78Rifle
	 RedLoadoutGroup3(6)=BallisticProV55.M75Railgun
	 RedLoadoutGroup3(7)=BallisticProV55.M290Shotgun
	 RedLoadoutGroup3(8)=BallisticProV55.MRS138Shotgun
	 RedLoadoutGroup3(9)=BallisticProV55.SRS900Rifle
	 RedLoadoutGroup3(10)=BallisticProV55.XK2SubMachinegun
	 RedLoadoutGroup3(11)=BallisticProV55.XRS10SubMachinegun 
	 RedLoadoutGroup3(12)=BallisticProV55.Fifty9MachinePistol
 	 RedLoadoutGroup3(13)=BallisticProV55.GRS9Pistol
 	 RedLoadoutGroup3(14)=BallisticProV55.MarlinRifle
 	 RedLoadoutGroup3(15)=BallisticProV55.E23PlasmaRifle
	 RedLoadoutGroup3(16)=BallisticProV55.A500Reptile
	 RedLoadoutGroup3(17)=BallisticProV55.XMK5SubMachinegun
	 RedLoadoutGroup3(18)=BWBP_APC_Pro.E5PlasmaRifle
	 RedLoadoutGroup3(19)=BWBP_APC_Pro.GASCPistol
	 RedLoadoutGroup3(20)=BWBP_APC_Pro.ProtoSMG
	 RedLoadoutGroup3(21)=BWBP_APC_Pro.SRKSubMachinegun
	 RedLoadoutGroup3(22)=BWBP_SKC_Pro.FMPMachinePistol
	 RedLoadoutGroup3(23)=BWBP_SKC_Pro.GRSXXPistol
	 RedLoadoutGroup3(24)=BWBP_SKC_Pro.MRDRMachinePistol
	 RedLoadoutGroup3(25)=BWBP_SKC_Pro.TyphonPDW
	 RedLoadoutGroup3(26)=BWBP_SWC_Pro.MDKSubMachinegun
	 RedLoadoutGroup3(27)=BWBP_APC_Pro.ZX98AssaultRifle
	 RedLoadoutGroup3(28)=BWBP_JCF_Pro.M7A3AssaultRifle
	 RedLoadoutGroup3(29)=BWBP_OP_Pro.CX61AssaultRifle
	 RedLoadoutGroup3(30)=BWBP_SKC_Pro.AK490BattleRifle
	 RedLoadoutGroup3(31)=BWBP_SKC_Pro.AK91ChargeRifle
	 RedLoadoutGroup3(32)=BWBP_SKC_Pro.CYLOFirestormAssaultWeapon
	 RedLoadoutGroup3(33)=BWBP_SKC_Pro.CYLOUAW
	 RedLoadoutGroup3(34)=BWBP_SKC_Pro.G51Carbine
	 RedLoadoutGroup3(35)=BWBP_SKC_Pro.LK05Carbine
	 RedLoadoutGroup3(36)=BWBP_SKC_Pro.MARSAssaultRifle
	 RedLoadoutGroup3(37)=BWBP_SKC_Pro.SRXRifle
	 RedLoadoutGroup3(38)=BallisticProV55.M46AssaultRifle
	 RedLoadoutGroup3(39)=BallisticProV55.M50AssaultRifle
	 RedLoadoutGroup3(40)=BallisticProV55.SARAssaultRifle
	 RedLoadoutGroup3(41)=BWBP_OP_Pro.ProtonStreamer
	 RedLoadoutGroup3(42)=BWBP_OP_Pro.Raygun
	 RedLoadoutGroup3(43)=BWBP_OP_Pro.XOXOStaff
	 RedLoadoutGroup3(44)=BWBP_SKC_Pro.A49SkrithBlaster
	 RedLoadoutGroup3(45)=BWBP_SKC_Pro.AY90SkrithBoltcaster
	 RedLoadoutGroup3(46)=BWBP_SKC_Pro.HVPCMk5PlasmaCannon
	 RedLoadoutGroup3(47)=BWBP_SKC_Pro.HVPCMk66PlasmaCannon
	 RedLoadoutGroup3(48)=BWBP_SKC_Pro.Supercharger_AssaultWeapon
	 RedLoadoutGroup3(49)=BWBP_SKC_Pro.XM20Carbine
	 RedLoadoutGroup3(50)=BWBP_SWC_Pro.A2WSkrithLance
	 RedLoadoutGroup3(51)=BWBP_SWC_Pro.SkrithStaff
	 RedLoadoutGroup3(52)=BallisticProV55.HVCMk9LightningGun
	 RedLoadoutGroup3(53)=BallisticProV55.RSDarkStar
	 RedLoadoutGroup3(54)=BallisticProV55.RSNovaStaff
	 RedLoadoutGroup3(55)=BWBP_APC_Pro.PKMMachinegun
	 RedLoadoutGroup3(56)=BWBP_APC_Pro.TridentMachinegun
	 RedLoadoutGroup3(57)=BWBP_OP_Pro.M575Machinegun
	 RedLoadoutGroup3(58)=BWBP_OP_Pro.MX32Weapon
	 RedLoadoutGroup3(59)=BWBP_OP_Pro.Z250Minigun
	 RedLoadoutGroup3(60)=BWBP_SKC_Pro.AR23HeavyRifle
	 RedLoadoutGroup3(61)=BWBP_SKC_Pro.FG50MachineGun
	 RedLoadoutGroup3(62)=BWBP_SKC_Pro.MG36Carbine
	 RedLoadoutGroup3(63)=BWBP_SWC_Pro.A800SkrithMinigun
	 RedLoadoutGroup3(64)=BWBP_SWC_Pro.BRINKAssaultRifle
	 RedLoadoutGroup3(65)=BallisticProV55.XMV850Minigun
	 RedLoadoutGroup3(66)=BWBP_APC_Pro.FM13Shotgun
	 RedLoadoutGroup3(67)=BWBP_APC_Pro.FM14Shotgun
	 RedLoadoutGroup3(68)=BWBP_APC_Pro.Wrenchgun
	 RedLoadoutGroup3(69)=BWBP_JCF_Pro.SPASShotgun
	 RedLoadoutGroup3(70)=BWBP_OP_Pro.RCS715Shotgun
	 RedLoadoutGroup3(71)=BWBP_OP_Pro.TrenchGun
	 RedLoadoutGroup3(72)=BWBP_SKC_Pro.CoachGun
	 RedLoadoutGroup3(73)=BWBP_SKC_Pro.MK781Shotgun
	 RedLoadoutGroup3(74)=BWBP_SKC_Pro.SK410Shotgun
	 RedLoadoutGroup3(75)=BWBP_SKC_Pro.SKASShotgun
	 RedLoadoutGroup3(76)=BWBP_APC_Pro.HB4GrenadeBlaster
	 RedLoadoutGroup3(77)=BWBP_APC_Pro.HydraBazooka
	 RedLoadoutGroup3(78)=BWBP_JCF_Pro.RGPXBazooka
	 RedLoadoutGroup3(79)=BWBP_OP_Pro.AkeronLauncher
	 RedLoadoutGroup3(80)=BWBP_SKC_Pro.BulldogAssaultCannon
	 RedLoadoutGroup3(81)=BWBP_SKC_Pro.FLASHLauncher
	 RedLoadoutGroup3(82)=BWBP_SKC_Pro.LAWLauncher
	 RedLoadoutGroup3(83)=BWBP_SKC_Pro.LonghornLauncher
	 RedLoadoutGroup3(84)=BWBP_SKC_Pro.MGLauncher
	 RedLoadoutGroup3(85)=BWBP_SKC_Pro.PugAssaultCannon
	 RedLoadoutGroup3(86)=BWBP_SKC_Pro.PumaRepeater
	 RedLoadoutGroup3(87)=BWBP_SKC_Pro.SMATLauncher
	 RedLoadoutGroup3(88)=BWBP_SKC_Pro.ThumperGrenadeLauncher
	 RedLoadoutGroup3(89)=BallisticProV55.MACWeapon
	 RedLoadoutGroup3(90)=BallisticProV55.MRocketLauncher
	 RedLoadoutGroup3(91)=BallisticProV55.RX22AFlamer
	 RedLoadoutGroup3(92)=BWBP_APC_Pro.R9000ERifle
	 RedLoadoutGroup3(93)=BWBP_JCF_Pro.M99Rifle
	 RedLoadoutGroup3(94)=BWBP_OP_Pro.CX85AssaultWeapon
	 RedLoadoutGroup3(95)=BWBP_OP_Pro.KF8XCrossbow
	 RedLoadoutGroup3(96)=BWBP_OP_Pro.LightningRifle
	 RedLoadoutGroup3(97)=BWBP_OP_Pro.R9A1RangerRifle
	 RedLoadoutGroup3(98)=BWBP_SKC_Pro.AS50Rifle
	 RedLoadoutGroup3(99)=BWBP_SKC_Pro.LS14Carbine
	 RedLoadoutGroup3(100)=BWBP_SKC_Pro.M2020GaussDMR
	 RedLoadoutGroup3(101)=BWBP_SKC_Pro.VSKTranqRifle
	 RedLoadoutGroup3(102)=BWBP_SKC_Pro.X82Rifle
	 RedLoadoutGroup4(1)=BallisticProV55.NRP57Grenade
	 RedLoadoutGroup4(2)=BallisticProV55.FP7Grenade
	 RedLoadoutGroup4(3)=BallisticProV55.FP9Explosive
	 RedLoadoutGroup4(4)=BallisticProV55.BX5Mine
	 RedLoadoutGroup4(5)=BallisticProV55.T10Grenade
	 RedLoadoutGroup4(6)=BWBPAirstrikesPro.TargetDesignator
	 RedLoadoutGroup4(7)=BWBP_APC_Pro.ScarabGrenade
	 RedLoadoutGroup4(8)=BWBP_OP_Pro.L8GIAmmoPack
	 RedLoadoutGroup4(9)=BWBP_SKC_Pro.ChaffGrenadeWeapon
	 RedLoadoutGroup4(10)=BWBP_SKC_Pro.G28Grenade
	 RedLoadoutGroup4(11)=BWBP_SKC_Pro.ICISStimpack
	 RedLoadoutGroup4(12)=BWBP_SKC_Pro.XM84Flashbang
	 RedLoadoutGroup4(13)=BWBP_SWC_Pro.A51Grenade
	 RedLoadoutGroup4(14)=BWBP_SWC_Pro.APodCapsule
	 RedLoadoutGroup4(15)=BWBP_SWC_Pro.NTOVBandage
	 RedLoadoutGroup4(16)=BallisticProV55.M58Grenade
	 RedLoadoutGroup4(17)=BallisticProV55.SandbagLayer
	 
	 BlueLoadoutGroup0(0)=BallisticProV55.X3Knife
	 BlueLoadoutGroup0(1)=BallisticProV55.A909SkrithBlades
	 BlueLoadoutGroup0(2)=BallisticProV55.EKS43Katana
	 BlueLoadoutGroup0(3)=BallisticProV55.X4Knife
	 BlueLoadoutGroup0(4)=BWBP_OP_Pro.BallisticShieldWeapon
	 BlueLoadoutGroup0(5)=BWBP_OP_Pro.DefibFists
	 BlueLoadoutGroup0(6)=BWBP_OP_Pro.FlameSword
	 BlueLoadoutGroup0(7)=BWBP_OP_Pro.MAG78Longsword
	 BlueLoadoutGroup0(8)=BWBP_OP_Pro.WrenchWarpDevice
	 BlueLoadoutGroup0(9)=BWBP_SKC_Pro.BlackOpsWristBlade
	 BlueLoadoutGroup0(10)=BWBP_SKC_Pro.DragonsToothSword
	 BlueLoadoutGroup0(11)=BWBP_SKC_Pro.N3XPlaz
	 BlueLoadoutGroup0(12)=BWBP_SKC_Pro.X8Knife
	 BlueLoadoutGroup1(0)=BallisticProV55.M806Pistol
	 BlueLoadoutGroup1(1)=BallisticProV55.A42SkrithPistol
	 BlueLoadoutGroup1(2)=BallisticProV55.MRT6Shotgun
	 BlueLoadoutGroup1(3)=BallisticProV55.D49Revolver
	 BlueLoadoutGroup1(4)=BallisticProV55.RS8Pistol
	 BlueLoadoutGroup1(5)=BallisticProV55.AM67Pistol
	 BlueLoadoutGroup1(6)=BallisticProV55.leMatRevolver
	 BlueLoadoutGroup1(7)=BallisticProV55.BOGPPistol
	 BlueLoadoutGroup1(8)=BallisticProV55.MD24Pistol
	 BlueLoadoutGroup1(9)=BWBP_JCF_Pro.HKMKSpecPistol
	 BlueLoadoutGroup1(10)=BWBP_OP_Pro.PD97Bloodhound
	 BlueLoadoutGroup1(11)=BWBP_SKC_Pro.AH104Pistol
	 BlueLoadoutGroup1(12)=BWBP_SKC_Pro.AH250Pistol
	 BlueLoadoutGroup1(13)=BWBP_SKC_Pro.PS9mPistol
	 BlueLoadoutGroup1(14)=BWBP_SKC_Pro.RS04Pistol
	 BlueLoadoutGroup1(15)=BWBP_SKC_Pro.SX45Pistol
	 BlueLoadoutGroup1(16)=BWBP_SKC_Pro.T9CNMachinePistol
	 BlueLoadoutGroup2(0)=BallisticProV55.M763Shotgun
	 BlueLoadoutGroup2(1)=BallisticProV55.A73SkrithRifle
	 BlueLoadoutGroup2(2)=BallisticProV55.M353Machinegun
	 BlueLoadoutGroup2(3)=BallisticProV55.M925Machinegun
	 BlueLoadoutGroup2(4)=BallisticProV55.G5Bazooka
	 BlueLoadoutGroup2(5)=BallisticProV55.R78Rifle
	 BlueLoadoutGroup2(6)=BallisticProV55.M75Railgun
	 BlueLoadoutGroup2(7)=BallisticProV55.M290Shotgun
	 BlueLoadoutGroup2(8)=BallisticProV55.MRS138Shotgun
	 BlueLoadoutGroup2(9)=BallisticProV55.SRS900Rifle
	 BlueLoadoutGroup2(10)=BallisticProV55.XK2SubMachinegun
	 BlueLoadoutGroup2(11)=BallisticProV55.XRS10SubMachinegun 
	 BlueLoadoutGroup2(12)=BallisticProV55.Fifty9MachinePistol
 	 BlueLoadoutGroup2(13)=BallisticProV55.GRS9Pistol
 	 BlueLoadoutGroup2(14)=BallisticProV55.MarlinRifle
 	 BlueLoadoutGroup2(15)=BallisticProV55.E23PlasmaRifle
	 BlueLoadoutGroup2(16)=BallisticProV55.A500Reptile
	 BlueLoadoutGroup2(17)=BallisticProV55.XMK5SubMachinegun
	 BlueLoadoutGroup2(18)=BWBP_APC_Pro.E5PlasmaRifle
	 BlueLoadoutGroup2(19)=BWBP_APC_Pro.GASCPistol
	 BlueLoadoutGroup2(20)=BWBP_APC_Pro.ProtoSMG
	 BlueLoadoutGroup2(21)=BWBP_APC_Pro.SRKSubMachinegun
	 BlueLoadoutGroup2(22)=BWBP_SKC_Pro.FMPMachinePistol
	 BlueLoadoutGroup2(23)=BWBP_SKC_Pro.GRSXXPistol
	 BlueLoadoutGroup2(24)=BWBP_SKC_Pro.MRDRMachinePistol
	 BlueLoadoutGroup2(25)=BWBP_SKC_Pro.TyphonPDW
	 BlueLoadoutGroup2(26)=BWBP_SWC_Pro.MDKSubMachinegun
	 BlueLoadoutGroup2(27)=BWBP_APC_Pro.ZX98AssaultRifle
	 BlueLoadoutGroup2(28)=BWBP_JCF_Pro.M7A3AssaultRifle
	 BlueLoadoutGroup2(29)=BWBP_OP_Pro.CX61AssaultRifle
	 BlueLoadoutGroup2(30)=BWBP_SKC_Pro.AK490BattleRifle
	 BlueLoadoutGroup2(31)=BWBP_SKC_Pro.AK91ChargeRifle
	 BlueLoadoutGroup2(32)=BWBP_SKC_Pro.CYLOFirestormAssaultWeapon
	 BlueLoadoutGroup2(33)=BWBP_SKC_Pro.CYLOUAW
	 BlueLoadoutGroup2(34)=BWBP_SKC_Pro.G51Carbine
	 BlueLoadoutGroup2(35)=BWBP_SKC_Pro.LK05Carbine
	 BlueLoadoutGroup2(36)=BWBP_SKC_Pro.MARSAssaultRifle
	 BlueLoadoutGroup2(37)=BWBP_SKC_Pro.SRXRifle
	 BlueLoadoutGroup2(38)=BallisticProV55.M46AssaultRifle
	 BlueLoadoutGroup2(39)=BallisticProV55.M50AssaultRifle
	 BlueLoadoutGroup2(40)=BallisticProV55.SARAssaultRifle
	 BlueLoadoutGroup2(41)=BWBP_OP_Pro.ProtonStreamer
	 BlueLoadoutGroup2(42)=BWBP_OP_Pro.Raygun
	 BlueLoadoutGroup2(43)=BWBP_OP_Pro.XOXOStaff
	 BlueLoadoutGroup2(44)=BWBP_SKC_Pro.A49SkrithBlaster
	 BlueLoadoutGroup2(45)=BWBP_SKC_Pro.AY90SkrithBoltcaster
	 BlueLoadoutGroup2(46)=BWBP_SKC_Pro.HVPCMk5PlasmaCannon
	 BlueLoadoutGroup2(47)=BWBP_SKC_Pro.HVPCMk66PlasmaCannon
	 BlueLoadoutGroup2(48)=BWBP_SKC_Pro.Supercharger_AssaultWeapon
	 BlueLoadoutGroup2(49)=BWBP_SKC_Pro.XM20Carbine
	 BlueLoadoutGroup2(50)=BWBP_SWC_Pro.A2WSkrithLance
	 BlueLoadoutGroup2(51)=BWBP_SWC_Pro.SkrithStaff
	 BlueLoadoutGroup2(52)=BallisticProV55.HVCMk9LightningGun
	 BlueLoadoutGroup2(53)=BallisticProV55.RSDarkStar
	 BlueLoadoutGroup2(54)=BallisticProV55.RSNovaStaff
	 BlueLoadoutGroup2(55)=BWBP_APC_Pro.PKMMachinegun
	 BlueLoadoutGroup2(56)=BWBP_APC_Pro.TridentMachinegun
	 BlueLoadoutGroup2(57)=BWBP_OP_Pro.M575Machinegun
	 BlueLoadoutGroup2(58)=BWBP_OP_Pro.MX32Weapon
	 BlueLoadoutGroup2(59)=BWBP_OP_Pro.Z250Minigun
	 BlueLoadoutGroup2(60)=BWBP_SKC_Pro.AR23HeavyRifle
	 BlueLoadoutGroup2(61)=BWBP_SKC_Pro.FG50MachineGun
	 BlueLoadoutGroup2(62)=BWBP_SKC_Pro.MG36Carbine
	 BlueLoadoutGroup2(63)=BWBP_SWC_Pro.A800SkrithMinigun
	 BlueLoadoutGroup2(64)=BWBP_SWC_Pro.BRINKAssaultRifle
	 BlueLoadoutGroup2(65)=BallisticProV55.XMV850Minigun
	 BlueLoadoutGroup2(66)=BWBP_APC_Pro.FM13Shotgun
	 BlueLoadoutGroup2(67)=BWBP_APC_Pro.FM14Shotgun
	 BlueLoadoutGroup2(68)=BWBP_APC_Pro.Wrenchgun
	 BlueLoadoutGroup2(69)=BWBP_JCF_Pro.SPASShotgun
	 BlueLoadoutGroup2(70)=BWBP_OP_Pro.RCS715Shotgun
	 BlueLoadoutGroup2(71)=BWBP_OP_Pro.TrenchGun
	 BlueLoadoutGroup2(72)=BWBP_SKC_Pro.CoachGun
	 BlueLoadoutGroup2(73)=BWBP_SKC_Pro.MK781Shotgun
	 BlueLoadoutGroup2(74)=BWBP_SKC_Pro.SK410Shotgun
	 BlueLoadoutGroup2(75)=BWBP_SKC_Pro.SKASShotgun
	 BlueLoadoutGroup2(76)=BWBP_APC_Pro.HB4GrenadeBlaster
	 BlueLoadoutGroup2(77)=BWBP_APC_Pro.HydraBazooka
	 BlueLoadoutGroup2(78)=BWBP_JCF_Pro.RGPXBazooka
	 BlueLoadoutGroup2(79)=BWBP_OP_Pro.AkeronLauncher
	 BlueLoadoutGroup2(80)=BWBP_SKC_Pro.BulldogAssaultCannon
	 BlueLoadoutGroup2(81)=BWBP_SKC_Pro.FLASHLauncher
	 BlueLoadoutGroup2(82)=BWBP_SKC_Pro.LAWLauncher
	 BlueLoadoutGroup2(83)=BWBP_SKC_Pro.LonghornLauncher
	 BlueLoadoutGroup2(84)=BWBP_SKC_Pro.MGLauncher
	 BlueLoadoutGroup2(85)=BWBP_SKC_Pro.PugAssaultCannon
	 BlueLoadoutGroup2(86)=BWBP_SKC_Pro.PumaRepeater
	 BlueLoadoutGroup2(87)=BWBP_SKC_Pro.SMATLauncher
	 BlueLoadoutGroup2(88)=BWBP_SKC_Pro.ThumperGrenadeLauncher
	 BlueLoadoutGroup2(89)=BallisticProV55.MACWeapon
	 BlueLoadoutGroup2(90)=BallisticProV55.MRocketLauncher
	 BlueLoadoutGroup2(91)=BallisticProV55.RX22AFlamer
	 BlueLoadoutGroup2(92)=BWBP_APC_Pro.R9000ERifle
	 BlueLoadoutGroup2(93)=BWBP_JCF_Pro.M99Rifle
	 BlueLoadoutGroup2(94)=BWBP_OP_Pro.CX85AssaultWeapon
	 BlueLoadoutGroup2(95)=BWBP_OP_Pro.KF8XCrossbow
	 BlueLoadoutGroup2(96)=BWBP_OP_Pro.LightningRifle
	 BlueLoadoutGroup2(97)=BWBP_OP_Pro.R9A1RangerRifle
	 BlueLoadoutGroup2(98)=BWBP_SKC_Pro.AS50Rifle
	 BlueLoadoutGroup2(99)=BWBP_SKC_Pro.LS14Carbine
	 BlueLoadoutGroup2(100)=BWBP_SKC_Pro.M2020GaussDMR
	 BlueLoadoutGroup2(101)=BWBP_SKC_Pro.VSKTranqRifle
	 BlueLoadoutGroup2(102)=BWBP_SKC_Pro.X82Rifle
     BlueLoadoutGroup2(103)="BallisticProV55.M806Pistol"
     BlueLoadoutGroup2(104)="BallisticProV55.A42SkrithPistol"
     BlueLoadoutGroup2(105)="BallisticProV55.MRT6Shotgun"
     BlueLoadoutGroup2(106)="BallisticProV55.XK2SubMachinegun"
     BlueLoadoutGroup2(107)="BallisticProV55.D49Revolver"
     BlueLoadoutGroup2(108)="BallisticProV55.RS8Pistol"
     BlueLoadoutGroup2(109)="BallisticProV55.XRS10SubMachinegun"
     BlueLoadoutGroup2(110)="BallisticProV55.Fifty9MachinePistol"
     BlueLoadoutGroup2(111)="BallisticProV55.AM67Pistol"
     BlueLoadoutGroup2(112)="BallisticProV55.GRS9Pistol"
     BlueLoadoutGroup2(113)="BallisticProV55.leMatRevolver"
     BlueLoadoutGroup2(114)="BallisticProV55.BOGPPistol"
     BlueLoadoutGroup2(115)="BallisticProV55.MD24Pistol"
	 BlueLoadoutGroup2(116)="BallisticProV55.RandomWeaponDummy"
     BlueLoadoutGroup2(117)="BallisticProV55.NoneWeaponDummy"
	 BlueLoadoutGroup2(118)=BWBP_JCF_Pro.HKMKSpecPistol
	 BlueLoadoutGroup2(119)=BWBP_OP_Pro.PD97Bloodhound
	 BlueLoadoutGroup2(120)=BWBP_SKC_Pro.AH104Pistol
	 BlueLoadoutGroup2(121)=BWBP_SKC_Pro.AH250Pistol
	 BlueLoadoutGroup2(122)=BWBP_SKC_Pro.PS9mPistol
	 BlueLoadoutGroup2(123)=BWBP_SKC_Pro.RS04Pistol
	 BlueLoadoutGroup2(124)=BWBP_SKC_Pro.SX45Pistol
	 BlueLoadoutGroup2(125)=BWBP_SKC_Pro.T9CNMachinePistol
	 BlueLoadoutGroup3(0)=BallisticProV55.M763Shotgun
	 BlueLoadoutGroup3(1)=BallisticProV55.A73SkrithRifle
	 BlueLoadoutGroup3(2)=BallisticProV55.M353Machinegun
	 BlueLoadoutGroup3(3)=BallisticProV55.M925Machinegun
	 BlueLoadoutGroup3(4)=BallisticProV55.G5Bazooka
	 BlueLoadoutGroup3(5)=BallisticProV55.R78Rifle
	 BlueLoadoutGroup3(6)=BallisticProV55.M75Railgun
	 BlueLoadoutGroup3(7)=BallisticProV55.M290Shotgun
	 BlueLoadoutGroup3(8)=BallisticProV55.MRS138Shotgun
	 BlueLoadoutGroup3(9)=BallisticProV55.SRS900Rifle
	 BlueLoadoutGroup3(10)=BallisticProV55.XK2SubMachinegun
	 BlueLoadoutGroup3(11)=BallisticProV55.XRS10SubMachinegun 
	 BlueLoadoutGroup3(12)=BallisticProV55.Fifty9MachinePistol
 	 BlueLoadoutGroup3(13)=BallisticProV55.GRS9Pistol
 	 BlueLoadoutGroup3(14)=BallisticProV55.MarlinRifle
 	 BlueLoadoutGroup3(15)=BallisticProV55.E23PlasmaRifle
	 BlueLoadoutGroup3(16)=BallisticProV55.A500Reptile
	 BlueLoadoutGroup3(17)=BallisticProV55.XMK5SubMachinegun
	 BlueLoadoutGroup3(18)=BWBP_APC_Pro.E5PlasmaRifle
	 BlueLoadoutGroup3(19)=BWBP_APC_Pro.GASCPistol
	 BlueLoadoutGroup3(20)=BWBP_APC_Pro.ProtoSMG
	 BlueLoadoutGroup3(21)=BWBP_APC_Pro.SRKSubMachinegun
	 BlueLoadoutGroup3(22)=BWBP_SKC_Pro.FMPMachinePistol
	 BlueLoadoutGroup3(23)=BWBP_SKC_Pro.GRSXXPistol
	 BlueLoadoutGroup3(24)=BWBP_SKC_Pro.MRDRMachinePistol
	 BlueLoadoutGroup3(25)=BWBP_SKC_Pro.TyphonPDW
	 BlueLoadoutGroup3(26)=BWBP_SWC_Pro.MDKSubMachinegun
	 BlueLoadoutGroup3(27)=BWBP_APC_Pro.ZX98AssaultRifle
	 BlueLoadoutGroup3(28)=BWBP_JCF_Pro.M7A3AssaultRifle
	 BlueLoadoutGroup3(29)=BWBP_OP_Pro.CX61AssaultRifle
	 BlueLoadoutGroup3(30)=BWBP_SKC_Pro.AK490BattleRifle
	 BlueLoadoutGroup3(31)=BWBP_SKC_Pro.AK91ChargeRifle
	 BlueLoadoutGroup3(32)=BWBP_SKC_Pro.CYLOFirestormAssaultWeapon
	 BlueLoadoutGroup3(33)=BWBP_SKC_Pro.CYLOUAW
	 BlueLoadoutGroup3(34)=BWBP_SKC_Pro.G51Carbine
	 BlueLoadoutGroup3(35)=BWBP_SKC_Pro.LK05Carbine
	 BlueLoadoutGroup3(36)=BWBP_SKC_Pro.MARSAssaultRifle
	 BlueLoadoutGroup3(37)=BWBP_SKC_Pro.SRXRifle
	 BlueLoadoutGroup3(38)=BallisticProV55.M46AssaultRifle
	 BlueLoadoutGroup3(39)=BallisticProV55.M50AssaultRifle
	 BlueLoadoutGroup3(40)=BallisticProV55.SARAssaultRifle
	 BlueLoadoutGroup3(41)=BWBP_OP_Pro.ProtonStreamer
	 BlueLoadoutGroup3(42)=BWBP_OP_Pro.Raygun
	 BlueLoadoutGroup3(43)=BWBP_OP_Pro.XOXOStaff
	 BlueLoadoutGroup3(44)=BWBP_SKC_Pro.A49SkrithBlaster
	 BlueLoadoutGroup3(45)=BWBP_SKC_Pro.AY90SkrithBoltcaster
	 BlueLoadoutGroup3(46)=BWBP_SKC_Pro.HVPCMk5PlasmaCannon
	 BlueLoadoutGroup3(47)=BWBP_SKC_Pro.HVPCMk66PlasmaCannon
	 BlueLoadoutGroup3(48)=BWBP_SKC_Pro.Supercharger_AssaultWeapon
	 BlueLoadoutGroup3(49)=BWBP_SKC_Pro.XM20Carbine
	 BlueLoadoutGroup3(50)=BWBP_SWC_Pro.A2WSkrithLance
	 BlueLoadoutGroup3(51)=BWBP_SWC_Pro.SkrithStaff
	 BlueLoadoutGroup3(52)=BallisticProV55.HVCMk9LightningGun
	 BlueLoadoutGroup3(53)=BallisticProV55.RSDarkStar
	 BlueLoadoutGroup3(54)=BallisticProV55.RSNovaStaff
	 BlueLoadoutGroup3(55)=BWBP_APC_Pro.PKMMachinegun
	 BlueLoadoutGroup3(56)=BWBP_APC_Pro.TridentMachinegun
	 BlueLoadoutGroup3(57)=BWBP_OP_Pro.M575Machinegun
	 BlueLoadoutGroup3(58)=BWBP_OP_Pro.MX32Weapon
	 BlueLoadoutGroup3(59)=BWBP_OP_Pro.Z250Minigun
	 BlueLoadoutGroup3(60)=BWBP_SKC_Pro.AR23HeavyRifle
	 BlueLoadoutGroup3(61)=BWBP_SKC_Pro.FG50MachineGun
	 BlueLoadoutGroup3(62)=BWBP_SKC_Pro.MG36Carbine
	 BlueLoadoutGroup3(63)=BWBP_SWC_Pro.A800SkrithMinigun
	 BlueLoadoutGroup3(64)=BWBP_SWC_Pro.BRINKAssaultRifle
	 BlueLoadoutGroup3(65)=BallisticProV55.XMV850Minigun
	 BlueLoadoutGroup3(66)=BWBP_APC_Pro.FM13Shotgun
	 BlueLoadoutGroup3(67)=BWBP_APC_Pro.FM14Shotgun
	 BlueLoadoutGroup3(68)=BWBP_APC_Pro.Wrenchgun
	 BlueLoadoutGroup3(69)=BWBP_JCF_Pro.SPASShotgun
	 BlueLoadoutGroup3(70)=BWBP_OP_Pro.RCS715Shotgun
	 BlueLoadoutGroup3(71)=BWBP_OP_Pro.TrenchGun
	 BlueLoadoutGroup3(72)=BWBP_SKC_Pro.CoachGun
	 BlueLoadoutGroup3(73)=BWBP_SKC_Pro.MK781Shotgun
	 BlueLoadoutGroup3(74)=BWBP_SKC_Pro.SK410Shotgun
	 BlueLoadoutGroup3(75)=BWBP_SKC_Pro.SKASShotgun
	 BlueLoadoutGroup3(76)=BWBP_APC_Pro.HB4GrenadeBlaster
	 BlueLoadoutGroup3(77)=BWBP_APC_Pro.HydraBazooka
	 BlueLoadoutGroup3(78)=BWBP_JCF_Pro.RGPXBazooka
	 BlueLoadoutGroup3(79)=BWBP_OP_Pro.AkeronLauncher
	 BlueLoadoutGroup3(80)=BWBP_SKC_Pro.BulldogAssaultCannon
	 BlueLoadoutGroup3(81)=BWBP_SKC_Pro.FLASHLauncher
	 BlueLoadoutGroup3(82)=BWBP_SKC_Pro.LAWLauncher
	 BlueLoadoutGroup3(83)=BWBP_SKC_Pro.LonghornLauncher
	 BlueLoadoutGroup3(84)=BWBP_SKC_Pro.MGLauncher
	 BlueLoadoutGroup3(85)=BWBP_SKC_Pro.PugAssaultCannon
	 BlueLoadoutGroup3(86)=BWBP_SKC_Pro.PumaRepeater
	 BlueLoadoutGroup3(87)=BWBP_SKC_Pro.SMATLauncher
	 BlueLoadoutGroup3(88)=BWBP_SKC_Pro.ThumperGrenadeLauncher
	 BlueLoadoutGroup3(89)=BallisticProV55.MACWeapon
	 BlueLoadoutGroup3(90)=BallisticProV55.MRocketLauncher
	 BlueLoadoutGroup3(91)=BallisticProV55.RX22AFlamer
	 BlueLoadoutGroup3(92)=BWBP_APC_Pro.R9000ERifle
	 BlueLoadoutGroup3(93)=BWBP_JCF_Pro.M99Rifle
	 BlueLoadoutGroup3(94)=BWBP_OP_Pro.CX85AssaultWeapon
	 BlueLoadoutGroup3(95)=BWBP_OP_Pro.KF8XCrossbow
	 BlueLoadoutGroup3(96)=BWBP_OP_Pro.LightningRifle
	 BlueLoadoutGroup3(97)=BWBP_OP_Pro.R9A1RangerRifle
	 BlueLoadoutGroup3(98)=BWBP_SKC_Pro.AS50Rifle
	 BlueLoadoutGroup3(99)=BWBP_SKC_Pro.LS14Carbine
	 BlueLoadoutGroup3(100)=BWBP_SKC_Pro.M2020GaussDMR
	 BlueLoadoutGroup3(101)=BWBP_SKC_Pro.VSKTranqRifle
	 BlueLoadoutGroup3(102)=BWBP_SKC_Pro.X82Rifle
	 BlueLoadoutGroup4(1)=BallisticProV55.NRP57Grenade
	 BlueLoadoutGroup4(2)=BallisticProV55.FP7Grenade
	 BlueLoadoutGroup4(3)=BallisticProV55.FP9Explosive
	 BlueLoadoutGroup4(4)=BallisticProV55.BX5Mine
	 BlueLoadoutGroup4(5)=BallisticProV55.T10Grenade
	 BlueLoadoutGroup4(6)=BWBPAirstrikesPro.TargetDesignator
	 BlueLoadoutGroup4(7)=BWBP_APC_Pro.ScarabGrenade
	 BlueLoadoutGroup4(8)=BWBP_OP_Pro.L8GIAmmoPack
	 BlueLoadoutGroup4(9)=BWBP_SKC_Pro.ChaffGrenadeWeapon
	 BlueLoadoutGroup4(10)=BWBP_SKC_Pro.G28Grenade
	 BlueLoadoutGroup4(11)=BWBP_SKC_Pro.ICISStimpack
	 BlueLoadoutGroup4(12)=BWBP_SKC_Pro.XM84Flashbang
	 BlueLoadoutGroup4(13)=BWBP_SWC_Pro.A51Grenade
	 BlueLoadoutGroup4(14)=BWBP_SWC_Pro.APodCapsule
	 BlueLoadoutGroup4(15)=BWBP_SWC_Pro.NTOVBandage
	 BlueLoadoutGroup4(16)=BallisticProV55.M58Grenade
	 BlueLoadoutGroup4(17)=BallisticProV55.SandbagLayer
	 
     bHideLockers=True
     FriendlyName="BallisticPro: Team Loadout"
     Description="Team-based Ballistic Loadout."
}
