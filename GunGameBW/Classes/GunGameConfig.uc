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
	WeaponList(3)=Class'BWBP_SKC_Pro.MGLauncher'
	WeaponList(4)=Class'BallisticProV55.G5Bazooka'
	WeaponList(5)=Class'BallisticProV55.MRocketLauncher'
	WeaponList(6)=Class'BallisticProV55.RX22AFlamer'
	WeaponList(7)=Class'BWBP_SKC_Pro.BulldogAssaultCannon'
	WeaponList(8)=Class'BWBP_OP_Pro.AkeronLauncher'
	WeaponList(9)=Class'BWBP_SKC_Pro.LonghornLauncher'

	// machinegun
	WeaponList(10)=Class'BWBP_SKC_Pro.FG50MachineGun'
	WeaponList(11)=Class'BallisticProV55.XMV850Minigun'
	WeaponList(12)=Class'BallisticProV55.M925Machinegun'
	WeaponList(13)=Class'BWBP_OP_Pro.Z250Minigun'
	WeaponList(14)=Class'BWBP_OP_Pro.CX85AssaultWeapon'
	WeaponList(15)=Class'BallisticProV55.M353Machinegun'

	// sniper
	WeaponList(16)=Class'BallisticProV55.M75Railgun'
	WeaponList(17)=Class'BWBP_SKC_Pro.M2020GaussDMR'
	WeaponList(18)=Class'BWBP_SKC_Pro.AS50Rifle'
	WeaponList(19)=Class'BWBP_SKC_Pro.X82Rifle'
	WeaponList(20)=Class'BallisticProV55.SRS900Rifle'
	WeaponList(21)=Class'BWBP_OP_Pro.R9A1RangerRifle'
	WeaponList(22)=Class'BallisticProV55.MarlinRifle'
	WeaponList(23)=Class'BallisticProV55.R78Rifle'
	WeaponList(24)=Class'BWBP_OP_Pro.KF8XCrossbow'

	// rifle
	WeaponList(25)=Class'BWBP_SKC_Pro.MARSAssaultRifle'
	WeaponList(26)=Class'BWBP_SKC_Pro.G51Carbine'
	WeaponList(27)=Class'BWBP_SKC_Pro.CYLOFirestormAssaultWeapon'
	WeaponList(28)=Class'BallisticProV55.M50AssaultRifle'
	WeaponList(29)=Class'BallisticProV55.M46AssaultRifle'
	WeaponList(30)=Class'BWBP_SKC_Pro.LK05Carbine'
	WeaponList(31)=Class'BWBP_SKC_Pro.AK490BattleRifle'
	WeaponList(32)=Class'BWBP_OP_Pro.CX61AssaultRifle'
	WeaponList(33)=Class'BWBP_SKC_Pro.CYLOUAW'
	WeaponList(34)=Class'BallisticProV55.SARAssaultRifle'

	// energy
	WeaponList(35)=Class'BallisticProV55.HVCMk9LightningGun'
	WeaponList(36)=Class'BallisticProV55.E23PlasmaRifle'
	WeaponList(37)=Class'BallisticProV55.A73SkrithRifle'
	WeaponList(38)=Class'BWBP_SKC_Pro.LS14Carbine'
	WeaponList(39)=Class'BWBP_SKC_Pro.XM20Carbine'
	WeaponList(40)=Class'BallisticProV55.RSDarkStar
	WeaponList(41)=Class'BallisticProV55.RSNovaStaff'
	WeaponList(42)=Class'BWBP_OP_Pro.XOXOStaff'
	WeaponList(43)=Class'BWBP_OP_Pro.Raygun'
	WeaponList(44)=Class'BWBP_SKC_Pro.A49SkrithBlaster'

	// shotgun
	WeaponList(45)=Class'BallisticProV55.M290Shotgun'
	WeaponList(46)=Class'BWBP_SKC_Pro.SKASShotgun'
	WeaponList(47)=Class'BWBP_OP_Pro.RCS715Shotgun'
	WeaponList(48)=Class'BWBP_SKC_Pro.MK781Shotgun'
	WeaponList(49)=Class'BallisticProV55.M763Shotgun'
	WeaponList(50)=Class'BallisticProV55.MRS138Shotgun'
	WeaponList(51)=Class'BWBP_OP_Pro.TrenchGun'
	WeaponList(52)=Class'BWBP_SKC_Pro.CoachGun'
	WeaponList(53)=Class'BWBP_SKC_Pro.SK410Shotgun'
	WeaponList(54)=Class'BallisticProV55.A500Reptile'

	// smg
	WeaponList(55)=Class'BallisticProV55.XMK5SubMachinegun'
	WeaponList(56)=Class'BallisticProV55.XK2SubMachinegun'
	WeaponList(57)=Class'BallisticProV55.Fifty9MachinePistol'
	WeaponList(58)=Class'BallisticProV55.XRS10SubMachinegun'
	WeaponList(59)=Class'BallisticProV55.GRS9Pistol'

	// handgun
	WeaponList(60)=Class'BallisticProV55.BOGPPistol'
	WeaponList(61)=Class'BallisticProV55.AM67Pistol'
	WeaponList(62)=Class'BWBP_SKC_Pro.AH250Pistol'
	WeaponList(63)=Class'BallisticProV55.D49Revolver'
	WeaponList(64)=Class'BallisticProV55.MRT6Shotgun'
	WeaponList(65)=Class'BallisticProV55.MD24Pistol'

	WeaponList(66)=Class'BWBP_OP_Pro.FlameSword' // the melee section just sucks
}