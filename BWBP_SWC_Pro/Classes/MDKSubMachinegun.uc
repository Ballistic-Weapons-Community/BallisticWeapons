//=============================================================================
// MDKSubMachinegun.
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
class MDKSubMachinegun extends BallisticWeapon;

var		bool		bScopeOn, bScopeAnimEnded;
var() 	name		ScopeOnAnim, ScopeOffAnim;
var() 	Material 	ScopeScopeViewTex;
var() sound			ScopeOnSound;		// Scope stuck on sound
var() sound			ScopeOffSound;		//
var() name			ScopeBone;			// Bone to use for hiding Scope

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

var float LastRangeFound, LastStabilityFound, StealthRating, StealthImps, ZRefHeight;

const ChargeInterval = 0.5;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated function PostNetBeginPlay()
{
	if (bScopeOn)
		SetBoneScale(2, 1.0, ScopeBone);
	else
		SetBoneScale(2, 0.0, ScopeBone);
		
	bScopeAnimEnded = True;
	SetScopeProperties();
	super.PostNetBeginPlay();
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ScopeOffAnim || Anim == ScopeOnAnim)
	{
		if (Role == ROLE_Authority)
			bServerReloading=False;
			
		bScopeAnimEnded = True;
		SetScopeProperties();
	}
		
	super.AnimEnded(Channel, anim, frame, rate);
}

function ServerSwitchScopeType(bool bNewScope)
{
	SwitchScopeType(bNewScope);
}

simulated function SwitchScopeType(bool bNewScope)
{
	if (bNewScope == bScopeOn)
		return;
	
	if (Role == ROLE_Authority)
		bServerReloading=True;
	
	TemporaryScopeDown(0.5);
	ReloadState = RS_GearSwitch;
	
	bScopeAnimEnded = False;
	bScopeOn = bNewScope;
	
	SetBoneScale(2, 1.0, ScopeBone);
	
	if (bNewScope)
		PlayAnim(ScopeOnAnim);
	else
		PlayAnim(ScopeOffAnim);
}

simulated function SetScopeProperties()
{
	if (bScopeOn)
	{
		ZoomType = ZT_Fixed;
		ScopeViewTex = ScopeScopeViewTex;
	}
	else
	{
		ZoomType = ZT_Irons;
		ScopeViewTex = None;
	}
}

exec simulated function ScopeSpecial(optional byte i)
{
	if (ReloadState != RS_None || Clientstate != WS_ReadyToFire || SightingState != SS_None)
		return;
		
	TemporaryScopeDown(0.5);
	
	if (Level.NetMode == NM_Client)
		ServerSwitchScopeType(!bScopeOn);
	SwitchScopeType(!bScopeOn);
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

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	if (bNewValue == bSilenced)
		return;
		
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	BFireMode[0].bAISilent = bSilenced;
	
	MDKPrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;

	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);

	StealthImpulse(0.1);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);

	OnSuppressorSwitched();
}

simulated function StealthImpulse(float Amount)
{
	if (Instigator.IsLocallyControlled())
		StealthImps = FMin(1.0, StealthImps + Amount);
}

simulated function OnSuppressorSwitched()
{
	if (bSilenced)
	{
		ApplySuppressorAim();
		SightingTime *= 1.25;
	}
	else
	{
		AimComponent.Recalculate();
		SightingTime = default.SightingTime;
	}
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

simulated function Notify_SilencerAdd()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}

simulated function Notify_SilencerRemove()
{
	PlaySound(SilencerOffSound,,0.5);
}

simulated function Notify_SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}

simulated function Notify_SilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function Notify_ScopeShow()
{
	SetBoneScale (1, 1.0, ScopeBone);
}

simulated function Notify_ScopeHide()
{
	SetBoneScale (1, 0.0, ScopeBone);
}

simulated function Notify_ScopeAdd()
{
	PlaySound(ScopeOnSound,,0.5);
}

simulated function Notify_ScopeRemove()
{
	PlaySound(ScopeOffSound,,0.5);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
		
	if (bScopeOn)
		SetBoneScale(2, 1.0, ScopeBone);
	else
		SetBoneScale(2, 0.0, ScopeBone);
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
		
	if (bScopeOn)
		SetBoneScale(2, 1.0, ScopeBone);
	else
		SetBoneScale(2, 0.0, ScopeBone);	
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

defaultproperties
{
	ScopeOnAnim="ScopeOn"
    ScopeOffAnim="ScopeOff"
	ScopeBone="Scope"
	ScopeOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	ScopeOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	ScopeScopeViewTex=Texture'BWBP_SWC_Tex.MDK.MDK_Scope'
	BScopeOn=False
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
	BigIconMaterial=Texture'BWBP_SWC_Tex.Icons.BigIcon_MDK'
	BigIconCoords=(X1=24,X2=450)
	//SightFXClass=Class'BWBP_SWC_Pro.MDKSightLEDs'
	bWT_Bullet=True
	bWT_Machinegun=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc1',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(B=128,G=64,R=64,A=140),Color2=(G=0),StartSize1=84,StartSize2=26)
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
	AIRating=0.8
	CurrentRating=0.8
	SightZoomFactor=0.85
	ParamsClasses(0)=Class'MDKWeaponParams'
	ParamsClasses(1)=Class'MDKWeaponParamsClassic'
	ParamsClasses(2)=Class'MDKWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SWC_Pro.MDKPrimaryFire'
	FireModeClass(1)=Class'BWBP_SWC_Pro.MDKSecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	Description="Primary: 9mm Fire||Alt Add/Remove Scope/Silencer||The MDK Modular SMG was created to fill a variety of roles, featuring different rates of fire and varying degrees of accuracy and power to go with them. Though it is fairly compact compared to larger guns, it is quite heavy and cannot be dual-wielded. Black & Wood saw particularly high sales among soldiers and law enforcement officers on fringe colonies that had previously been attacked by the Skrith, as it fills a variety of roles that would normally require multiple weapons."
	Priority=32
	HudColor=(B=200,G=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=1
	PickupClass=Class'BWBP_SWC_Pro.MDKPickup'
	SightOffset=(X=10.000000,Y=-0.050000,Z=41.000000)
	PlayerViewOffset=(X=20.000000,Y=11.000000,Z=-33.000000)
	AttachmentClass=Class'BWBP_SWC_Pro.MDKAttachment'
	IconMaterial=Texture'BWBP_SWC_Tex.Icons.SmallIcon_MDK'
	IconCoords=(X2=127,Y2=31)
	ItemName="MDK-0331 Modular Machine Uzi"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_MDK'
	DrawScale=0.400000
}
