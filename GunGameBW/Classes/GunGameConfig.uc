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
	WeaponList(0)=Class'BallisticProV55.X3Knife'	//standard weapon

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
	WeaponList(24)=Class'BWBP_OP_Pro.BX85Crossbow'

	// rifle
	WeaponList(25)=Class'BWBP_SKC_Pro.MARSAssaultRifle'
	WeaponList(26)=Class'BWBP_SKC_Pro.F2000AssaultRifle'
	WeaponList(27)=Class'BWBP_SKC_Pro.CYLOFirestormAssaultWeapon'
	WeaponList(28)=Class'BallisticProV55.SRS600Rifle'
	WeaponList(29)=Class'BallisticProV55.M50AssaultRifle'
	WeaponList(30)=Class'BallisticProV55.M46AssaultRifle'
	WeaponList(31)=Class'BWBP_SKC_Pro.LK05Carbine'
	WeaponList(32)=Class'BWBP_SKC_Pro.AK47AssaultRifle'
	WeaponList(33)=Class'BWBP_OP_Pro.CX61AssaultRifle'
	WeaponList(34)=Class'BWBP_SKC_Pro.CYLOUAW'
	WeaponList(35)=Class'BallisticProV55.SARAssaultRifle'

	// energy
	WeaponList(36)=Class'BallisticProV55.HVCMk9LightningGun'
	WeaponList(37)=Class'BallisticProV55.E23PlasmaRifle'
	WeaponList(38)=Class'BallisticProV55.A73SkrithRifle'
	WeaponList(39)=Class'BWBP_SKC_Pro.LS14Carbine'
	WeaponList(40)=Class'BWBP_OP_Pro.XM20AutoLas'
	WeaponList(41)=Class'BallisticProV55.RSDarkStar
	WeaponList(42)=Class'BallisticProV55.RSNovaStaff'
	WeaponList(43)=Class'BWBP_OP_Pro.XOXOStaff'
	WeaponList(44)=Class'BWBP_OP_Pro.Raygun'
	WeaponList(45)=Class'BWBP_SKC_Pro.A49SkrithBlaster'

	// shotgun
	WeaponList(46)=Class'BallisticProV55.M290Shotgun'
	WeaponList(47)=Class'BWBP_SKC_Pro.SKASShotgun'
	WeaponList(48)=Class'BWBP_OP_Pro.ARShotgun'
	WeaponList(49)=Class'BWBP_SKC_Pro.MK781Shotgun'
	WeaponList(50)=Class'BallisticProV55.M763Shotgun'
	WeaponList(51)=Class'BallisticProV55.MRS138Shotgun'
	WeaponList(52)=Class'BWBP_OP_Pro.TrenchGun'
	WeaponList(53)=Class'BWBP_SKC_Pro.CoachGun'
	WeaponList(54)=Class'BWBP_SKC_Pro.SK410Shotgun'
	WeaponList(55)=Class'BallisticProV55.A500Reptile'

	// smg
	WeaponList(56)=Class'BallisticProV55.XMK5SubMachinegun'
	WeaponList(57)=Class'BallisticProV55.XK2SubMachinegun'
	WeaponList(58)=Class'BallisticProV55.Fifty9MachinePistol'
	WeaponList(59)=Class'BallisticProV55.XRS10SubMachinegun'
	WeaponList(60)=Class'BallisticProV55.GRS9Pistol'
	WeaponList(61)=Class'BWBP_SKC_Pro.MRDRMachinePistol'

	// handgun
	WeaponList(62)=Class'BallisticProV55.BOGPPistol'
	WeaponList(63)=Class'BallisticProV55.AM67Pistol'
	WeaponList(64)=Class'BWBP_SKC_Pro.AH250Pistol'
	WeaponList(65)=Class'BallisticProV55.D49Revolver'
	WeaponList(66)=Class'BallisticProV55.leMatRevolver'
	WeaponList(67)=Class'BallisticProV55.MRT6Shotgun'
	WeaponList(68)=Class'BallisticProV55.RS8Pistol'
	WeaponList(69)=Class'BallisticProV55.MD24Pistol'
	WeaponList(70)=Class'BallisticProV55.A42SkrithPistol'
	WeaponList(71)=Class'BWBP_SKC_Pro.PS9mPistol'

	WeaponList(72)=Class'BWBP_OP_Pro.FlameSword' // the melee section just sucks
}