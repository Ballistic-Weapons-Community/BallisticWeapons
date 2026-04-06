Class Mut_BallisticPreLoad extends Mutator 
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var config array<string> WeaponClassNames;

var() int WeaponsToLoad;
var() string WeaponName;

var globalconfig bool bEnablePreloading;

replication
{
    reliable if(Role == ROLE_Authority)
		WeaponsToLoad, WeaponName;
}

event PostBeginPlay()
{
	local BallisticPreloadReplicationInfo MyRI;
	local int i;
	local class<Weapon> WeaponClass;
	local int SuccessCount;

	if (bEnablePreloading)
	{
		MyRI = Spawn(class'BallisticProV55.BallisticPreloadReplicationInfo');

		WeaponsToLoad = WeaponClassNames.Length;
		MyRI.PreloadNum = WeaponsToLoad;

		for (i = 0; i < WeaponsToLoad; i++)
		{
			WeaponClass = class<Weapon>(DynamicLoadObject(WeaponClassNames[i],class'Class',True));
			
			if (WeaponClass != None)
			{
				MyRI.CurrentName[i] = WeaponClassNames[i];
				MyRI.MeshList[i] = string(WeaponClass.default.Mesh);
				SuccessCount++;
			}
			else
				Log("Mut_BallisticPreLoad: Failed to load"@WeaponClassNames[i], 'Warning');
		}

		Log("Mut_BallisticPreLoad: Preloaded"@SuccessCount$"/"$WeaponsToLoad@"weapons");
	}
	
	SaveConfig();

	Super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
	Disable('Tick');
}

function ModifyPlayer(Pawn Other)
{
	local Inventory Inv;

	if (bEnablePreloading && Other != None && Other.Controller != None && Other.Controller.PlayerReplicationInfo != None && Other.Controller.PlayerReplicationInfo.Deaths == 0 && Other.Controller.PlayerReplicationInfo.bBot == false && Other.Controller.PlayerReplicationInfo.Score == 0)
	{
		Inv = Spawn(class'BallisticPreloadInv',Other,,);
		if(Inv != None)
		{
			Inv.GiveTo(Other);
		}
	}

	super.ModifyPlayer(Other);
}

defaultproperties
{
	bEnablePreloading=True
    bAddToServerPackages=True
    GroupName="BallisticPro: Resource Preload"
    FriendlyName="BallisticPro: Resource Preload"
    Description="Preloads weapon resources, designed for use with BallisticPro. This will improve overall performance on all machines"
    bAlwaysRelevant=True
    RemoteRole=ROLE_SimulatedProxy
	// BallisticProV55
	WeaponClassNames(0)="BallisticProV55.A42SkrithPistol"
	WeaponClassNames(1)="BallisticProV55.A500Reptile"
	WeaponClassNames(2)="BallisticProV55.A73SkrithRifle"
	WeaponClassNames(3)="BallisticProV55.A909SkrithBlades"
	WeaponClassNames(4)="BallisticProV55.AM67Pistol"
	WeaponClassNames(5)="BallisticProV55.BOGPPistol"
	WeaponClassNames(6)="BallisticProV55.BX5Mine"
	WeaponClassNames(7)="BallisticProV55.D49Revolver"
	WeaponClassNames(8)="BallisticProV55.E23PlasmaRifle"
	WeaponClassNames(9)="BallisticProV55.EKS43Katana"
	WeaponClassNames(10)="BallisticProV55.FP7Grenade"
	WeaponClassNames(11)="BallisticProV55.FP9Explosive"
	WeaponClassNames(12)="BallisticProV55.Fifty9MachinePistol"
	WeaponClassNames(13)="BallisticProV55.G5Bazooka"
	WeaponClassNames(14)="BallisticProV55.GRS9Pistol"
	WeaponClassNames(15)="BallisticProV55.HVCMk9LightningGun"
	WeaponClassNames(16)="BallisticProV55.M290Shotgun"
	WeaponClassNames(17)="BallisticProV55.M353Machinegun"
	WeaponClassNames(18)="BallisticProV55.M46AssaultRifle"
	WeaponClassNames(19)="BallisticProV55.M50AssaultRifle"
	WeaponClassNames(20)="BallisticProV55.M58Grenade"
	WeaponClassNames(21)="BallisticProV55.M75Railgun"
	WeaponClassNames(22)="BallisticProV55.M763Shotgun"
	WeaponClassNames(23)="BallisticProV55.M806Pistol"
	WeaponClassNames(24)="BallisticProV55.M925Machinegun"
	WeaponClassNames(25)="BallisticProV55.MACWeapon"
	WeaponClassNames(26)="BallisticProV55.MD24Pistol"
	WeaponClassNames(27)="BallisticProV55.MRS138Shotgun"
	WeaponClassNames(28)="BallisticProV55.MRT6Shotgun"
	WeaponClassNames(29)="BallisticProV55.MRocketLauncher"
	WeaponClassNames(30)="BallisticProV55.MarlinRifle"
	WeaponClassNames(31)="BallisticProV55.NRP57Grenade"
	WeaponClassNames(32)="BallisticProV55.R78Rifle"
	WeaponClassNames(33)="BallisticProV55.RS8Pistol"
	WeaponClassNames(34)="BallisticProV55.RSDarkStar"
	WeaponClassNames(35)="BallisticProV55.RSNovaStaff"
	WeaponClassNames(36)="BallisticProV55.RX22AFlamer"
	WeaponClassNames(37)="BallisticProV55.SARAssaultRifle"
	WeaponClassNames(38)="BallisticProV55.SRS900Rifle"
	WeaponClassNames(39)="BallisticProV55.SandbagLayer"
	WeaponClassNames(40)="BallisticProV55.T10Grenade"
	WeaponClassNames(41)="BallisticProV55.X3Knife"
	WeaponClassNames(42)="BallisticProV55.X4Knife"
	WeaponClassNames(43)="BallisticProV55.XK2SubMachinegun"
	WeaponClassNames(44)="BallisticProV55.XMK5SubMachinegun"
	WeaponClassNames(45)="BallisticProV55.XMV850Minigun"
	WeaponClassNames(46)="BallisticProV55.XRS10SubMachinegun"
	WeaponClassNames(47)="BallisticProV55.leMatRevolver"
	// BWBP_APC_Pro
	WeaponClassNames(48)="BWBP_APC_Pro.CryoLanceLauncher"
	WeaponClassNames(49)="BWBP_APC_Pro.E5PlasmaRifle"
	WeaponClassNames(50)="BWBP_APC_Pro.FM14Shotgun"
	WeaponClassNames(51)="BWBP_APC_Pro.GASCPistol"
	WeaponClassNames(52)="BWBP_APC_Pro.HB4GrenadeBlaster"
	WeaponClassNames(53)="BWBP_APC_Pro.HKMKSpecPistol"
	WeaponClassNames(54)="BWBP_APC_Pro.HydraBazooka"
	WeaponClassNames(55)="BWBP_APC_Pro.MJ51Carbine"
	WeaponClassNames(56)="BWBP_APC_Pro.ParticleStreamer"
	WeaponClassNames(57)="BWBP_APC_Pro.R9000ERifle"
	WeaponClassNames(58)="BWBP_APC_Pro.ScarabGrenade"
	WeaponClassNames(59)="BWBP_APC_Pro.SRKSubMachinegun"
	WeaponClassNames(60)="BWBP_APC_Pro.ThorLightningCannon"
	WeaponClassNames(61)="BWBP_APC_Pro.WendigoSMG"
	WeaponClassNames(62)="BWBP_APC_Pro.Wrenchgun"
	WeaponClassNames(63)="BWBP_APC_Pro.XMV500Minigun"
	WeaponClassNames(64)="BWBP_APC_Pro.ZX98AssaultRifle"
	// BWBP_JCF_Pro
	WeaponClassNames(65)="BWBP_JCF_Pro.HKMKSpecPistol"
	WeaponClassNames(66)="BWBP_JCF_Pro.M7A3AssaultRifle"
	WeaponClassNames(67)="BWBP_JCF_Pro.M99Rifle"
	WeaponClassNames(68)="BWBP_JCF_Pro.RGPXBazooka"
	WeaponClassNames(69)="BWBP_JCF_Pro.SPASShotgun"
	// BWBP_OP_Pro
	WeaponClassNames(70)="BWBP_OP_Pro.AkeronLauncher"
	WeaponClassNames(71)="BWBP_OP_Pro.BallisticShieldWeapon"
	WeaponClassNames(72)="BWBP_OP_Pro.CX61AssaultRifle"
	WeaponClassNames(73)="BWBP_OP_Pro.CX85AssaultWeapon"
	WeaponClassNames(74)="BWBP_OP_Pro.DefibFists"
	WeaponClassNames(75)="BWBP_OP_Pro.FC01SmartGun"
	WeaponClassNames(76)="BWBP_OP_Pro.FlameSword"
	WeaponClassNames(77)="BWBP_OP_Pro.FM13Shotgun"
	WeaponClassNames(78)="BWBP_OP_Pro.JWJunkShieldWeapon"
	WeaponClassNames(79)="BWBP_OP_Pro.JWRiotShieldWeapon"
	WeaponClassNames(80)="BWBP_OP_Pro.KF8XCrossbow"
	WeaponClassNames(81)="BWBP_OP_Pro.L8GIAmmoPack"
	WeaponClassNames(82)="BWBP_OP_Pro.LightningRifle"
	WeaponClassNames(83)="BWBP_OP_Pro.MAG78LongSword"
	WeaponClassNames(84)="BWBP_OP_Pro.MX32Weapon"
	WeaponClassNames(85)="BWBP_OP_Pro.PD97Bloodhound"
	WeaponClassNames(86)="BWBP_OP_Pro.ProtonStreamer"
	WeaponClassNames(87)="BWBP_OP_Pro.R9A1RangerRifle"
	WeaponClassNames(88)="BWBP_OP_Pro.Raygun"
	WeaponClassNames(89)="BWBP_OP_Pro.RCS715Shotgun"
	WeaponClassNames(90)="BWBP_OP_Pro.WrenchWarpDevice"
	WeaponClassNames(91)="BWBP_OP_Pro.XOXOStaff"
	WeaponClassNames(92)="BWBP_OP_Pro.Z250Minigun"
	// BWBP_SKC_Pro
	WeaponClassNames(93)="BWBP_SKC_Pro.A49SkrithBlaster"
	WeaponClassNames(94)="BWBP_SKC_Pro.AH104Pistol"
	WeaponClassNames(95)="BWBP_SKC_Pro.AH250Pistol"
	WeaponClassNames(96)="BWBP_SKC_Pro.AK490BattleRifle"
	WeaponClassNames(97)="BWBP_SKC_Pro.AK91ChargeRifle"
	WeaponClassNames(98)="BWBP_SKC_Pro.AR23HeavyRifle"
	WeaponClassNames(99)="BWBP_SKC_Pro.AS50Rifle"
	WeaponClassNames(100)="BWBP_SKC_Pro.AY90SkrithBoltcaster"
	WeaponClassNames(101)="BWBP_SKC_Pro.BlackOpsWristBlade"
	WeaponClassNames(102)="BWBP_SKC_Pro.BulldogAssaultCannon"
	WeaponClassNames(103)="BWBP_SKC_Pro.ChaffGrenadeWeapon"
	WeaponClassNames(104)="BWBP_SKC_Pro.CoachGun"
	WeaponClassNames(105)="BWBP_SKC_Pro.CYLOUAW"
	WeaponClassNames(106)="BWBP_SKC_Pro.DragonsToothSword"
	WeaponClassNames(107)="BWBP_SKC_Pro.FG50MachineGun"
	WeaponClassNames(108)="BWBP_SKC_Pro.FLASHLauncher"
	WeaponClassNames(109)="BWBP_SKC_Pro.FMPMachinePistol"
	WeaponClassNames(110)="BWBP_SKC_Pro.G28Grenade"
	WeaponClassNames(111)="BWBP_SKC_Pro.G51Carbine"
	WeaponClassNames(112)="BWBP_SKC_Pro.GRSXXPistol"
	WeaponClassNames(113)="BWBP_SKC_Pro.HMCBeamCannon"
	WeaponClassNames(114)="BWBP_SKC_Pro.HVPCMk5PlasmaCannon"
	WeaponClassNames(115)="BWBP_SKC_Pro.HVPCMk66PlasmaCannon"
	WeaponClassNames(116)="BWBP_SKC_Pro.ICISStimpack"
	WeaponClassNames(117)="BWBP_SKC_Pro.LAWLauncher"
	WeaponClassNames(118)="BWBP_SKC_Pro.LK05Carbine"
	WeaponClassNames(119)="BWBP_SKC_Pro.LonghornLauncher"
	WeaponClassNames(120)="BWBP_SKC_Pro.LS14Carbine"
	WeaponClassNames(121)="BWBP_SKC_Pro.M2020GaussDMR"
	WeaponClassNames(122)="BWBP_SKC_Pro.MARSAssaultRifle"
	WeaponClassNames(123)="BWBP_SKC_Pro.MG36Machinegun"
	WeaponClassNames(124)="BWBP_SKC_Pro.MGLauncher"
	WeaponClassNames(125)="BWBP_SKC_Pro.Mk781Shotgun"
	WeaponClassNames(126)="BWBP_SKC_Pro.MRDRMachinePistol"
	WeaponClassNames(127)="BWBP_SKC_Pro.N3XPlaz"
	WeaponClassNames(128)="BWBP_SKC_Pro.PS9mPistol"
	WeaponClassNames(129)="BWBP_SKC_Pro.PugAssaultCannon"
	WeaponClassNames(130)="BWBP_SKC_Pro.PUMARepeater"
	WeaponClassNames(131)="BWBP_SKC_Pro.RS04Pistol"
	WeaponClassNames(132)="BWBP_SKC_Pro.SK410Shotgun"
	WeaponClassNames(133)="BWBP_SKC_Pro.SKASShotgun"
	WeaponClassNames(134)="BWBP_SKC_Pro.SMATLauncher"
	WeaponClassNames(135)="BWBP_SKC_Pro.SRXRifle"
	WeaponClassNames(136)="BWBP_SKC_Pro.Supercharger_AssaultWeapon"
	WeaponClassNames(137)="BWBP_SKC_Pro.SX45Pistol"
	WeaponClassNames(138)="BWBP_SKC_Pro.T9CNMachinePistol"
	WeaponClassNames(139)="BWBP_SKC_Pro.TAC30Cannon"
	WeaponClassNames(140)="BWBP_SKC_Pro.ThumperGrenadeLauncher"
	WeaponClassNames(141)="BWBP_SKC_Pro.TyphonPDW"
	WeaponClassNames(142)="BWBP_SKC_Pro.VSKTranqRifle"
	WeaponClassNames(143)="BWBP_SKC_Pro.X82Rifle"
	WeaponClassNames(144)="BWBP_SKC_Pro.X8Knife"
	WeaponClassNames(145)="BWBP_SKC_Pro.XM20Carbine"
	WeaponClassNames(146)="BWBP_SKC_Pro.XM84Flashbang"
	// BWBP_SWC_Pro
	WeaponClassNames(147)="BWBP_SWC_Pro.A2WSkrithLance"
	WeaponClassNames(148)="BWBP_SWC_Pro.A51Grenade"
	WeaponClassNames(149)="BWBP_SWC_Pro.A800SkrithMinigun"
	WeaponClassNames(150)="BWBP_SWC_Pro.APodCapsule"
	WeaponClassNames(151)="BWBP_SWC_Pro.BRINKAssaultRifle"
	WeaponClassNames(152)="BWBP_SWC_Pro.MDKSubMachinegun"
	WeaponClassNames(153)="BWBP_SWC_Pro.NTOVBandage"
	WeaponClassNames(154)="BWBP_SWC_Pro.SkrithStaff"
} 
