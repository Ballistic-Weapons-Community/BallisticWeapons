Class Mut_BallisticPreLoad extends Mutator 
	transient
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var config array< class<Weapon> > WeaponClassNames;

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

	if (bEnablePreloading)
	{
		MyRI = Spawn(class'BallisticProV55.BallisticPreloadReplicationInfo');

		WeaponsToLoad = WeaponClassNames.Length;
		MyRI.PreloadNum = WeaponsToLoad;

		for (i = 0; i < WeaponsToLoad; i++)
		{
			WeaponClass = class<Weapon>(DynamicLoadObject(string(WeaponClassNames[i]),class'Class',True));
			
			if (WeaponClass != None)
			{
				MyRI.CurrentName[i] = string(WeaponClass.Name);
				MyRI.MeshList[i] = string(WeaponClass.default.Mesh);
			}
		}
	}
	
	SaveConfig();

	Super.PostBeginPlay();
}

simulated function Tick(float DeltaTime)
{
	local PlayerController PC;

	if ( Level.NetMode == NM_DedicatedServer || !bEnablePreloading)
	{
		Disable('Tick');
	}

	PC = Level.GetLocalPlayerController();
	if (PC != none && bEnablePreloading)
	{
		PC.Player.InteractionMaster.AddInteraction("BallisticProV55.BallisticPreloadInteraction", PC.Player);
		Disable('Tick');
	}
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

	 WeaponClassNames(0)=class'BallisticProV55.X3Knife'
	 WeaponClassNames(1)=class'BallisticProV55.A909SkrithBlades'
	 WeaponClassNames(2)=class'BallisticProV55.EKS43Katana'
	 WeaponClassNames(3)=class'BallisticProV55.M806Pistol'
	 WeaponClassNames(4)=class'BallisticProV55.A42SkrithPistol'
	 WeaponClassNames(5)=class'BallisticProV55.MRT6Shotgun'
	 WeaponClassNames(6)=class'BallisticProV55.XK2SubMachinegun'
	 WeaponClassNames(7)=class'BallisticProV55.D49Revolver'
	 WeaponClassNames(8)=class'BallisticProV55.RS8Pistol'
	 WeaponClassNames(9)=class'BallisticProV55.XRS10SubMachinegun'
	 WeaponClassNames(10)=class'BallisticProV55.Fifty9MachinePistol'
	 WeaponClassNames(11)=class'BallisticProV55.AM67Pistol'
	 WeaponClassNames(12)=class'BallisticProV55.M50AssaultRifle'
	 WeaponClassNames(13)=class'BallisticProV55.M763Shotgun'
	 WeaponClassNames(14)=class'BallisticProV55.A73SkrithRifle'
	 WeaponClassNames(15)=class'BallisticProV55.M353Machinegun'
	 WeaponClassNames(16)=class'BallisticProV55.M925Machinegun'
	 WeaponClassNames(17)=class'BallisticProV55.G5Bazooka'
	 WeaponClassNames(18)=class'BallisticProV55.R78Rifle'
	 WeaponClassNames(19)=class'BallisticProV55.M75Railgun'
	 WeaponClassNames(20)=class'BallisticProV55.M290Shotgun'
	 WeaponClassNames(21)=class'BallisticProV55.MRS138Shotgun'
	 WeaponClassNames(22)=class'BallisticProV55.SRS900Rifle'
	 WeaponClassNames(23)=class'BallisticProV55.HVCMk9LightningGun'
	 WeaponClassNames(24)=class'BallisticProV55.RX22AFlamer'
	 WeaponClassNames(25)=class'BallisticProV55.XMV850Minigun'
	 WeaponClassNames(26)=class'BallisticProV55.NRP57Grenade'
	 WeaponClassNames(27)=class'BallisticProV55.FP7Grenade'
	 WeaponClassNames(28)=class'BallisticProV55.FP9Explosive'
	 WeaponClassNames(29)=class'BallisticProV55.BX5Mine'
	 WeaponClassNames(30)=class'BallisticProV55.T10Grenade'
	 WeaponClassNames(31)=class'BallisticProV55.A500Reptile'
	 WeaponClassNames(32)=class'BallisticProV55.BOGPPistol'
	 WeaponClassNames(33)=class'BallisticProV55.E23PlasmaRifle'
	 WeaponClassNames(34)=class'BallisticProV55.GRS9Pistol'
	 WeaponClassNames(35)=class'BallisticProV55.M46AssaultRifle'
	 WeaponClassNames(36)=class'BallisticProV55.M46AssaultRifleQS'
	 WeaponClassNames(37)=class'BallisticProV55.M58Grenade'
	 WeaponClassNames(38)=class'BallisticProV55.MACWeapon'
	 WeaponClassNames(39)=class'BallisticProV55.MD24Pistol'
	 WeaponClassNames(40)=class'BallisticProV55.MRocketLauncher'
	 WeaponClassNames(41)=class'BallisticProV55.MarlinRifle'
	 WeaponClassNames(42)=class'BallisticProV55.RSDarkStar'
	 WeaponClassNames(43)=class'BallisticProV55.RSNovaStaff'
	 WeaponClassNames(44)=class'BallisticProV55.SARAssaultRifle'
	 WeaponClassNames(45)=class'BallisticProV55.SRS600Rifle'
	 WeaponClassNames(46)=class'BallisticProV55.SandbagLayer'
	 WeaponClassNames(47)=class'BallisticProV55.X4Knife'
	 WeaponClassNames(48)=class'BallisticProV55.XMK5SubMachinegun'
	 WeaponClassNames(49)=class'BallisticProV55.leMatRevolver'
} 
