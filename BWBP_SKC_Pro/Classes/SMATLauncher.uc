//=============================================================================
// SMATAA Recoilless.
//
// Portable artillery system. Fires a high speed shaped charge that decimates
// armor. Instant hit is almost always a kill.
// Comes with the all-new suicide alt fire!
//
// by Sgt Kelly
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATLauncher extends BallisticWeapon;

var() BUtil.FullSound	LeverDownSound;
var() BUtil.FullSound	LeverUpSound;
var() BUtil.FullSound	EjectSound;

var   bool          bRunOffsetting;
var   bool          bRunOverride;
var	bool		  bInUse;
var() rotator       RunOffset;
var() bool			bExploded; //you blew it all to hell! don't spawn a pickup

var()     float Heat;
var()     float CoolRate;



simulated function Notify_LeverDown ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, LeverDownSound);
}

simulated function Notify_LeverUp ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, LeverUpSound);
}

simulated function Notify_EjectRocket ()
{
	local vector start;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, EjectSound);
	SMATPrimaryFire(FireMode[0]).FlashHatchSmoke();
	Start = Instigator.Location + Instigator.EyePosition() + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), vect(5,10,-5));
	Spawn(class'Brass_SMAT', self,, Start, Instigator.GetViewRotation() + rot(8192,0,0));
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && AIController(Instigator.Controller) != None)
	{
		bRunOverride=true;
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	Super.PutDown();

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;
	return true;
}

simulated event Tick (float DT)
{
	Heat = FMax(0, Heat - CoolRate*DT);
	super.Tick(DT);
}

simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);

	if (FireMode[0].bIsFiring == true)
	{
		bInUse = true;
		SMATSecondaryFire(Firemode[1]).RailPower=0;
		Heat=0;
	}
	else
		bInUse = false;

}

function DropFrom(vector StartLocation)
{

	if (bExploded || PickupClass == None)
	{
		return;
	}
	else
		super.DropFrom(StartLocation);
}


// AI Interface =====
function byte BestMode()
{
	return 0;	
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist < 600)
		Result -= 0.6;
	else if (Dist > 4000)
		Result -= 0.3;
	else if (Dist > 20000)
		Result += (Dist-1000) / 2000;
	result += 0.2 - FRand()*0.4;
	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
    return FMin((Heat + SMATSecondaryFire(Firemode[1]).RailPower), 1);
}

defaultproperties
{
	LeverDownSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-LeverOpen',Volume=0.700000,Pitch=1.000000)
	LeverUpSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-LeverClose',Volume=0.700000,Pitch=1.000000)
	EjectSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-Eject',Volume=1.700000,Pitch=1.000000)
	RunOffset=(Pitch=-1500,Yaw=-4500)
	CoolRate=0.700000
	PlayerSpeedFactor=0.700000
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.SMAT.BigIcon_SMAT'
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	SpecialInfo(0)=(Info="500.0;60.0;1.0;80.0;2.0;0.0;1.5")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Deploy',Volume=0.210000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Undeploy',Volume=0.210000)
	MagAmmo=1
	CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
	ReloadAnim="ReloadFancy"
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Cycle',Volume=1.100000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-RocketIn',Volume=1.600000)
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-RocketOut',Volume=1.100000)
	bNeedCock=False
	bCockOnEmpty=False
	bCockAfterReload=False
	WeaponModes(0)=(ModeName="Single Fire")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0

	ScopeViewTex=Texture'BWBP_SKC_Tex.SMAA.SMATAAScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	ZoomInAnim="ZoomIn"
	ZoomOutAnim="ZoomOut"
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,Color1=(A=192),Color2=(A=192),StartSize1=89,StartSize2=13)
	NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.250000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
	//CrosshairChaosFactor=0.750000


	ParamsClasses(0)=Class'SMATWeaponParamsArena'
	ParamsClasses(1)=Class'SMATWeaponParamsClassic' 
	ParamsClasses(2)=Class'SMATWeaponParamsRealistic'
	ParamsClasses(3)=Class'SMATWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.SMATPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.SMATSecondaryFire'
	SelectAnimRate=0.600000
	PutDownAnimRate=0.800000
	PutDownTime=0.800000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	SightingTime=0.750000
	bShowChargingBar=True
	Description="FGM-16 Shoulder Mounted Anti-Tank Infantry Cannon||Manufacturer: UTC Defense Tech|Primary: Launch Rocket|Secondary: Detonate Rocket||The SMAT Infantry Cannon is a reloadable, single shot rocket launcher. The portable version of the Flak 54 AT system, the FGM-16 SMAT is housed in a reinforced casing with advanced recoil buffering technlogy and fires high-speed HEAT-DP shaped charges for maximum penetration and damage. Engineered after UTC generals noticed the Cryons' knack for overrunning and taking over their Flak 54 sites, this new portable cannon has been the bane of Cryon armored divisions ever since."
	Priority=164
	CenteredOffsetY=10.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_SKC_Pro.SMATPickup'

	PlayerViewOffset=(X=-6.00,Y=5.00,Z=-1.00)
	SightOffset=(X=20.00,Y=0.00,Z=0.50)

	AttachmentClass=Class'BWBP_SKC_Pro.SMATAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.SMAT.SmallIcon_SMAT'
	IconCoords=(X2=127,Y2=31)
	ItemName="S.M.A.T. Infantry Cannon"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.SMAT_FPm'
	DrawScale=0.300000
}
