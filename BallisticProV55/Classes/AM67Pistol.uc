//=============================================================================
// AM67Pistol
//
// A powerful sidearm designed for close combat. The .50 bulelts are very
// deadly up, but weaken at range. Secondary is a blinging flash attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67Pistol extends BallisticHandgun;

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
		return FMin(1, AM67SecondaryFire(FireMode[1]).DecayCharge / FireMode[1].MaxHoldTime);
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

	AttachmentClass=Class'BallisticProV55.AM67Attachment'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_AM67'
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
	Description="Another of Enravion's fine creations, the AM67 Assault Pistol was designed for close quarters combat against Cryon and Skrith warriors.|Initially constructed before the second war, Enravion produced the AM67, primarily for anti-Cryon operations, but it later proved to perform well in close-quarters combat when terran forces were ambushed by the stealthy Skrith warriors."
	DrawScale=0.200000
	FireModeClass(0)=Class'BallisticProV55.AM67PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.AM67SecondaryFire'
	GroupOffset=6
	HudColor=(B=25,G=150,R=50)
	IconCoords=(X2=127,Y2=31)
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_AM67'
	InventoryGroup=3
	ItemName="AM67 Assault Pistol"

	LightBrightness=150.000000
	LightEffect=LE_NonIncidence
	LightHue=30
	LightRadius=4.000000
	LightSaturation=150
	LightType=LT_Pulse
	MagAmmo=8
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	ManualLines(0)="High-powered bullet fire. Recoil is high."
	ManualLines(1)="Engages the integrated flash device. The fire key must be held until the flash triggers. Blinds enemies for a short duration. Enemies closer both to the player and to the point of aim will be blinded for longer."
	ManualLines(2)="Effective at close and medium range."
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_AM67'
	ParamsClasses(0)=Class'AM67WeaponParams'
	ParamsClasses(1)=Class'AM67WeaponParamsClassic'
	PickupClass=Class'BallisticProV55.AM67Pickup'
	PlayerViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
	Priority=24
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	PutDownTime=0.600000



	ReloadAnimRate=1.250000
	SelectForce="SwitchToAssaultRifle"
	SightDisplayFOV=60.000000
	SightFXClass=Class'BallisticProV55.AM67SightLEDs'
	SightOffset=(X=10.000000,Y=0.04,Z=7.950000)
	SightingTime=0.250000
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	bNoCrosshairInScope=True
	bShouldDualInLoadout=False
	bShowChargingBar=True
	bWT_Bullet=True
}
