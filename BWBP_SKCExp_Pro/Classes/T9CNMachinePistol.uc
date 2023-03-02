//=============================================================================
// MRDRMachinePistol.
//
// Dual wieldable weapon with a nice spiked handguard for punching
// Small clip but very low recoil and chaos. Fairly accurate actually.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class T9CNMachinePistol extends BallisticHandgun;

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BCRepClass.default.GameStyle == 1)
	{
		bUseSights=True;
	}
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_MRDRClip';
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


simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'IdleOpen';
		ReloadAnim = 'ReloadOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// =============================================

defaultproperties
{
	bShouldDualInLoadout=True
	HandgunGroup=6
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_TexExp.T9CN.BigIcon_BerSilver'
	BigIconCoords=(X1=64,Y1=0,Y2=255)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic pistol fire. Good strength and low recoil."
	SpecialInfo(0)=(Info="420.0;20.0;1.50;80.0;0.4;0.2;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-Cock',Volume=300.500000)
    ClipHitSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-SlideBack',Volume=1.500000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-ClipOut',Volume=300.500000)
    ClipInSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-ClipIn',Volume=300.500000)
    ClipInFrame=0.650000
    WeaponModes(1)=(ModeName="Burst of Three",bUnavailable=True)
    WeaponModes(2)=(ModeName="Burst of Six",bUnavailable=True,ModeID="WM_BigBurst",Value=6.000000)
    WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto"))
	CurrentWeaponMode=3
	SightDisplayFOV=40.000000
	GunLength=0.100000
	AIRating=0.6
	CurrentRating=0.6
	ParamsClasses(0)=Class'T9CNWeaponParamsArena'
	ParamsClasses(1)=Class'T9CNWeaponParamsClassic'
	ParamsClasses(2)=Class'T9CNWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKCExp_Pro.T9CNPrimaryFire'
    FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross3',USize1=256,VSize1=256,USize2=128,VSize2=128,Color1=(B=185,G=190,R=197,A=117),Color2=(B=255,G=255,R=255,A=149),StartSize1=90,StartSize2=38)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=2.000000)
	PutDownTime=0.400000
	BringUpTime=0.500000
	CockingBringUpTime=0.400000
	CockSelectAnim="PulloutFancyOG"
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=False
	Description="The T9CN was the precursor to the standard GRS9 Pistol, and it sported a rugged automatic firing mechanism and nickel finish. The automatic variant was designed with use by counter-terrorism units in mind, but sadly a lack of compensator gave the gun horrible inaccuracy and recoil. Most CTU's quickly dropped the T9CN in favor of other more accurate machine pistols like the XRS-10 and the XK2, however infamous outlaw Var Dehidra and his cronies stole a stash of T9CN's and found good use for them. They were known for spraying them to keep enemies at bay and even tilting them to the side like gangsters of old. Their brazen use of police equipment inspired robberies throughout the cosmos!"
	Priority=143
	HudColor=(B=150,G=150,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=12
	SightPivot=(Pitch=128)
	SightOffset=(X=-10.000000,Y=-2.110000,Z=9.15000)
	PickupClass=Class'BWBP_SKCExp_Pro.T9CNPickup'
	PlayerViewOffset=(X=7.000000,Y=5.500000,Z=-8.000000)
	AttachmentClass=Class'BWBP_SKCExp_Pro.T9CNAttachment'
	IconMaterial=Texture'BWBP_SKC_TexExp.T9CN.SmallIcon_BerSilver'
	IconCoords=(X2=127,Y2=31)
	ItemName="T9CN Automatic Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_T9CNRC'
	DrawScale=0.200000
}
