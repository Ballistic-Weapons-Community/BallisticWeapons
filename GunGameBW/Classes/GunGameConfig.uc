// ====================================================================
//  GunGameConfig
//
// Holds specific shared configuration settings for GunGame,
// so that the gametypes can be configured in UT2004.ini instead of 
// a separate one.
// ====================================================================
class GunGameConfig extends Object
	abstract
	config(GunGameBW);

var config array< class<Weapon> > 	WeaponList;         //Default weapon set

defaultproperties
{
	WeaponList(0)=Class'BallisticProV55.EKS43Katana'	//standard weapon

	// ordnance
	WeaponList(1)=Class'BallisticProV55.MACWeapon'
	WeaponList(2)=Class'BWBP_SKC_Pro.FLASHLauncher'
	WeaponList(3)=Class'BWBP_SKC_Pro.PUMARepeater'	
	WeaponList(4)=Class'BWBP_SKC_Pro.MGLauncher'
	WeaponList(5)=Class'BallisticProV55.G5Bazooka'
	WeaponList(6)=Class'BWBP_SKC_Pro.PugAssaultCannon'	
	WeaponList(7)=Class'BallisticProV55.MRocketLauncher'
	WeaponList(8)=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'	
	WeaponList(9)=Class'BallisticProV55.RX22AFlamer'
	WeaponList(10)=Class'BWBP_SKC_Pro.BulldogAssaultCannon'
	WeaponList(11)=Class'BWBP_SKC_Pro.LAWlauncher'	
	WeaponList(12)=Class'BWBP_OP_Pro.AkeronLauncher'
	WeaponList(13)=Class'BWBP_SKC_Pro.SMATLauncher'	
	WeaponList(14)=Class'BWBP_SKC_Pro.LonghornLauncher'
	WeaponList(15)=Class'BWBP_JCF_Pro.RGPXBazooka'

	// machinegun
	WeaponList(16)=Class'BWBP_SKC_Pro.FG50MachineGun'
	WeaponList(17)=Class'BallisticProV55.XMV850Minigun'
	WeaponList(18)=Class'BallisticProV55.M925Machinegun'
	WeaponList(19)=Class'BWBP_OP_Pro.M575Machinegun'
	WeaponList(20)=Class'BWBP_OP_Pro.Z250Minigun'
	WeaponList(21)=Class'BWBP_SWC_Pro.BRINKAssaultRifle'	
	WeaponList(22)=Class'BWBP_SKC_Pro.MG36Machinegun'		
	WeaponList(23)=Class'BWBP_OP_Pro.CX85AssaultWeapon'
	WeaponList(24)=Class'BWBP_OP_Pro.MX32Weapon'
	WeaponList(25)=Class'BWBP_SWC_Pro.A800SkrithMinigun'	
	WeaponList(26)=Class'BallisticProV55.M353Machinegun'
	WeaponList(27)=Class'BWBP_SKC_Pro.AR23HeavyRifle'	

	// sniper
	WeaponList(28)=Class'BallisticProV55.M75Railgun'
	WeaponList(29)=Class'BWBP_SKC_Pro.M2020GaussDMR'
	WeaponList(30)=Class'BWBP_SKC_Pro.AS50Rifle'
	WeaponList(31)=Class'BWBP_SKC_Pro.X82Rifle'
	WeaponList(32)=Class'BWBP_SKC_Pro.VSKTranqRifle'	
	WeaponList(33)=Class'BallisticProV55.SRS900Rifle'
	WeaponList(34)=Class'BWBP_JCF_Pro.M99Rifle'	
	WeaponList(35)=Class'BWBP_OP_Pro.R9A1RangerRifle'
	WeaponList(36)=Class'BWBP_OP_Pro.LightningRifle'	
	WeaponList(37)=Class'BallisticProV55.MarlinRifle'
	WeaponList(38)=Class'BallisticProV55.R78Rifle'
	WeaponList(39)=Class'BWBP_OP_Pro.KF8XCrossbow'

	// rifle
	WeaponList(40)=Class'BWBP_SKC_Pro.MARSAssaultRifle'
	WeaponList(41)=Class'BWBP_SKC_Pro.G51Carbine'
	WeaponList(42)=Class'BWBP_JCF_Pro.M7A3AssaultRifle'	
	WeaponList(43)=Class'BallisticProV55.M50AssaultRifle'
	WeaponList(44)=Class'BWBP_SKC_Pro.SRXRifle'
	WeaponList(45)=Class'BallisticProV55.M46AssaultRifle'
	WeaponList(46)=Class'BWBP_SKC_Pro.LK05Carbine'
	WeaponList(47)=Class'BWBP_SKC_Pro.AK490BattleRifle'
	WeaponList(48)=Class'BWBP_OP_Pro.CX61AssaultRifle'
	WeaponList(49)=Class'BWBP_SKC_Pro.CYLOUAW'
	WeaponList(50)=Class'BWBP_SKC_Pro.AK91ChargeRifle'	
	WeaponList(51)=Class'BallisticProV55.SARAssaultRifle'

	// energy
	WeaponList(52)=Class'BallisticProV55.HVCMk9LightningGun'
	WeaponList(53)=Class'BallisticProV55.E23PlasmaRifle'
	WeaponList(54)=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
	WeaponList(55)=Class'BWBP_OP_Pro.ProtonStreamer'
	WeaponList(56)=Class'BallisticProV55.A73SkrithRifle'
	WeaponList(57)=Class'BWBP_SKC_Pro.HMCBeamCannon'
	WeaponList(58)=Class'BWBP_SKC_Pro.LS14Carbine'
	WeaponList(59)=Class'BWBP_SKC_Pro.XM20Carbine'
	WeaponList(60)=Class'BWBP_SKC_Pro.HVPCMk66PlasmaCannon'
	WeaponList(61)=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'	
	WeaponList(62)=Class'BallisticProV55.RSDarkStar'
	WeaponList(63)=Class'BallisticProV55.RSNovaStaff'
	WeaponList(64)=Class'BWBP_OP_Pro.XOXOStaff'
	WeaponList(65)=Class'BWBP_OP_Pro.Raygun'
	WeaponList(66)=Class'BWBP_SKC_Pro.A49SkrithBlaster'
	WeaponList(67)=Class'BWBP_SKC_Pro.HVPCMk5PlasmaCannon'

	// shotgun
	WeaponList(68)=Class'BallisticProV55.M290Shotgun'
	WeaponList(69)=Class'BWBP_SKC_Pro.SKASShotgun'
	WeaponList(70)=Class'BWBP_OP_Pro.RCS715Shotgun'
	WeaponList(71)=Class'BWBP_SKC_Pro.MK781Shotgun'
	WeaponList(72)=Class'BWBP_OP_Pro.FM13Shotgun'	
	WeaponList(73)=Class'BallisticProV55.M763Shotgun'
	WeaponList(74)=Class'BallisticProV55.MRS138Shotgun'
	WeaponList(75)=Class'BWBP_JCF_Pro.SPASShotgun'
	WeaponList(76)=Class'BWBP_SKC_Pro.CoachGun'
	WeaponList(77)=Class'BWBP_SKC_Pro.SK410Shotgun'
	WeaponList(78)=Class'BallisticProV55.A500Reptile'

	// smg
	WeaponList(79)=Class'BallisticProV55.XMK5SubMachinegun'
	WeaponList(80)=Class'BallisticProV55.XK2SubMachinegun'
	WeaponList(81)=Class'BWBP_SKC_Pro.MRDRMachinePistol'	
	WeaponList(82)=Class'BWBP_SKC_Pro.TyphonPDW'
	WeaponList(83)=Class'BallisticProV55.Fifty9MachinePistol'
	WeaponList(84)=Class'BWBP_OP_Pro.FC01SmartGun'	
	WeaponList(85)=Class'BWBP_SKC_Pro.PS9mPistol'	
	WeaponList(86)=Class'BallisticProV55.XRS10SubMachinegun'	
	WeaponList(87)=Class'BWBP_SWC_Pro.MDKSubMachinegun'
	WeaponList(88)=Class'BWBP_SKC_Pro.FMPMachinePistol'	
	WeaponList(89)=Class'BWBP_SKC_Pro.T9CNMachinePistol'		
	WeaponList(90)=Class'BallisticProV55.GRS9Pistol'
	WeaponList(91)=Class'BWBP_SKC_Pro.GRSXXPistol'	

	// handgun
	WeaponList(92)=Class'BallisticProV55.BOGPPistol'
	WeaponList(93)=Class'BallisticProV55.AM67Pistol'
	WeaponList(94)=Class'BallisticProV55.RS8Pistol'
	WeaponList(95)=Class'BWBP_OP_Pro.PD97Bloodhound'	
	WeaponList(96)=Class'BWBP_SKC_Pro.AH250Pistol'
	WeaponList(97)=Class'BWBP_SKC_Pro.SX45Pistol'
	WeaponList(98)=Class'BWBP_SKC_Pro.AH104Pistol'	
	WeaponList(99)=Class'BallisticProV55.D49Revolver'
	WeaponList(100)=Class'BallisticProV55.leMatRevolver'	
	WeaponList(101)=Class'BallisticProV55.M806Pistol'	
	WeaponList(102)=Class'BallisticProV55.MRT6Shotgun'
	WeaponList(103)=Class'BallisticProV55.A42SkrithPistol'
	WeaponList(104)=Class'BWBP_SKC_Pro.RS04Pistol'
	WeaponList(105)=Class'BallisticProV55.MD24Pistol'

	WeaponList(106)=Class'BWBP_OP_Pro.FlameSword' // the melee section just sucks
}