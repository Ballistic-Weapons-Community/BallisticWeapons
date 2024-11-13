class WeaponList_ConflictLoadout extends Object 
	PerObjectConfig
	config(BallisticProV55);

struct Entry
{
	var() config string 	ClassName;
	var() config bool		bRed;
	var() config bool		bBlue;
};

var() config array<Entry>	ConflictWeapons;	// 	Big list of all available weapons and the teams for which they are selectable
var() config byte			LoadoutOption;		//	0: Normal loadout, 1: Evolution skill requirements, 2: Purchasing system (not implemented yet)

defaultproperties
{
	 ConflictWeapons(0)=(ClassName="BallisticProV55.X3Knife",bRed=True,bBlue=True)
	 ConflictWeapons(1)=(ClassName="BallisticProV55.X4Knife",bRed=True,bBlue=True)
	 ConflictWeapons(2)=(ClassName="BallisticProV55.A909SkrithBlades",bRed=True,bBlue=True)
	 ConflictWeapons(3)=(ClassName="BallisticProV55.EKS43Katana",bRed=True,bBlue=True)

	 ConflictWeapons(4)=(ClassName="BallisticProV55.A42SkrithPistol",bRed=True,bBlue=True)
	 ConflictWeapons(5)=(ClassName="BallisticProV55.AM67Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(6)=(ClassName="BallisticProV55.BOGPPistol",bRed=True,bBlue=True)
	 ConflictWeapons(7)=(ClassName="BallisticProV55.D49Revolver",bRed=True,bBlue=True)
	 ConflictWeapons(8)=(ClassName="BallisticProV55.M806Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(9)=(ClassName="BallisticProV55.MD24Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(10)=(ClassName="BallisticProV55.MRT6Shotgun",bRed=True,bBlue=True)
	 ConflictWeapons(11)=(ClassName="BallisticProV55.RS8Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(12)=(ClassName="BallisticProV55.leMatRevolver",bRed=True,bBlue=True)
	 
	 ConflictWeapons(13)=(ClassName="BallisticProV55.A500Reptile",bRed=True,bBlue=True)
	 ConflictWeapons(14)=(ClassName="BallisticProV55.A73SkrithRifle",bRed=True,bBlue=True)
	 ConflictWeapons(15)=(ClassName="BallisticProV55.E23PlasmaRifle",bRed=True,bBlue=True)
	 ConflictWeapons(16)=(ClassName="BallisticProV55.Fifty9MachinePistol",bRed=True,bBlue=True)
	 ConflictWeapons(17)=(ClassName="BallisticProV55.G5Bazooka",bRed=True,bBlue=True)
	 ConflictWeapons(18)=(ClassName="BallisticProV55.GRS9Pistol",bRed=True,bBlue=True)
	 ConflictWeapons(19)=(ClassName="BallisticProV55.HVCMk9LightningGun",bRed=True,bBlue=True)
	 ConflictWeapons(20)=(ClassName="BallisticProV55.M290Shotgun",bRed=True,bBlue=True)
	 ConflictWeapons(21)=(ClassName="BallisticProV55.M353Machinegun",bRed=True,bBlue=True)
	 ConflictWeapons(22)=(ClassName="BallisticProV55.M46AssaultRifle",bRed=True,bBlue=True)
	 ConflictWeapons(23)=(ClassName="BallisticProV55.M50AssaultRifle",bRed=True,bBlue=True)
	 ConflictWeapons(24)=(ClassName="BallisticProV55.M75Railgun",bRed=True,bBlue=True)
	 ConflictWeapons(25)=(ClassName="BallisticProV55.M763Shotgun",bRed=True,bBlue=True)
	 ConflictWeapons(26)=(ClassName="BallisticProV55.M925Machinegun",bRed=True,bBlue=True)
	 ConflictWeapons(27)=(ClassName="BallisticProV55.MACWeapon",bRed=True,bBlue=True)
	 ConflictWeapons(28)=(ClassName="BallisticProV55.MRS138Shotgun",bRed=True,bBlue=True)
	 ConflictWeapons(29)=(ClassName="BallisticProV55.MRocketLauncher",bRed=True,bBlue=True)
	 ConflictWeapons(30)=(ClassName="BallisticProV55.MarlinRifle",bRed=True,bBlue=True)
	 ConflictWeapons(31)=(ClassName="BallisticProV55.R78Rifle",bRed=True,bBlue=True)
	 ConflictWeapons(32)=(ClassName="BallisticProV55.RSDarkStar",bRed=True,bBlue=True)
	 ConflictWeapons(33)=(ClassName="BallisticProV55.RSNovaStaff",bRed=True,bBlue=True)
	 ConflictWeapons(34)=(ClassName="BallisticProV55.RX22AFlamer",bRed=True,bBlue=True)
	 ConflictWeapons(35)=(ClassName="BallisticProV55.SARAssaultRifle",bRed=True,bBlue=True)
	 ConflictWeapons(36)=(ClassName="BallisticProV55.SRS900Rifle",bRed=True,bBlue=True)
	 ConflictWeapons(37)=(ClassName="BallisticProV55.XK2SubMachinegun",bRed=True,bBlue=True)
	 ConflictWeapons(38)=(ClassName="BallisticProV55.XMK5SubMachinegun",bRed=True,bBlue=True)
	 ConflictWeapons(39)=(ClassName="BallisticProV55.XMV850Minigun",bRed=True,bBlue=True)
	 ConflictWeapons(40)=(ClassName="BallisticProV55.XRS10SubMachinegun",bRed=True,bBlue=True)

	 ConflictWeapons(41)=(ClassName="BallisticProV55.FP7Grenade",bRed=True,bBlue=True)
	 ConflictWeapons(42)=(ClassName="BallisticProV55.FP9Explosive",bRed=True,bBlue=True)
	 ConflictWeapons(43)=(ClassName="BallisticProV55.M58Grenade",bRed=True,bBlue=True)
	 ConflictWeapons(44)=(ClassName="BallisticProV55.NRP57Grenade",bRed=True,bBlue=True)
	 ConflictWeapons(45)=(ClassName="BallisticProV55.SandbagLayer",bRed=True,bBlue=True)
	 ConflictWeapons(46)=(ClassName="BallisticProV55.T10Grenade",bRed=True,bBlue=True)
}