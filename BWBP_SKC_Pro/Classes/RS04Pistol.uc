//=============================================================================
// RS04Pistol.
//
// A medium power pistol with a flasht lgIJELHtn
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04Pistol extends BallisticHandGun;

var() name		SilencerBone;			// Bone to use for hiding silencer

var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var bool		bLightsOn;
var vector		TorchOffset;
var() Sound		TorchOnSound;
var() Sound		TorchOffSound;
var() Sound		DrawSoundQuick;		//For first draw
var() name		FlashlightAnim;

var   bool			bStriking;
var() bool			bHasKnife;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerFlashLight;
}


simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bHasKnife=false;
	
	if (InStr(WeaponParams.LayoutTags, "tacknife") != -1)
	{
		bHasKnife=true;
		MeleeFireMode.Damage = 70;
	}
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

exec simulated function WeaponSpecial(optional byte i)
{
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
	RS04Attachment(ThirdPersonActor).bLightsOn = bLightsOn;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
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
		TazLoc = GetBoneCoords('tip2').Origin;
		TazRot = GetBoneRotation('tip2');
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

simulated function TickFireCounter (float DT)
{
    if (CurrentWeaponMode == 1)
    {
        if (!IsFiring() && FireCount > 0 && FireMode[0].NextFireTime - level.TimeSeconds < -0.5)
            FireCount = 0;
    }
    else
        super.TickFireCounter(DT);
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

simulated function BringUp(optional Weapon PrevWeapon)
{

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'IdleOpen';
		ReloadAnim = 'ReloadOpen';
		SelectAnim = 'PulloutOpen';
		PutDownAnim = 'PutawayOpen';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		PutDownAnim = 'Putaway';
	}
	Super.BringUp(PrevWeapon);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'PulloutAlt' || Anim == 'Fire' || Anim == 'FireDualOpen' || Anim == 'FireDual' ||Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			SelectAnim = 'PulloutOpen';
			PutDownAnim = 'PutawayOpen';
			ReloadAnim = 'ReloadOpen';
			FlashlightAnim = 'FlashLightToggleOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			SelectAnim = 'Pullout';
			PutDownAnim = 'Putaway';
			ReloadAnim = 'Reload';
			FlashlightAnim = 'FlashLightToggle';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
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

	//if (IsSlave())
		//return 0;

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
	return class'AP_M806Clip';
}

defaultproperties
{
	bLightsOn=False
	TorchOffset=(X=-75.000000)
	TorchOnSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	TorchOffSound=Sound'BW_Core_WeaponSound.MRS38.RSS-FlashClick'
	DrawSoundQuick=Sound'BWBP_SKC_Sounds.M1911.RS04-QuickDraw'
	FlashlightAnim="FlashLightToggle"
	MeleeFireClass=Class'BWBP_SKC_Pro.RS04MeleeFire'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.RS04.BigIcon_RS04'
	bWT_Bullet=True
	SpecialInfo(0)=(Info="60.0;6.0;1.0;90.0;0.2;0.0;0.0")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-Draw')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	bShouldDualInLoadout=True
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-Cock',Volume=1.100000)
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-SlideLock',Volume=0.400000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-StockOut',Volume=1.100000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-ClipIn',Volume=1.100000)
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Automatic")
	WeaponModes(1)=(ModeName="Small Burst",Value=2.000000)
	WeaponModes(2)=(bUnavailable=True)
	WeaponModes(3)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=175,G=178,R=176,A=160),Color2=(G=0),StartSize1=52,StartSize2=40)
	NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)

	FireModeClass(0)=Class'BWBP_SKC_Pro.RS04PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.RS04SecondaryFire'
	PutDownTime=0.600000
	BringUpTime=0.800000
	CockingBringUpTime=1.200000
	CockSelectAnim="PulloutAlt"
	CockSelectSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.RS04-SlideLock',Volume=0.400000)
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.400000
	Description="RS04 .45 Compact||Manufacturer: Drake & Co Firearms|Primary: .45 Fire|Secondary: Flashlight||A brand new precision handgun designed by Drake & Co firearms, the Redstrom .45 is to be the military version of the current 10mm RS8. Dubbed the RS04, this unique and accurate pistol is still in its prototype stages. The .45 HV rounds used in the RS04 prototype allow for much improved stopping power at the expense of clip capacity and recoil. Current features include a tactical flashlight and a quick loading double shot firemode. Currently undergoing combat testing by private military contractors, the 8-round Redstrom is seen frequently in the battlefields of corporate warfare. The RS04 .45 Compact model is the latest variant."
	Priority=155
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=10
	PickupClass=Class'BWBP_SKC_Pro.RS04Pickup'

	PlayerViewOffset=(X=3.00,Y=3.00,Z=-6.00)
	SightOffset=(X=-3.50,Y=0.2,Z=1.07)
	SightPivot=(Roll=-256)
	SightingTime=0.200000
	SightBobScale=0.35f

	AttachmentClass=Class'BWBP_SKC_Pro.RS04Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.RS04.SmallIcon_RS04'
	IconCoords=(X2=127,Y2=31)
	ItemName="RS04 Compact Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	ParamsClasses(0)=Class'RS04WeaponParamsComp'
	ParamsClasses(1)=Class'RS04WeaponParamsClassic'
	ParamsClasses(2)=Class'RS04WeaponParamsRealistic'
	ParamsClasses(3)=Class'RS04WeaponParamsTactical'
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_RS04'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_SKC_Tex.RS04.RS04-MainShine'
}
