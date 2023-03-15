//=============================================================================
// RS8Pistol.
//
// A medium power pistol with a lasersight and silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45Pistol extends BallisticHandgun;

var(SX45)   bool		bAmped;						// ARE YOU AMPED? BECAUSE THIS GUN IS!
var(SX45) name		AmplifierBone;				// Bone to use for hiding cool shit
var(SX45) name		AmplifierBone2;				// Xav likes to make my life difficult
var(SX45) name		AmplifierOnAnim;			//
var(SX45) name		AmplifierOffAnim;			//
var(SX45) sound		AmplifierOnSound;			// 
var(SX45) sound		AmplifierOffSound;			//
var(SX45) sound		AmplifierPowerOnSound;		// Electrical noises?
var(SX45) sound		AmplifierPowerOffSound;		//
var(SX45) float		AmpCharge;					// Existing ampjuice
var(SX45) float 	DrainRate;					// Rate that ampjuice leaks out
var(SX45) bool		bShowCharge;				// Hides charge until the amp is on

var() array<Material> AmpMaterials; //We're using this for the amp

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var() name		FlashlightAnim;

var bool		bFirstDraw;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight, ServerSwitchAmplifier;
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated state PendingSwitchAmplifier extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) ToggleAmplifier();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}

//==============================================
// Amp Code
//==============================================

//mount or unmount amp
exec simulated function ToggleAmplifier(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Othergun != None)
	{
		if (Othergun.Clientstate != WS_ReadyToFire)
			return;
		if (IsinState('DualAction'))
			return;
		if (!Othergun.IsinState('Lowered'))
		{
			GotoState('PendingSwitchAmplifier');
			return;
		}
	}

	TemporaryScopeDown(0.5);

	bAmped = !bAmped;
	ServerSwitchAmplifier(bAmped);
	SwitchAmplifier(bAmped);
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
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		CurrentWeaponMode=1;
		ServerSwitchWeaponMode(1);
		AmpCharge=10;
	}
	else
	{
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);
		AmpCharge=0;
	}
	
	if (Role == ROLE_Authority)
		SX45Attachment(ThirdPersonActor).SetAmped(bNewValue);
	
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//cryo
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[6]=AmpMaterials[1];
		Skins[7]=AmpMaterials[2];
	}
	else if (CurrentWeaponMode == 2 && AmpCharge > 0)	//RAD
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[6]=AmpMaterials[0];
		Skins[7]=AmpMaterials[3];
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
		WeaponModes[1].bUnavailable=false;
		WeaponModes[2].bUnavailable=false;
		AmpCharge=10;
	}
	else
	{
		PlayAnim(AmplifierOffAnim);
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		AmpCharge=0;
	}
		
	if (Role == ROLE_Authority)
		SX45Attachment(ThirdPersonActor).SetAmped(bNewValue);
	
	if (CurrentWeaponMode == 1 && AmpCharge > 0)	//cryo
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[6]=AmpMaterials[1];
		Skins[7]=AmpMaterials[2];
	}
	else if (CurrentWeaponMode == 2 && AmpCharge > 0)	//RAD
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[6]=AmpMaterials[0];
		Skins[7]=AmpMaterials[3];
	}
}

function ServerSwitchWeaponMode (byte newMode)
{
	super.ServerSwitchWeaponMode (newMode);
	if (!Instigator.IsLocallyControlled())
		SX45PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
}
simulated function CommonSwitchWeaponMode (byte newMode)
{
	super.CommonSwitchWeaponMode(newMode);

	SX45PrimaryFire(FireMode[0]).SwitchWeaponMode(newMode);
	if (newMode == 1 && AmpCharge > 0)
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(true, false);
		Skins[6]=AmpMaterials[1];
		Skins[7]=AmpMaterials[2];
	}
	else if (newMode == 2 && AmpCharge > 0)
	{
		SX45Attachment(ThirdPersonActor).SetAmpColour(false, true);
		Skins[6]=AmpMaterials[0];
		Skins[7]=AmpMaterials[3];
	}
}

simulated function Notify_AmplifierOn()	{		PlaySound(AmplifierOnSound,,0.5); }
simulated function Notify_AmplifierOff()	{	PlaySound(AmplifierOffSound,,0.5);	bShowCharge=false;}
simulated function Notify_AmplifierCharged()	{		PlaySound(AmplifierPowerOnSound,,1.6);	bShowCharge=true;}

simulated function Notify_AmplifierShow()
{	
	SetBoneScale (0, 1.0, AmplifierBone);	
	SetBoneScale (2, 0.0, AmplifierBone2);	
}
simulated function Notify_AmplifierHide()
{	
	SetBoneScale (0, 0.0, AmplifierBone);	
	SetBoneScale (2, 1.0, AmplifierBone2);	
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
	{
		bAmped = (FRand() > 0.5);
		bLightsOn == (FRand() > 0.5);
	}

	if (bAmped)
	{
		SetBoneScale (0, 1.0, AmplifierBone);
		SetBoneScale (2, 0.0, AmplifierBone2);
	}		
	else
	{
		SetBoneScale (0, 0.0, AmplifierBone);
		SetBoneScale (2, 1.0, AmplifierBone2);	
	}
}

simulated function float ChargeBar()
{
	if (!bShowCharge)
		return 0;
	else
		return AmpCharge / 10;
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;
		
	AmpCharge = FMax(0, AmpCharge + Amount);
	
	if (AmpCharge <= 0)
	{
		PlaySound(AmplifierPowerOffSound,,2.0,,32);
		Skins[6]=AmpMaterials[4];
		Skins[7]=AmpMaterials[5];
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
		CurrentWeaponMode=0;
		ServerSwitchWeaponMode(0);
		if (Role == ROLE_Authority)
			SX45Attachment(ThirdPersonActor).SetAmped(false);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	AmpCharge = NewHeat;
}

//======================================================
// Flashlight
//======================================================

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;

	SafePlayAnim(FlashlightAnim, 1, 0, ,"FIRE");
	bLightsOn = !bLightsOn;
	ServerFlashLight(bLightsOn);
	if (bLightsOn)
	{
		PlaySound(TorchOnSound,,0.7,,32);
		if (FlashLightEmitter == None)
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
		class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
		StartProjector();
	}
	else
	{
		PlaySound(TorchOffSound,,0.7,,32);
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		KillProjector();
	}
}

function ServerFlashLight (bool bNew)
{
	bLightsOn = bNew;
	SX45Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip3');
	FlashLightProj.SetRelativeLocation(TorchOffset);
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
		FlashLightProj.Destroy();
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (AmpCharge > 0)
		AddHeat(-DrainRate * DT);

	if (!bLightsOn || ClientState != WS_ReadyToFire)
		return;
	if (!Instigator.IsFirstPerson())
		KillProjector();
	else if (FlashLightProj == None)
		StartProjector();		
}


simulated event RenderOverlays( Canvas Canvas )
{
	local Vector TazLoc;
	local Rotator TazRot;
	super.RenderOverlays(Canvas);
	if (bLightsOn)
	{
		TazLoc = GetBoneCoords('tip3').Origin;
		TazRot = GetBoneRotation('tip3');
		if (FlashLightEmitter != None)
		{
			FlashLightEmitter.SetLocation(TazLoc);
			FlashLightEmitter.SetRotation(TazRot);
			Canvas.DrawActor(FlashLightEmitter, false, false, DisplayFOV);
		}
	}
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillProjector();
		if (FlashLightEmitter != None)
			FlashLightEmitter.Destroy();
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	super.Destroyed();
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'PulloutAlt' || Anim == 'Fire' || Anim == 'FireDualOpen' || Anim == 'FireDual' ||Anim == CockAnim || Anim == ReloadAnim || Anim == 'FireOpen' || Anim == 'SightFireOpen' || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			PutDownAnim = 'PutawayOpen';
			ReloadAnim = 'ReloadOpen';
			FlashlightAnim = 'ToggleFlashLightOpen';
			AmplifierOnAnim = 'AmpAddOpen';
			AmplifierOffAnim = 'AmpRemoveOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			PutDownAnim = 'Putaway';
			ReloadAnim = 'Reload';
			FlashlightAnim = 'ToggleFlashLight';
			AmplifierOnAnim = 'AmpAdd';
			AmplifierOffAnim = 'AmpRemove';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 2)
		SetBoneScale (1, 0.0, 'Bullet');
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
	CurrentWeaponMode=2;
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
	if (Dist > 500)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 1000)
		Result -= (Dist-1000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SX45Clip';
}

defaultproperties
{
	DrainRate=0.15
	AmpMaterials[0]=Shader'BW_Core_WeaponTex.AMP.Amp-FinalYellow'
	AmpMaterials[1]=Shader'BW_Core_WeaponTex.AMP.Amp-FinalCyan'
	AmpMaterials[2]=Shader'BW_Core_WeaponTex.Amp.Amp-GlowCyanShader'
    AmpMaterials[3]=Shader'BW_Core_WeaponTex.Amp.Amp-GlowYellowShader'
    AmpMaterials[4]=Texture'BW_Core_WeaponTex.Amp.Amp-BaseDepleted'
    AmpMaterials[5]=Texture'ONSstructureTextures.CoreGroup.Invisible'
    AmplifierBone="AMP"
    AmplifierBone2="AMP2"
    AmplifierOnAnim="AMPAdd"
    AmplifierOffAnim="AMPRemove"
	FlashlightAnim="ToggleFlashlight"
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
    TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
    AmplifierOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
    AmplifierOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
    AmplifierPowerOnSound=Sound'BW_Core_WeaponSound.AMP.Amp-Install'
    AmplifierPowerOffSound=Sound'BW_Core_WeaponSound.AMP.Amp-Depleted'
	bShouldDualInLoadout=True
	bShowChargingBar=True
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_TexExp.SX45.BigIcon_SX45'
	BigIconCoords=(X1=64,Y1=70,X2=418)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic .45 ACP Fire. Moderate damage and fire rate."
	ManualLines(1)="Attach/Detach AMP. With a Choice of Radiation Bullets and Cryogenic Bullets"
	ManualLines(2)="Torch Available on the Weapon Function"
	SpecialInfo(0)=(Info="0.0;-5.0;-999.0;-1.0;0.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-Cock')
	ReloadAnimRate=1.250000
	SelectAnimRate=1.500000
	BringUpTime=0.700000
	ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-MagOut')
	ClipInSound=(Sound=Sound'BWBP_SKC_SoundsExp.SX45.SX45-MagIn')
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-ClipHit')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Auto")
    WeaponModes(1)=(ModeName="Amplified: Cryogenic",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
    WeaponModes(2)=(ModeName="Amplified: Radiation",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(y=-3.140000,Z=14.300000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'SX45WeaponParamsArena'
	ParamsClasses(1)=Class'SX45WeaponParamsClassic'
	ParamsClasses(2)=Class'SX45WeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKC_Pro.SX45PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.SX45SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.6
	Description="As the skrith wars wages onwards, new companies are sprouting left and right to aid in trying times.  The latest to enter into the foray is Storm-X, or SX LTD for short with their offerings of the SX-45K Combat Handgun, chambered in .45ACP and intends to replace the service standard M806.  Precision and power is the motto of this handgun with a Mini-RDS and a threaded barrel to mount various options, including the experimental elemental amp that makes the pistol fire cyro bullets that split or radioactive bullets that leaves clouds behind."
	Priority=17
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=11
	PickupClass=Class'BWBP_SKC_Pro.SX45Pickup'
	PlayerViewOffset=(X=0.000000,Y=7.000000,Z=-12.000000)
	AttachmentClass=Class'BWBP_SKC_Pro.SX45Attachment'
	IconMaterial=Texture'BWBP_SKC_TexExp.SX45.SmallIcon_SX45'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=175,G=178,R=176,A=160),Color2=(G=0),StartSize1=52,StartSize2=40)
	NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
	IconCoords=(X2=127,Y2=31)
	ItemName="SX-45K Combat Handgun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_FNX'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Texture'BWBP_SKC_TexExp.SX45.SX45-Mag'
    Skins(2)=Shader'BWBP_SKC_TexExp.SX45.SX45-SightReticle_S'
    Skins(3)=Texture'BWBP_SKC_TexExp.SX45.SX45-Sight'
    Skins(4)=Texture'BWBP_SKC_TexExp.SX45.SX45-Main'
    Skins(5)=Texture'BWBP_SKC_TexExp.SX45.SX45-Laser'
    Skins(6)=Shader'BW_Core_WeaponTex.Amp.Amp-FinalCyan'
	Skins(7)=Shader'BW_Core_WeaponTex.Amp.Amp-GlowCyanShader'
}
