//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CF_PickupMeshCache extends Object config(CrazyFroggersMeshCache) exportstructs;

struct PickupMeshInfo
{
	var() config string		ClassName;
	var() config rotator	Rotation;
	var() config vector		Location;
	var() config float		DrawScale;
	var() config int		AnimNo;
	var array<byte> 		AlphaTex;
};

var() config array<PickupMeshInfo>	PickupMeshs;

// Find a specific weapon in the list, output the PMI and return succesd or failure to find the weapon
static function bool FindWeaponInfo(string CN, out PickupMeshInfo PMI, optional out int Index)
{
	local int i;

	for (i=0;i<default.PickupMeshs.length;i++)
		if (default.PickupMeshs[i].ClassName ~= CN)
		{
			Index = i;
			PMI = default.PickupMeshs[i];
			return true;
		}
	Index = -1;
	return false;
}

static function PickupMeshInfo AutoWeaponInfo(string WeapClassName, optional out int i)
{
	local PickupMeshInfo PMI;

	FindWeaponInfo(WeapClassName, PMI, i);

	return PMI;
}

defaultproperties
{
     PickupMeshs(0)=(ClassName="BallisticProV55.M806Pistol",Rotation=(Yaw=-20000,Roll=3000),Location=(X=-1.500000,Y=-5.000000,Z=1.000000),DrawScale=0.100000,AnimNo=4)
     PickupMeshs(2)=(ClassName="BallisticProV55.M46AssaultRifle",Rotation=(Pitch=16000,Yaw=33000,Roll=-8384),Location=(X=-5.000000,Y=-4.300000,Z=13.000000),DrawScale=1.000000,AnimNo=1)
     PickupMeshs(3)=(ClassName="BallisticProV55.D49Revolver",Rotation=(Yaw=-20000),Location=(X=-2.100000,Y=-6.000000,Z=1.300000),DrawScale=0.430000,AnimNo=5)
     PickupMeshs(4)=(ClassName="BallisticProV55.A42SkrithPistol",Rotation=(Yaw=-18000),Location=(X=-1.000000,Y=-6.800000,Z=4.900000),DrawScale=0.300000,AnimNo=5)
     PickupMeshs(5)=(ClassName="BallisticProV55.XRS10SubMachinegun",Rotation=(Yaw=-19000),Location=(X=-1.200000,Y=-7.300000),DrawScale=0.300000,AnimNo=5)
     PickupMeshs(6)=(ClassName="BallisticProV55.R9RangerRifle",Rotation=(Pitch=16000,Yaw=24000,Roll=-16384),Location=(Z=-1.000000),DrawScale=0.470000,AnimNo=1)
     PickupMeshs(7)=(ClassName="BallisticProV55.M290Shotgun",Rotation=(Pitch=18000,Yaw=24000),Location=(X=-1.000000,Z=1.000000),DrawScale=0.300000,AnimNo=2)
     PickupMeshs(9)=(ClassName="BallisticProV55.A73SkrithRifle",Rotation=(Pitch=14000,Yaw=-10000,Roll=10000),DrawScale=0.300000,AnimNo=2)
     PickupMeshs(10)=(ClassName="BallisticProV55.MRS138Shotgun",Rotation=(Pitch=16000,Yaw=24000,Roll=-16384),Location=(X=-3.000000,Y=-2.000000),DrawScale=0.300000,AnimNo=1)
     PickupMeshs(11)=(ClassName="BallisticProV55.M763Shotgun",Rotation=(Pitch=19000,Roll=-36384),DrawScale=0.300000,AnimNo=1)
     PickupMeshs(12)=(ClassName="BallisticProV55.MRT6Shotgun",Rotation=(Yaw=14000),Location=(X=-1.500000,Y=-7.000000),DrawScale=0.700000,AnimNo=4)
     PickupMeshs(13)=(ClassName="BallisticProV55.XK2SubMachinegun",Rotation=(Pitch=16000,Yaw=10000,Roll=-32384),Location=(X=-3.000000,Y=-5.000000,Z=3.000000),DrawScale=0.350000,AnimNo=1)
     PickupMeshs(14)=(ClassName="BallisticProV55.RS8Pistol",Rotation=(Yaw=-20000),Location=(X=-2.000000,Y=-5.000000,Z=2.000000),DrawScale=0.450000,AnimNo=4)
     PickupMeshs(15)=(ClassName="BallisticProV55.X4Knife",Rotation=(Pitch=3000,Yaw=10000,Roll=-2000),DrawScale=0.500000,AnimNo=8)
     PickupMeshs(16)=(ClassName="BallisticProV55.EKS43Katana",Rotation=(Pitch=16000,Yaw=-22000),Location=(X=0.500000,Y=1.000000,Z=23.000000),DrawScale=0.300000,AnimNo=8)
     PickupMeshs(18)=(ClassName="BallisticProV55.XMK5SubMachinegun",Rotation=(Pitch=-16000,Yaw=10000),Location=(X=-3.700000,Y=-4.000000,Z=-2.500000),DrawScale=1.000000,AnimNo=2)
     PickupMeshs(19)=(ClassName="BallisticProV55.RX22AFlamer",Rotation=(Pitch=16000,Yaw=-8000,Roll=16000),Location=(X=-7.000000,Y=6.000000,Z=5.000000),DrawScale=0.700000,AnimNo=2,AlphaTex=(2,3,4))
     PickupMeshs(20)=(ClassName="BallisticProV55.HVCMk9LightningGun",Rotation=(Pitch=16000,Roll=-16000),Location=(X=-3.400000,Y=-2.400000,Z=-4.000000),DrawScale=0.500000,AnimNo=8,AlphaTex=(2))
     PickupMeshs(21)=(ClassName="BallisticProV55.A909SkrithBlades",Rotation=(Pitch=-18000,Yaw=1000,Roll=-1000),Location=(X=-3.000000,Y=-1.000000,Z=10.000000),DrawScale=0.400000,AnimNo=7)
     PickupMeshs(22)=(ClassName="BallisticProV55.M353Machinegun",Rotation=(Pitch=-16000,Roll=6000),Location=(X=-6.500000,Y=-4.500000,Z=9.000000),DrawScale=1.400000,AnimNo=2)
     PickupMeshs(23)=(ClassName="BallisticProV55.M925Machinegun",Rotation=(Pitch=15000,Yaw=-16000),Location=(X=-0.500000,Y=-18.000000,Z=-4.000000),DrawScale=0.800000,AnimNo=8)
     PickupMeshs(24)=(ClassName="BallisticProV55.AM67Pistol",Rotation=(Yaw=-20000,Roll=3000),Location=(X=-3.000000,Y=-10.000000,Z=1.000000),DrawScale=0.500000,AnimNo=5)
     PickupMeshs(25)=(ClassName="BallisticProV55.X3Knife",Rotation=(Pitch=16000,Yaw=-18000),Location=(Z=7.000000),DrawScale=0.300000,AnimNo=9)
     PickupMeshs(26)=(ClassName="BallisticProV55.MD24Pistol",Rotation=(Yaw=14000,Roll=3000),Location=(X=0.500000,Z=1.000000),DrawScale=1.000000,AnimNo=4)
     PickupMeshs(27)=(ClassName="BallisticProV55.GRS9Pistol",Rotation=(Yaw=14000,Roll=2000),Location=(X=0.500000,Z=1.000000),DrawScale=0.300000,AnimNo=5)
     PickupMeshs(28)=(ClassName="BallisticProV55.NRP57Grenade",Rotation=(Pitch=35000,Yaw=15000,Roll=-16000),Location=(X=0.500000,Y=-5.000000,Z=1.000000),DrawScale=0.400000,AnimNo=6)
     PickupMeshs(29)=(ClassName="BallisticProV55.FP7Grenade",Rotation=(Pitch=38000,Yaw=10000,Roll=-7000),Location=(X=-2.000000,Y=-1.000000,Z=-0.500000),DrawScale=0.800000,AnimNo=6)
     PickupMeshs(30)=(ClassName="BallisticProV55.SRS900Rifle",Rotation=(Pitch=17000,Yaw=-8000,Roll=-16384),DrawScale=1.000000,AnimNo=1)
     PickupMeshs(31)=(ClassName="BallisticProV55.SARAssaultRifle",Rotation=(Pitch=15000,Yaw=-16000,Roll=4000),Location=(X=-1.500000,Y=-5.500000,Z=2.000000),DrawScale=0.300000,AnimNo=8)
     PickupMeshs(32)=(ClassName="BallisticProV55.M50AssaultRifle",Rotation=(Pitch=16000,Yaw=24000,Roll=-16384),DrawScale=0.600000,AnimNo=1)
     PickupMeshs(33)=(ClassName="BallisticProV55.R78Rifle",Rotation=(Pitch=-16000,Yaw=-24000,Roll=-2000),Location=(Z=-4.500000),DrawScale=1.000000,AnimNo=2)
     PickupMeshs(34)=(ClassName="BallisticProV55.Fifty9MachinePistol",Rotation=(Pitch=16000,Yaw=22000,Roll=-16384),Location=(X=-3.000000,Y=-2.000000,Z=1.500000),DrawScale=0.600000,AnimNo=1)
     PickupMeshs(36)=(ClassName="BallisticProV55.A500Reptile",Rotation=(Pitch=-13000,Yaw=16000,Roll=-6000),Location=(X=-4.000000,Y=-1.000000,Z=-15.000000),DrawScale=0.600000,AnimNo=6)
     PickupMeshs(38)=(ClassName="BallisticProV55.BOGPPistol",Rotation=(Yaw=14000),DrawScale=1.200000,AnimNo=5)
     PickupMeshs(39)=(ClassName="BallisticProV55.leMatRevolver",Rotation=(Yaw=-18000,Roll=2000),Location=(X=-1.000000,Y=-10.000000,Z=3.000000),DrawScale=0.500000,AnimNo=5)
     PickupMeshs(40)=(ClassName="BallisticProV55.E23PlasmaRifle",Rotation=(Pitch=-16000,Yaw=16000,Roll=-8000),Location=(X=-2.000000,Y=-3.000000),DrawScale=0.400000,AnimNo=2)
     PickupMeshs(42)=(ClassName="BallisticProV55.RSNovaStaff",Rotation=(Pitch=-16000,Yaw=16000,Roll=-5000),Location=(X=-0.500000,Z=-1.500000),DrawScale=2.000000,AnimNo=1)
     PickupMeshs(44)=(ClassName="BallisticProV55.RSDarkStar",Rotation=(Pitch=-16000,Yaw=16000,Roll=-5000),Location=(Z=16.000000),DrawScale=1.800000,AnimNo=1)
     PickupMeshs(45)=(ClassName="BallisticProV55.T10Grenade",Rotation=(Pitch=6000,Yaw=-6000,Roll=10000),Location=(X=-2.000000,Y=-1.000000,Z=3.000000),DrawScale=0.600000,AnimNo=7)
     PickupMeshs(46)=(ClassName="BallisticProV55.FP9Explosive",Rotation=(Pitch=7000,Yaw=15000,Roll=-10000),Location=(Y=-5.000000,Z=-2.000000),DrawScale=0.600000,AnimNo=4)
     PickupMeshs(48)=(ClassName="BallisticProV55.BX5Mine",Rotation=(Pitch=7000,Yaw=15000,Roll=-10000),Location=(X=-7.500000,Y=-8.000000,Z=1.000000),DrawScale=0.800000,AnimNo=6)
     PickupMeshs(49)=(ClassName="BallisticProV55.MarlinRifle",Rotation=(Pitch=18000,Yaw=24000,Roll=-10000),Location=(X=-2.000000),DrawScale=0.450000,AnimNo=2)
     PickupMeshs(51)=(ClassName="BallisticProV55.MACWeapon",Rotation=(Pitch=16500,Roll=-15000),Location=(X=-4.000000,Y=2.000000,Z=8.000000),DrawScale=0.500000,AnimNo=3)
     PickupMeshs(52)=(ClassName="BallisticProV55.G5Bazooka",Rotation=(Pitch=-16500,Roll=-16000),Location=(X=-3.500000,Y=-0.750000,Z=0.500000),DrawScale=0.700000,AnimNo=3)
     PickupMeshs(53)=(ClassName="BallisticProV55.MRocketLauncher",Rotation=(Pitch=16500,Roll=-16000),Location=(X=3.000000,Y=-3.000000,Z=-3.000000),DrawScale=0.700000,AnimNo=3)
     PickupMeshs(54)=(ClassName="BallisticProV55.M75Railgun",Rotation=(Pitch=-16500,Roll=-16000),Location=(X=-5.000000,Y=1.500000,Z=3.000000),DrawScale=0.500000,AnimNo=3)
     PickupMeshs(55)=(ClassName="BallisticProV55.XMV850Minigun",Rotation=(Pitch=16500,Yaw=-10000,Roll=5000),Location=(X=3.000000,Y=-8.000000,Z=-1.000000),DrawScale=0.800000,AnimNo=3,AlphaTex=(2))
}
