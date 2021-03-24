//=============================================================================
// XK2SubMachinegun.
//
// A light, very rapid fire SMG which can be silenced. Low damage, fairly low
// recoil, but unstable aim and burns through ammo fast. Silencer makes it very
// hard to detect by removing tracers, using a small muzzle flash and making
// low noise of course.
//
// Weapon balance basis: MP5A2
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XK2SubMachinegun extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//

var int				IceCharge;
var float			LastChargeTime;

const ChargeInterval = 0.5;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
	reliable if (Role == ROLE_Authority)
		IceCharge;
}

simulated function PostNetBeginPlay()
{
	SetBoneScale(2, 0.0, 'AMP');
	super.PostNetBeginPlay();
}

simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);
	
	if (!IsFiring() && IceCharge < 20 && Level.TimeSeconds > LastChargeTime + ChargeInterval)
	{
		IceCharge++;
		LastChargeTime = Level.TimeSeconds;
	}
}

simulated function float ChargeBar()
{
	return IceCharge/20.0f;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	XK2PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}


exec simulated function WeaponSpecial(optional byte i)
{
	if (BCRepClass.default.GameStyle != 1)
		return;
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
	ReloadState = RS_GearSwitch;
}


simulated function SwitchSilencer(bool bNewValue)
{
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}
simulated function Notify_XK2SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_XK2SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_XK2SilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}
simulated function Notify_XK2SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}
simulated function Notify_XK2SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}
simulated function Notify_XK2SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	/*
	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);
	*/

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}
simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
		return true;
	return false;	//This weapon is empty
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

defaultproperties
{
	bSilenced=True
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	SilencerOffTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_XK2'
	BigIconCoords=(X1=24,X2=450)
	SightFXClass=Class'BallisticProV55.XK2SightLEDs'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Low-velocity submachinegun fire. Low recoil, lower damage output than other submachineguns but controllable and excellent hipfire."
	ManualLines(1)="Activates the internal compressor when firing. Rounds will inflict less damage, but will slow the target."
	ManualLines(2)="The Weapon Function key attaches or removes the suppressor. When active, the suppressor reduces recoil and noise output and hides the muzzle flash, but reduces range.||Effective from the hip and at close range."
	SpecialInfo(0)=(Info="120.0;10.0;0.6;60.0;0.3;0.1;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Cock')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst of Three")
	WeaponModes(2)=(ModeName="Burst of Six",ModeID="WM_BigBurst",Value=6.000000)
	WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	CurrentWeaponMode=3
	CockAnimRate=1.25
	bNoCrosshairInScope=True
	SightPivot=(Pitch=256)
	SightOffset=(X=5.000000,Z=12.700000)
	SightDisplayFOV=40.000000
	AIRating=0.8
	CurrentRating=0.8
	SightZoomFactor=0.85
	ParamsClasses(0)=Class'XK2WeaponParams'
	ParamsClasses(1)=Class'XK2WeaponParamsClassic'
	FireModeClass(0)=Class'BallisticProV55.Xk2PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.Xk2SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="Yet another high quality weapon by Black & Wood, the XK2 is a lightweight, suppressed sub-machinegun. It has a fast rate of fire, but its low velocity bullets make it less dangerous than other weapons. However, these low velocity rounds do allow the weapon to be easily silenced, turning it into an effective stealth weapon, used by many law enforcement organisations, and Black-Ops military units alike. The weapon's high rate of fire, and quick reload times, means that the soldier can pump out rounds quicker than even the M353, making it very useful for cover-fire."
	DisplayFOV=55.000000
	Priority=32
	HudColor=(B=100,G=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=1
	PickupClass=Class'BallisticProV55.XK2Pickup'
	PlayerViewOffset=(X=4.000000,Y=8.000000,Z=-11.000000)
	AttachmentClass=Class'BallisticProV55.Xk2Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_XK2'
	IconCoords=(X2=127,Y2=31)
	ItemName="XK2 Submachine Gun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_XK2'
	DrawScale=0.200000
}
