//=============================================================================
// T9CNPistol.
//
// Silver Beretta
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNMachinePistol extends BallisticHandgun;

//Layouts
var()   bool		bHasGauss;				// Fancy version
var()	bool		bGaussCharged;
var	 	float 		GaussLevel, MaxGaussLevel;
var() 	Sound		GaussOnSound;

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bHasGauss=False;
	if (InStr(WeaponParams.LayoutTags, "gauss") != -1)
	{
		bHasGauss=True;
		bShowChargingBar=True;
	}
	
	if (InStr(WeaponParams.LayoutTags, "raffica") != -1)
	{
		SupportHandBone = 'l_upperarm';
	}
	
}

// Gauss Stuff ==================================
simulated function Tick (float DT)
{
	super.Tick(DT);

	if (bHasGauss)
	{
		AddGauss(DT);
	}
}

simulated function AddGauss(optional float Amount)
{
	if (bBerserk)
		Amount *= 1.2;
		
	GaussLevel = FMin(GaussLevel + Amount, MaxGaussLevel);
	
	if (!bGaussCharged && GaussLevel == MaxGaussLevel)
	{			
		PlaySound(GaussOnSound,,1.2,,32);
		bGaussCharged=True;
	}
}

simulated function float ChargeBar()
{
	return FMax(0, GaussLevel/MaxGaussLevel);
}


simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;
	return super.CanAlternate(Mode);
}

simulated event WeaponTick (Float DT)
{
	Super.WeaponTick (DT);
	
	if (LastFireTime < Level.TimeSeconds - RcComponent.DeclineDelay && MeleeFatigue > 0)
		MeleeFatigue = FMax(0, MeleeFatigue - DT/RcComponent.DeclineTime);
}

// Bone hiding + anims ======================
simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(prevWeapon);
	if (MagAmmo < 2)
		SetBoneScale (0, 0.0, 'Bullet');
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
			SetBoneScale (0, 0.0, 'Bullet');
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (0, 1.0, 'Bullet');
}

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale (0, 0.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 2)
		SetBoneScale (0, 0.0, 'Bullet');
}

// =============================================

simulated function bool HasAmmoLoaded(byte Mode)
{
	if (Mode == 1)
		return true;
	if (bNoMag)
		return HasNonMagAmmo(Mode);
	else
		return HasMagAmmo(Mode);
}

//simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
//simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated state Lowering// extends DualAction
{
Begin:
	SafePlayAnim(PutDownAnim, 1.75, 0.1);
	FinishAnim();
	GotoState('Lowered');
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 1536); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =================================

defaultproperties
{
	GaussOnSound=Sound'BW_Core_WeaponSound.Gauss.Gauss-Charge'
	MaxGaussLevel=3
	bShouldDualInLoadout=True
	HandgunGroup=6
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.T9CN.BigIcon_BerSilver'
	BigIconCoords=(X1=64,Y1=0,Y2=255)
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic pistol fire. Good strength and low recoil."
	SpecialInfo(0)=(Info="240.0;12.0;1.50;80.0;0.4;0.2;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout',Volume=0.150000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway',Volume=0.148000)
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Cock',Volume=0.800000)
    ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-SlideBack',Volume=0.800000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-ClipOut',Volume=0.800000)
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-ClipIn',Volume=0.800000)
    ClipInFrame=0.650000
    WeaponModes(1)=(ModeName="Burst of Three",bUnavailable=True)
    WeaponModes(2)=(ModeName="Burst of Six",bUnavailable=True,ModeID="WM_BigBurst",Value=6.000000)
    WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto"))
	CurrentWeaponMode=3
	SightDisplayFOV=40.000000
	GunLength=0.100000
	AIRating=0.6
	CurrentRating=0.6
	ParamsClasses(0)=Class'T9CNWeaponParamsComp'
	ParamsClasses(1)=Class'T9CNWeaponParamsClassic'
	ParamsClasses(2)=Class'T9CNWeaponParamsRealistic'
	ParamsClasses(3)=Class'T9CNWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.T9CNPrimaryFire'
    FireModeClass(1)=Class'BWBP_SKC_Pro.T9CNSecondaryFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross3',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=185,G=190,R=197,A=117),Color2=(B=255,G=255,R=255,A=149),StartSize1=90,StartSize2=38)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=2.000000)
	PutDownTime=0.400000
	BringUpTime=0.500000
	CockingBringUpTime=0.400000
	CockSelectAnim="PulloutFancy"
	CockSelectSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Cock',Volume=0.500000)
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=False
	Description="The T9CN was the precursor to the standard GRS9 Pistol, and it sported a rugged automatic firing mechanism and nickel finish. The automatic variant was designed with use by counter-terrorism units in mind, but sadly a lack of compensator gave the gun horrible inaccuracy and recoil. Most CTU's quickly dropped the T9CN in favor of other more accurate machine pistols like the XRS-10 and the XK2, however infamous outlaw Var Dehidra and his cronies stole a stash of T9CN's and found good use for them. They were known for spraying them to keep enemies at bay and even tilting them to the side like gangsters of old. Their brazen use of police equipment inspired robberies throughout the cosmos!"
	Priority=143
	HudColor=(B=150,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=12
	BobDamping=2f 
	bNoCrosshairInScope=True
	PickupClass=Class'BWBP_SKC_Pro.T9CNPickup'

	PlayerViewOffset=(X=4.00,Y=3.00,Z=-6.00)
	SightOffset=(X=0.00,Y=0.00,Z=1.73)
	SightPivot=(Pitch=128)
	SightBobScale=0.25f

	AttachmentClass=Class'BWBP_SKC_Pro.T9CNAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.T9CN.SmallIcon_BerSilver'
	IconCoords=(X2=127,Y2=31)
	ItemName="T9CN Automatic Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_T9CNRC'
	DrawScale=0.300000
}
