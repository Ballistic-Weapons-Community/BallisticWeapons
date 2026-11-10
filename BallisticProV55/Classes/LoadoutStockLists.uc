//=============================================================================
// LoadoutStockLists
//
// The Loadout lists Ballistic Weapons comes with, for the Loadout tab's
// DEFAULTS. The mutators' own lists (Mut_Outfitting.LoadoutGroup0-4,
// Mut_TeamOutfitting.Red/BlueLoadoutGroup0-4) are globalconfig: once the ini
// has them the class defaults are the ini's, and ResetConfig empties them.
// Copied from those classes' defaultproperties: keep the two in step.
//=============================================================================
class LoadoutStockLists extends Object
	abstract;

var array<string>	FreeForAll0, FreeForAll1, FreeForAll2, FreeForAll3, FreeForAll4;
var array<string>	Red0, Red1, Red2, Red3, Red4;
var array<string>	Blue0, Blue1, Blue2, Blue3, Blue4;

// Team: 0 free-for-all, 1 red, 2 blue. Slot: 0 Melee .. 4 Grenade
static function array<string> GetList(int Team, int Slot)
{
	local array<string> None_;

	switch (Team * 5 + Slot)
	{
		case 0:		return default.FreeForAll0;
		case 1:		return default.FreeForAll1;
		case 2:		return default.FreeForAll2;
		case 3:		return default.FreeForAll3;
		case 4:		return default.FreeForAll4;
		case 5:		return default.Red0;
		case 6:		return default.Red1;
		case 7:		return default.Red2;
		case 8:		return default.Red3;
		case 9:		return default.Red4;
		case 10:	return default.Blue0;
		case 11:	return default.Blue1;
		case 12:	return default.Blue2;
		case 13:	return default.Blue3;
		case 14:	return default.Blue4;
	}
	return None_;
}

defaultproperties
{
	FreeForAll0(0)=BallisticProV55.X3Knife
	FreeForAll0(1)=BallisticProV55.X4Knife
	FreeForAll0(2)=BallisticProV55.A909SkrithBlades
	FreeForAll0(3)=BallisticProV55.EKS43Katana
	FreeForAll1(0)=BallisticProV55.A42SkrithPistol
	FreeForAll1(1)=BallisticProV55.AM67Pistol
	FreeForAll1(2)=BallisticProV55.BOGPPistol
	FreeForAll1(3)=BallisticProV55.D49Revolver
	FreeForAll1(4)=BallisticProV55.M806Pistol
	FreeForAll1(5)=BallisticProV55.MD24Pistol
	FreeForAll1(6)=BallisticProV55.MRT6Shotgun
	FreeForAll1(7)=BallisticProV55.RS8Pistol
	FreeForAll1(8)=BallisticProV55.leMatRevolver
	FreeForAll2(0)=BallisticProV55.A500Reptile
	FreeForAll2(1)=BallisticProV55.A73SkrithRifle
	FreeForAll2(2)=BallisticProV55.E23PlasmaRifle
	FreeForAll2(3)=BallisticProV55.Fifty9MachinePistol
	FreeForAll2(4)=BallisticProV55.G5Bazooka
	FreeForAll2(5)=BallisticProV55.GRS9Pistol
	FreeForAll2(6)=BallisticProV55.HVCMk9LightningGun
	FreeForAll2(7)=BallisticProV55.M290Shotgun
	FreeForAll2(8)=BallisticProV55.M353Machinegun
	FreeForAll2(9)=BallisticProV55.M46AssaultRifle
	FreeForAll2(10)=BallisticProV55.M50AssaultRifle
	FreeForAll2(11)=BallisticProV55.M75Railgun
	FreeForAll2(12)=BallisticProV55.M763Shotgun
	FreeForAll2(13)=BallisticProV55.M925Machinegun
	FreeForAll2(14)=BallisticProV55.MACWeapon
	FreeForAll2(15)=BallisticProV55.MRS138Shotgun
	FreeForAll2(16)=BallisticProV55.MRocketLauncher
	FreeForAll2(17)=BallisticProV55.MarlinRifle
	FreeForAll2(18)=BallisticProV55.R78Rifle
	FreeForAll2(19)=BallisticProV55.RSDarkStar
	FreeForAll2(20)=BallisticProV55.RSNovaStaff
	FreeForAll2(21)=BallisticProV55.RX22AFlamer
	FreeForAll2(22)=BallisticProV55.SARAssaultRifle
	FreeForAll2(23)=BallisticProV55.SRS900Rifle
	FreeForAll2(24)=BallisticProV55.XK2SubMachinegun
	FreeForAll2(25)=BallisticProV55.XMK5SubMachinegun
	FreeForAll2(26)=BallisticProV55.XMV850Minigun
	FreeForAll2(27)=BallisticProV55.XRS10SubMachinegun
	FreeForAll3(0)=BallisticProV55.A500Reptile
	FreeForAll3(1)=BallisticProV55.A73SkrithRifle
	FreeForAll3(2)=BallisticProV55.E23PlasmaRifle
	FreeForAll3(3)=BallisticProV55.Fifty9MachinePistol
	FreeForAll3(4)=BallisticProV55.G5Bazooka
	FreeForAll3(5)=BallisticProV55.GRS9Pistol
	FreeForAll3(6)=BallisticProV55.HVCMk9LightningGun
	FreeForAll3(7)=BallisticProV55.M290Shotgun
	FreeForAll3(8)=BallisticProV55.M353Machinegun
	FreeForAll3(9)=BallisticProV55.M46AssaultRifle
	FreeForAll3(10)=BallisticProV55.M50AssaultRifle
	FreeForAll3(11)=BallisticProV55.M75Railgun
	FreeForAll3(12)=BallisticProV55.M763Shotgun
	FreeForAll3(13)=BallisticProV55.M925Machinegun
	FreeForAll3(14)=BallisticProV55.MACWeapon
	FreeForAll3(15)=BallisticProV55.MRS138Shotgun
	FreeForAll3(16)=BallisticProV55.MRocketLauncher
	FreeForAll3(17)=BallisticProV55.MarlinRifle
	FreeForAll3(18)=BallisticProV55.R78Rifle
	FreeForAll3(19)=BallisticProV55.RSDarkStar
	FreeForAll3(20)=BallisticProV55.RSNovaStaff
	FreeForAll3(21)=BallisticProV55.RX22AFlamer
	FreeForAll3(22)=BallisticProV55.SARAssaultRifle
	FreeForAll3(23)=BallisticProV55.SRS900Rifle
	FreeForAll3(24)=BallisticProV55.XK2SubMachinegun
	FreeForAll3(25)=BallisticProV55.XMK5SubMachinegun
	FreeForAll3(26)=BallisticProV55.XMV850Minigun
	FreeForAll3(27)=BallisticProV55.XRS10SubMachinegun
	FreeForAll4(0)=BallisticProV55.FP7Grenade
	FreeForAll4(2)=BallisticProV55.FP9Explosive
	FreeForAll4(3)=BallisticProV55.M58Grenade
	FreeForAll4(4)=BallisticProV55.NRP57Grenade
	FreeForAll4(5)=BallisticProV55.SandbagLayer
	FreeForAll4(6)=BallisticProV55.T10Grenade
	Red0(0)=BallisticProV55.X3Knife
	Red0(1)=BallisticProV55.X4Knife
	Red0(2)=BallisticProV55.A909SkrithBlades
	Red0(3)=BallisticProV55.EKS43Katana
	Red1(0)=BallisticProV55.A42SkrithPistol
	Red1(1)=BallisticProV55.AM67Pistol
	Red1(2)=BallisticProV55.BOGPPistol
	Red1(3)=BallisticProV55.D49Revolver
	Red1(4)=BallisticProV55.M806Pistol
	Red1(5)=BallisticProV55.MD24Pistol
	Red1(6)=BallisticProV55.MRT6Shotgun
	Red1(7)=BallisticProV55.RS8Pistol
	Red1(8)=BallisticProV55.leMatRevolver
	Red2(0)=BallisticProV55.A500Reptile
	Red2(1)=BallisticProV55.A73SkrithRifle
	Red2(2)=BallisticProV55.E23PlasmaRifle
	Red2(3)=BallisticProV55.Fifty9MachinePistol
	Red2(4)=BallisticProV55.G5Bazooka
	Red2(5)=BallisticProV55.GRS9Pistol
	Red2(6)=BallisticProV55.HVCMk9LightningGun
	Red2(7)=BallisticProV55.M290Shotgun
	Red2(8)=BallisticProV55.M353Machinegun
	Red2(9)=BallisticProV55.M46AssaultRifle
	Red2(10)=BallisticProV55.M50AssaultRifle
	Red2(11)=BallisticProV55.M75Railgun
	Red2(12)=BallisticProV55.M763Shotgun
	Red2(13)=BallisticProV55.M925Machinegun
	Red2(14)=BallisticProV55.MACWeapon
	Red2(15)=BallisticProV55.MRS138Shotgun
	Red2(16)=BallisticProV55.MRocketLauncher
	Red2(17)=BallisticProV55.MarlinRifle
	Red2(18)=BallisticProV55.R78Rifle
	Red2(19)=BallisticProV55.RSDarkStar
	Red2(20)=BallisticProV55.RSNovaStaff
	Red2(21)=BallisticProV55.RX22AFlamer
	Red2(22)=BallisticProV55.SARAssaultRifle
	Red2(23)=BallisticProV55.SRS900Rifle
	Red2(24)=BallisticProV55.XK2SubMachinegun
	Red2(25)=BallisticProV55.XMK5SubMachinegun
	Red2(26)=BallisticProV55.XMV850Minigun
	Red2(27)=BallisticProV55.XRS10SubMachinegun
	Red3(0)=BallisticProV55.A500Reptile
	Red3(1)=BallisticProV55.A73SkrithRifle
	Red3(2)=BallisticProV55.E23PlasmaRifle
	Red3(3)=BallisticProV55.Fifty9MachinePistol
	Red3(4)=BallisticProV55.G5Bazooka
	Red3(5)=BallisticProV55.GRS9Pistol
	Red3(6)=BallisticProV55.HVCMk9LightningGun
	Red3(7)=BallisticProV55.M290Shotgun
	Red3(8)=BallisticProV55.M353Machinegun
	Red3(9)=BallisticProV55.M46AssaultRifle
	Red3(10)=BallisticProV55.M50AssaultRifle
	Red3(11)=BallisticProV55.M75Railgun
	Red3(12)=BallisticProV55.M763Shotgun
	Red3(13)=BallisticProV55.M925Machinegun
	Red3(14)=BallisticProV55.MACWeapon
	Red3(15)=BallisticProV55.MRS138Shotgun
	Red3(16)=BallisticProV55.MRocketLauncher
	Red3(17)=BallisticProV55.MarlinRifle
	Red3(18)=BallisticProV55.R78Rifle
	Red3(19)=BallisticProV55.RSDarkStar
	Red3(20)=BallisticProV55.RSNovaStaff
	Red3(21)=BallisticProV55.RX22AFlamer
	Red3(22)=BallisticProV55.SARAssaultRifle
	Red3(23)=BallisticProV55.SRS900Rifle
	Red3(24)=BallisticProV55.XK2SubMachinegun
	Red3(25)=BallisticProV55.XMK5SubMachinegun
	Red3(26)=BallisticProV55.XMV850Minigun
	Red3(27)=BallisticProV55.XRS10SubMachinegun
	Red4(0)=BallisticProV55.FP7Grenade
	Red4(2)=BallisticProV55.FP9Explosive
	Red4(3)=BallisticProV55.M58Grenade
	Red4(4)=BallisticProV55.NRP57Grenade
	Red4(5)=BallisticProV55.SandbagLayer
	Red4(6)=BallisticProV55.T10Grenade
	Blue0(0)=BallisticProV55.X3Knife
	Blue0(1)=BallisticProV55.X4Knife
	Blue0(2)=BallisticProV55.A909SkrithBlades
	Blue0(3)=BallisticProV55.EKS43Katana
	Blue1(0)=BallisticProV55.A42SkrithPistol
	Blue1(1)=BallisticProV55.AM67Pistol
	Blue1(2)=BallisticProV55.BOGPPistol
	Blue1(3)=BallisticProV55.D49Revolver
	Blue1(4)=BallisticProV55.M806Pistol
	Blue1(5)=BallisticProV55.MD24Pistol
	Blue1(6)=BallisticProV55.MRT6Shotgun
	Blue1(7)=BallisticProV55.RS8Pistol
	Blue1(8)=BallisticProV55.leMatRevolver
	Blue2(0)=BallisticProV55.A500Reptile
	Blue2(1)=BallisticProV55.A73SkrithRifle
	Blue2(2)=BallisticProV55.E23PlasmaRifle
	Blue2(3)=BallisticProV55.Fifty9MachinePistol
	Blue2(4)=BallisticProV55.G5Bazooka
	Blue2(5)=BallisticProV55.GRS9Pistol
	Blue2(6)=BallisticProV55.HVCMk9LightningGun
	Blue2(7)=BallisticProV55.M290Shotgun
	Blue2(8)=BallisticProV55.M353Machinegun
	Blue2(9)=BallisticProV55.M46AssaultRifle
	Blue2(10)=BallisticProV55.M50AssaultRifle
	Blue2(11)=BallisticProV55.M75Railgun
	Blue2(12)=BallisticProV55.M763Shotgun
	Blue2(13)=BallisticProV55.M925Machinegun
	Blue2(14)=BallisticProV55.MACWeapon
	Blue2(15)=BallisticProV55.MRS138Shotgun
	Blue2(16)=BallisticProV55.MRocketLauncher
	Blue2(17)=BallisticProV55.MarlinRifle
	Blue2(18)=BallisticProV55.R78Rifle
	Blue2(19)=BallisticProV55.RSDarkStar
	Blue2(20)=BallisticProV55.RSNovaStaff
	Blue2(21)=BallisticProV55.RX22AFlamer
	Blue2(22)=BallisticProV55.SARAssaultRifle
	Blue2(23)=BallisticProV55.SRS900Rifle
	Blue2(24)=BallisticProV55.XK2SubMachinegun
	Blue2(25)=BallisticProV55.XMK5SubMachinegun
	Blue2(26)=BallisticProV55.XMV850Minigun
	Blue2(27)=BallisticProV55.XRS10SubMachinegun
	Blue3(0)=BallisticProV55.A500Reptile
	Blue3(1)=BallisticProV55.A73SkrithRifle
	Blue3(2)=BallisticProV55.E23PlasmaRifle
	Blue3(3)=BallisticProV55.Fifty9MachinePistol
	Blue3(4)=BallisticProV55.G5Bazooka
	Blue3(5)=BallisticProV55.GRS9Pistol
	Blue3(6)=BallisticProV55.HVCMk9LightningGun
	Blue3(7)=BallisticProV55.M290Shotgun
	Blue3(8)=BallisticProV55.M353Machinegun
	Blue3(9)=BallisticProV55.M46AssaultRifle
	Blue3(10)=BallisticProV55.M50AssaultRifle
	Blue3(11)=BallisticProV55.M75Railgun
	Blue3(12)=BallisticProV55.M763Shotgun
	Blue3(13)=BallisticProV55.M925Machinegun
	Blue3(14)=BallisticProV55.MACWeapon
	Blue3(15)=BallisticProV55.MRS138Shotgun
	Blue3(16)=BallisticProV55.MRocketLauncher
	Blue3(17)=BallisticProV55.MarlinRifle
	Blue3(18)=BallisticProV55.R78Rifle
	Blue3(19)=BallisticProV55.RSDarkStar
	Blue3(20)=BallisticProV55.RSNovaStaff
	Blue3(21)=BallisticProV55.RX22AFlamer
	Blue3(22)=BallisticProV55.SARAssaultRifle
	Blue3(23)=BallisticProV55.SRS900Rifle
	Blue3(24)=BallisticProV55.XK2SubMachinegun
	Blue3(25)=BallisticProV55.XMK5SubMachinegun
	Blue3(26)=BallisticProV55.XMV850Minigun
	Blue3(27)=BallisticProV55.XRS10SubMachinegun
	Blue4(0)=BallisticProV55.FP7Grenade
	Blue4(2)=BallisticProV55.FP9Explosive
	Blue4(3)=BallisticProV55.M58Grenade
	Blue4(4)=BallisticProV55.NRP57Grenade
	Blue4(5)=BallisticProV55.SandbagLayer
	Blue4(6)=BallisticProV55.T10Grenade
}
