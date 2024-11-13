//=============================================================================
// HB4Pistol
//
// A powerful sidearm designed for close combat. The .50 bulelts are very
// deadly up, but weaken at range. Secondary is a blinging flash attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HB4GrenadeBlaster extends BallisticHandgun
	transient
	HideDropDown
	CacheExempt;

//simulated function bool SlaveCanUseMode(int Mode) {return (Mode == 0) || Othergun.class==class || ;}
simulated function bool MasterCanSendMode(int Mode) {return (Mode == 0) || Othergun.class==class || level.TimeSeconds <= FireMode[1].NextFireTime;}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return True;
	return super.CanAlternate(Mode);
}

simulated function bool CanSynch(byte Mode)
{
	return false;
	if (Mode != 0)
		return false;
	return super.CanSynch(Mode);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bNeedCock)
		BringUpTime = 0.4;
	super.BringUp(PrevWeapon);
	BringUpTime = default.BringUpTime;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function float ChargeBar()
{
	if (level.TimeSeconds >= FireMode[1].NextFireTime)
	{
		if (FireMode[1].bIsFiring)
			return FMin(1, FireMode[1].HoldTime / FireMode[1].MaxHoldTime);
		return FMin(1, HB4SecondaryFire(FireMode[1]).DecayCharge / FireMode[1].MaxHoldTime);
	}
	return (FireMode[1].NextFireTime - level.TimeSeconds) / FireMode[1].FireRate;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	if (level.TimeSeconds >= FireMode[1].NextFireTime && FRand() > 0.6)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 1536, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.7;	}
// End AI Stuff =====

defaultproperties
{
	AIRating=0.8
	CurrentRating=0.8
	AIReloadTime=1.500000

	AttachmentClass=Class'BWBP_APC_Pro.HB4Attachment'
	BigIconMaterial=Texture'BWBP_APC_Tex.HoloBlaster.BigIcon_HoloBlaster'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	BringUpTime=0.900000

	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipInFrame=0.650000
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipIn')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipOut')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Cock')
	CurrentWeaponMode=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	Description="Maramu Tek might've joined the war against the Skrith late, but their arrival couldn't have come at a better time after the Cryon attack on Neo York.  The situation of having tough armored warriors in an urban situation full of civilians was tough and delicate, if it weren't for Maramu Tek's first offering of the HB4 Grenade Blaster, things would've gone awry very fast. Firing compact stun bolts akin to the Electrobolts that MK781 fires, they disabled the Cyron's intricate wiring systems quickly, and the flash temporarily scrambled their visual processing units, making it handy to have. Neo York was saved while the HB4 went on to perform in situations similar to the Cryon crisis."
	DrawScale=0.300000
	FireModeClass(0)=Class'BWBP_APC_Pro.HB4PrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.HB4SecondaryFire'
	GroupOffset=6
	HudColor=(B=25,G=150,R=50)
	IconCoords=(X2=127,Y2=31)
	IconMaterial=Texture'BWBP_APC_Tex.HoloBlaster.SmallIcon_HoloBlaster'
	InventoryGroup=8
	ItemName="HB4 Electro Grenade Blaster"

	LightBrightness=150.000000
	LightEffect=LE_NonIncidence
	LightHue=30
	LightRadius=4.000000
	LightSaturation=150
	LightType=LT_Pulse
	MagAmmo=3
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	ManualLines(0)="High-powered Blaster fire. Recoil is high."
	Mesh=SkeletalMesh'BWBP_APC_Anim.HB4_FPm'
	ParamsClasses(0)=Class'HB4WeaponParams'
	ParamsClasses(1)=Class'HB4WeaponParamsClassic'
	ParamsClasses(2)=Class'HB4WeaponParamsRealistic'
	PickupClass=Class'BWBP_APC_Pro.HB4Pickup'
	PlayerViewOffset=(X=-5.000000,Y=11.000000,Z=-13.000000)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=255,G=255,R=255,A=255),Color2=(B=255,G=255,R=0,A=137),StartSize1=106,StartSize2=47)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	Priority=24
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	PutDownTime=0.600000
	ReloadAnimRate=1.250000
	SelectForce="SwitchToAssaultRifle"
	SightOffset=(X=10.000000,Y=0.04,Z=7.950000)
	SightingTime=0.250000
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	bNoCrosshairInScope=True
	bShouldDualInLoadout=False
	bShowChargingBar=True
	bWT_Bullet=True
}
