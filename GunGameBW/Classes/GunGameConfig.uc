// ====================================================================
//  GunGameConfig
//
// Holds specific shared configuration settings for GunGame,
// in GunGameBW.ini. The weapon list is made in the game options' Weapon List menu (GunGameWeaponMenu).
// ====================================================================
class GunGameConfig extends Object
	abstract
	DependsOn(BC_GameStyle)
	config(GunGameBW);

var config array< class<Weapon> > 	WeaponList;			// The level order (GunGameBW.ini), written in full by the Weapon List menu; can be copied to a server or edited by hand. Empty: the stock list
var array< class<Weapon> >			StockWeaponList;	// The level order GunGame comes with. The first weapon is the standard weapon

const MIN_WEAPONS = 2;
const MAX_WEAPONS = 255;	// GunGameGRI.HighestLevel is a byte

// The level order a game plays: the host's own list when it has enough weapons that load, else the stock list
static function GetWeaponList(out array< class<Weapon> > List)
{
	local int i;

	List.Length = 0;

	for (i = 0; i < default.WeaponList.Length; i++)
		if (default.WeaponList[i] != None && List.Length < MAX_WEAPONS)
			List[List.Length] = default.WeaponList[i];

	if (List.Length >= MIN_WEAPONS)
		return;

	if (default.WeaponList.Length > 0)
		Log("GunGameConfig: the custom weapon list has "$List.Length$" weapons that load, using the stock list");

	List.Length = 0;
	for (i = 0; i < default.StockWeaponList.Length; i++)
		if (default.StockWeaponList[i] != None && List.Length < MAX_WEAPONS)
			List[List.Length] = default.StockWeaponList[i];
}

// GunGame's Game Style option. GunGame does not allow the style mutators, so the style is set the way they set it:
// before the Ballistic mutator spawns, which reads it to fill the BallisticReplicationInfo. Not saved to System.ini
static function ApplyGameStyle(byte Style)
{
	switch (Style)
	{
		case 1:		class'BallisticGameStyles'.default.CurrentStyle = GS_Classic;	break;
		case 2:		class'BallisticGameStyles'.default.CurrentStyle = GS_Realism;	break;
		case 3:		class'BallisticGameStyles'.default.CurrentStyle = GS_Tactical;	break;
		default:	class'BallisticGameStyles'.default.CurrentStyle = GS_Pro;		break;
	}
}

static function int MinWeapons()
{
	return MIN_WEAPONS;
}

static function int MaxWeapons()
{
	return MAX_WEAPONS;
}

static function string GameStyleOptions()
{
	return "0;Pro;1;Classic;2;Realism;3;Tactical";
}

defaultproperties
{
	StockWeaponList(0)=Class'BallisticProV55.EKS43Katana'	//standard weapon

	// ordnance
	StockWeaponList(1)=Class'BallisticProV55.MACWeapon'
	StockWeaponList(2)=Class'BWBP_SKC_Pro.FLASHLauncher'
	StockWeaponList(3)=Class'BWBP_SKC_Pro.PUMARepeater'	
	StockWeaponList(4)=Class'BWBP_SKC_Pro.MGLauncher'
	StockWeaponList(5)=Class'BallisticProV55.G5Bazooka'
	StockWeaponList(6)=Class'BWBP_SKC_Pro.PugAssaultCannon'	
	StockWeaponList(7)=Class'BallisticProV55.MRocketLauncher'
	StockWeaponList(8)=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'	
	StockWeaponList(9)=Class'BallisticProV55.RX22AFlamer'
	StockWeaponList(10)=Class'BWBP_SKC_Pro.BulldogAssaultCannon'
	StockWeaponList(11)=Class'BWBP_SKC_Pro.LAWlauncher'	
	StockWeaponList(12)=Class'BWBP_OP_Pro.AkeronLauncher'
	StockWeaponList(13)=Class'BWBP_SKC_Pro.SMATLauncher'	
	StockWeaponList(14)=Class'BWBP_SKC_Pro.LonghornLauncher'
	StockWeaponList(15)=Class'BWBP_JCF_Pro.RGPXBazooka'

	// machinegun
	StockWeaponList(16)=Class'BWBP_SKC_Pro.FG50MachineGun'
	StockWeaponList(17)=Class'BallisticProV55.XMV850Minigun'
	StockWeaponList(18)=Class'BallisticProV55.M925Machinegun'
	StockWeaponList(19)=Class'BWBP_OP_Pro.M575Machinegun'
	StockWeaponList(20)=Class'BWBP_OP_Pro.Z250Minigun'
	StockWeaponList(21)=Class'BWBP_SWC_Pro.BRINKAssaultRifle'	
	StockWeaponList(22)=Class'BWBP_SKC_Pro.MG36Machinegun'		
	StockWeaponList(23)=Class'BWBP_OP_Pro.CX85AssaultWeapon'
	StockWeaponList(24)=Class'BWBP_OP_Pro.MX32Weapon'
	StockWeaponList(25)=Class'BWBP_SWC_Pro.A800SkrithMinigun'	
	StockWeaponList(26)=Class'BallisticProV55.M353Machinegun'
	StockWeaponList(27)=Class'BWBP_SKC_Pro.AR23HeavyRifle'	

	// sniper
	StockWeaponList(28)=Class'BallisticProV55.M75Railgun'
	StockWeaponList(29)=Class'BWBP_SKC_Pro.M2020GaussDMR'
	StockWeaponList(30)=Class'BWBP_SKC_Pro.AS50Rifle'
	StockWeaponList(31)=Class'BWBP_SKC_Pro.X82Rifle'
	StockWeaponList(32)=Class'BWBP_SKC_Pro.VSKTranqRifle'	
	StockWeaponList(33)=Class'BallisticProV55.SRS900Rifle'
	StockWeaponList(34)=Class'BWBP_JCF_Pro.M99Rifle'	
	StockWeaponList(35)=Class'BWBP_OP_Pro.R9A1RangerRifle'
	StockWeaponList(36)=Class'BWBP_OP_Pro.LightningRifle'	
	StockWeaponList(37)=Class'BallisticProV55.MarlinRifle'
	StockWeaponList(38)=Class'BallisticProV55.R78Rifle'
	StockWeaponList(39)=Class'BWBP_OP_Pro.KF8XCrossbow'

	// rifle
	StockWeaponList(40)=Class'BWBP_SKC_Pro.MARSAssaultRifle'
	StockWeaponList(41)=Class'BWBP_SKC_Pro.G51Carbine'
	StockWeaponList(42)=Class'BWBP_JCF_Pro.M7A3AssaultRifle'	
	StockWeaponList(43)=Class'BallisticProV55.M50AssaultRifle'
	StockWeaponList(44)=Class'BWBP_SKC_Pro.SRXRifle'
	StockWeaponList(45)=Class'BallisticProV55.M46AssaultRifle'
	StockWeaponList(46)=Class'BWBP_SKC_Pro.LK05Carbine'
	StockWeaponList(47)=Class'BWBP_SKC_Pro.AK490BattleRifle'
	StockWeaponList(48)=Class'BWBP_OP_Pro.CX61AssaultRifle'
	StockWeaponList(49)=Class'BWBP_SKC_Pro.CYLOUAW'
	StockWeaponList(50)=Class'BWBP_SKC_Pro.AK91ChargeRifle'	
	StockWeaponList(51)=Class'BallisticProV55.SARAssaultRifle'

	// energy
	StockWeaponList(52)=Class'BallisticProV55.HVCMk9LightningGun'
	StockWeaponList(53)=Class'BallisticProV55.E23PlasmaRifle'
	StockWeaponList(54)=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
	StockWeaponList(55)=Class'BWBP_OP_Pro.ProtonStreamer'
	StockWeaponList(56)=Class'BallisticProV55.A73SkrithRifle'
	StockWeaponList(57)=Class'BWBP_SKC_Pro.HMCBeamCannon'
	StockWeaponList(58)=Class'BWBP_SKC_Pro.LS14Carbine'
	StockWeaponList(59)=Class'BWBP_SKC_Pro.XM20Carbine'
	StockWeaponList(60)=Class'BWBP_SKC_Pro.HVPCMk66PlasmaCannon'
	StockWeaponList(61)=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'	
	StockWeaponList(62)=Class'BallisticProV55.RSDarkStar'
	StockWeaponList(63)=Class'BallisticProV55.RSNovaStaff'
	StockWeaponList(64)=Class'BWBP_OP_Pro.XOXOStaff'
	StockWeaponList(65)=Class'BWBP_OP_Pro.Raygun'
	StockWeaponList(66)=Class'BWBP_SKC_Pro.A49SkrithBlaster'
	StockWeaponList(67)=Class'BWBP_SKC_Pro.HVPCMk5PlasmaCannon'

	// shotgun
	StockWeaponList(68)=Class'BallisticProV55.M290Shotgun'
	StockWeaponList(69)=Class'BWBP_SKC_Pro.SKASShotgun'
	StockWeaponList(70)=Class'BWBP_OP_Pro.RCS715Shotgun'
	StockWeaponList(71)=Class'BWBP_SKC_Pro.MK781Shotgun'
	StockWeaponList(72)=Class'BWBP_OP_Pro.FM13Shotgun'	
	StockWeaponList(73)=Class'BallisticProV55.M763Shotgun'
	StockWeaponList(74)=Class'BallisticProV55.MRS138Shotgun'
	StockWeaponList(75)=Class'BWBP_JCF_Pro.SPASShotgun'
	StockWeaponList(76)=Class'BWBP_SKC_Pro.CoachGun'
	StockWeaponList(77)=Class'BWBP_SKC_Pro.SK410Shotgun'
	StockWeaponList(78)=Class'BallisticProV55.A500Reptile'

	// smg
	StockWeaponList(79)=Class'BallisticProV55.XMK5SubMachinegun'
	StockWeaponList(80)=Class'BallisticProV55.XK2SubMachinegun'
	StockWeaponList(81)=Class'BWBP_SKC_Pro.MRDRMachinePistol'	
	StockWeaponList(82)=Class'BWBP_SKC_Pro.TyphonPDW'
	StockWeaponList(83)=Class'BallisticProV55.Fifty9MachinePistol'
	StockWeaponList(84)=Class'BWBP_OP_Pro.FC01SmartGun'	
	StockWeaponList(85)=Class'BWBP_SKC_Pro.PS9mPistol'	
	StockWeaponList(86)=Class'BallisticProV55.XRS10SubMachinegun'	
	StockWeaponList(87)=Class'BWBP_SWC_Pro.MDKSubMachinegun'
	StockWeaponList(88)=Class'BWBP_SKC_Pro.FMPMachinePistol'	
	StockWeaponList(89)=Class'BWBP_SKC_Pro.T9CNMachinePistol'		
	StockWeaponList(90)=Class'BallisticProV55.GRS9Pistol'
	StockWeaponList(91)=Class'BWBP_SKC_Pro.GRSXXPistol'	

	// handgun
	StockWeaponList(92)=Class'BallisticProV55.BOGPPistol'
	StockWeaponList(93)=Class'BallisticProV55.AM67Pistol'
	StockWeaponList(94)=Class'BallisticProV55.RS8Pistol'
	StockWeaponList(95)=Class'BWBP_OP_Pro.PD97Bloodhound'	
	StockWeaponList(96)=Class'BWBP_SKC_Pro.AH250Pistol'
	StockWeaponList(97)=Class'BWBP_SKC_Pro.SX45Pistol'
	StockWeaponList(98)=Class'BWBP_SKC_Pro.AH104Pistol'	
	StockWeaponList(99)=Class'BallisticProV55.D49Revolver'
	StockWeaponList(100)=Class'BallisticProV55.leMatRevolver'	
	StockWeaponList(101)=Class'BallisticProV55.M806Pistol'	
	StockWeaponList(102)=Class'BallisticProV55.MRT6Shotgun'
	StockWeaponList(103)=Class'BallisticProV55.A42SkrithPistol'
	StockWeaponList(104)=Class'BWBP_SKC_Pro.RS04Pistol'
	StockWeaponList(105)=Class'BallisticProV55.MD24Pistol'

	StockWeaponList(106)=Class'BWBP_OP_Pro.FlameSword' // the melee section just sucks
}