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
class XK2SubMachinegun extends BallisticHandgun;

var(XK2)   bool		bSilenced;				// Silencer on. Silenced
var(XK2) name		SilencerBone;			// Bone to use for hiding silencer
var(XK2) name		SilencerOnAnim;			// Think hard about this one...
var(XK2) name		SilencerOffAnim;		//
var(XK2) sound		SilencerOnSound;		// Silencer stuck on sound
var(XK2) sound		SilencerOffSound;		//
var(XK2) sound		SilencerOnTurnSound;	// Silencer screw on sound
var(XK2) sound		SilencerOffTurnSound;	//

var() array<Material> AmpMaterials; //We're using this for the amp

var(XK2)   bool		bAmped;				// Amp installed, gun has new effects
var(XK2) name		AmplifierBone;			// Bone to use for hiding amp
var(XK2) name		AmplifierOnAnim;			//
var(XK2) name		AmplifierOffAnim;		//
var(XK2) sound		AmplifierOnSound;		// Silencer stuck on sound
var(XK2) sound		AmplifierOffSound;		//
var(XK2) sound		AmplifierPowerOnSound;		// Silencer stuck on sound
var(XK2) sound		AmplifierPowerOffSound;		//
var(XK2) float		AmpCharge;					// Existing ampjuice
var(XK2) float 		DrainRate;					// Rate that ampjuice leaks out
var(XK2) bool		bShowCharge;				// Hides charge until the amp is on

var int				IceCharge;
var float			LastChargeTime;

const ChargeInterval = 0.5;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer, ServerSwitchAmplifier;	
	reliable if (Role == ROLE_Authority)
		IceCharge, ClientSetHeat;
}

simulated function WeaponTick(float DT)
{
	Super.WeaponTick(DT);
	
	if (!IsFiring() && IceCharge < 20 && Level.TimeSeconds > LastChargeTime + ChargeInterval)
	{
		IceCharge++;
		LastChargeTime = Level.TimeSeconds;
	}
	if (AmpCharge > 0)
		AmpCharge = FMax(0, AmpCharge - DrainRate*DT);
}
simulated function float ChargeBar()
{
	//return IceCharge/20.0f;
	
	if (!bShowCharge)
		return 0;
	else
		return AmpCharge / 10;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

//==============================================
// Suppressor Code
//==============================================

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
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	
	if (bAmped)	//take off amp
	{
		bAmped = !bAmped;
		ServerSwitchAmplifier(bAmped);
		SwitchAmplifier(bAmped);
	}
	else
	{
		bSilenced = !bSilenced;
		ServerSwitchSilencer(bSilenced);
		SwitchSilencer(bSilenced);
		ReloadState = RS_GearSwitch;
	}
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

//==============================================
// Amp Code
//==============================================

//mount or unmount amp, but take off silencer where necessary
exec simulated function ToggleAmplifier(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	TemporaryScopeDown(0.5);

	if (bSilenced)	//take off silencer
	{
		bSilenced = !bSilenced;
		ServerSwitchSilencer(bSilenced);
		SwitchSilencer(bSilenced);
		ReloadState = RS_GearSwitch;
	}
	else
	{
		bAmped = !bAmped;
		ServerSwitchAmplifier(bAmped);
		SwitchAmplifier(bAmped);
	}
}
function ServerSwitchAmplifier(bool bNewValue)
{
	bAmped = bNewValue;

	SwitchAmplifier(bAmped);

	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	if (bAmped)
	{
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=true;
		WeaponModes[4].bUnavailable=false;
		CurrentWeaponMode=4;
		ServerSwitchWeaponMode(4);
		AmpCharge=10;
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		XK2Attachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//blue
	{
		Skins[2]=AmpMaterials[0];
		Skins[3]=AmpMaterials[1];
	}
}

simulated function SwitchAmplifier(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
		
	ReloadState = RS_GearSwitch;

	if (bNewValue)
	{
		PlayAnim(AmplifierOnAnim);
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		WeaponModes[3].bUnavailable=true;
		WeaponModes[4].bUnavailable=false;
		AmpCharge=10;
	}
	else
	{
		PlayAnim(AmplifierOffAnim);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		XK2Attachment(ThirdPersonActor).SetAmped(bNewValue);
		
	if (CurrentWeaponMode == 4 && AmpCharge > 0)	//blue
	{
		Skins[2]=AmpMaterials[0];
		Skins[3]=AmpMaterials[1];
	}
}

simulated function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		XK2PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}

simulated function CommonSwitchWeaponMode (byte newMode)
{
	super.CommonSwitchWeaponMode(newMode);

	XK2PrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 4 && AmpCharge > 0)	//blue
	{
		Skins[2]=AmpMaterials[0];
		Skins[3]=AmpMaterials[1];
	}
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;
		
	AmpCharge = FMax(0, AmpCharge + Amount);
	
	if (AmpCharge <= 0)
	{
		PlaySound(AmplifierPowerOffSound,,2.0,,32);
		Skins[2]=AmpMaterials[2];
		Skins[3]=AmpMaterials[3];
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		WeaponModes[3].bUnavailable=false;
		WeaponModes[4].bUnavailable=true;
		CurrentWeaponMode=3;
		ServerSwitchWeaponMode(3);
		if (Role == ROLE_Authority)
			XK2Attachment(ThirdPersonActor).SetAmped(false);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	AmpCharge = NewHeat;
}

simulated function Notify_XK2AmpOn()	{	PlaySound(AmplifierOnSound,,0.5);		bShowCharge=true;}
simulated function Notify_XK2AmpOff()	{	PlaySound(AmplifierOffSound,,0.5);		bShowCharge=false;}

simulated function Notify_XK2AmpShow(){	SetBoneScale (2, 1.0, AmplifierBone);	}
simulated function Notify_XK2AmpHide(){	SetBoneScale (2, 0.0, AmplifierBone);	}

//==============================================
// Regular Functions
//==============================================

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

	if (bAmped)
		SetBoneScale (2, 1.0, AmplifierBone);
	else
		SetBoneScale (2, 0.0, AmplifierBone);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

defaultproperties
{
	AmplifierBone="AMP"
    AmplifierOnAnim="AMPOn"
    AmplifierOffAnim="AMPOff"
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
    AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.AMP.Amp-Install'
    AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.AMP.Amp-Depleted'
	DrainRate=0.15
	
	AmpMaterials[0]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalCyan'
	AmpMaterials[1]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowCyanShader'
    AmpMaterials[2]=Texture'BW_Core_WeaponTex.Amp.Amp-BaseDepleted'
    AmpMaterials[3]=Texture'ONSstructureTextures.CoreGroup.Invisible'
	
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
	WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=3
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),StartSize1=70,StartSize2=82)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
	
	CockAnimRate=1.25
	bNoCrosshairInScope=True
	SightPivot=(Pitch=64)
	SightOffset=(X=22.000000,Y=0.01,Z=11.500000)
	SightBobScale=0.15f
	AIRating=0.8
	CurrentRating=0.8
	SightZoomFactor=1.2
	ParamsClasses(0)=Class'XK2WeaponParamsComp'
	ParamsClasses(1)=Class'XK2WeaponParamsClassic'
	ParamsClasses(2)=Class'XK2WeaponParamsRealistic'
    ParamsClasses(3)=Class'XK2WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.Xk2PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.Xk2SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="Yet another high quality weapon by Black & Wood, the XK2 is a lightweight, suppressed sub-machinegun. It has a fast rate of fire, but its low velocity bullets make it less dangerous than other weapons. However, these low velocity rounds do allow the weapon to be easily silenced, turning it into an effective stealth weapon, used by many law enforcement organisations, and Black-Ops military units alike. The weapon's high rate of fire, and quick reload times, means that the soldier can pump out rounds quicker than even the M353, making it very useful for cover-fire."
	Priority=32
	HudColor=(B=100,G=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=1
	SightAnimScale=0.75
	PickupClass=Class'BallisticProV55.XK2Pickup'
	PlayerViewOffset=(X=-8.000000,Y=5.000000,Z=-12.000000)
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
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Shader'BW_Core_WeaponTex.XK2.XK2_Main-Shiney'
    Skins(2)=Shader'BW_Core_WeaponTex.AMP.Amp-FinalCyan'
    Skins(3)=Shader'BW_Core_WeaponTex.AMP.Amp-GlowCyanShader'
}
