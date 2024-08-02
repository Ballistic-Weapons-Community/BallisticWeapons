//=============================================================================
// M2020GaussDMR.
//
// Semi-Auto designated marksman rifle. Fufills the roll of semi-auto sniper since the Bulldog has
// no scope and the X83 has ludicrous recoil. Can trade RoF/Power via firemodes.
// 
// Special fire generates a heavy magnetic field which reduces incoming damage but will damage the gun.
// Heavy magnetic field shield will reduce incoming dmg by 30, but won't negate completely. (5 dmg)
// Magnets cannot accelerate bullets while shield is being generated.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M2020GaussDMR extends BallisticWeapon;

var   Emitter		LaserDot;
var   bool			bLaserOn;
var	int				NumpadXOffset;
var	int				NumpadYOffset;

var bool				bOverheat;
var() Sound		DrawSoundLong;		//For first draw
var() Sound		VentingSound;		//For DA MAGNETS
var() Sound		OverHeatSound;		//For vents
var Sound      	ShieldHitSound;
var float			HeatLevel;			// Current Heat level, duh...
var float			MaxHeat;

var name			BulletBone1;
var name			BulletBone2;

var Actor			Arc;				// The top arcs

var   float			MagnetSwitchTime, MagnetSwitchFireRate;
var   name			MagnetOpenAnim;
var   name			MagnetCloseAnim;
var   name			MagnetForceCloseAnim;
var   bool			bMagnetOpen;
var   byte			PreviousWeaponMode;

var() ScriptedTexture WeaponScreen;

var() Material	Screen; //This is a self-illum Scipted Texture
var() Material	ScreenBaseX; //This is a texture that can be Base1 or Base2
var() Material	ScreenBase1; //This is the On Screen background
var() Material	ScreenBase2; //This is the Off Screen background
var() Material	Numbers;     //This is the font used by the screen
var protected const color MyFontColor; //Why do I even need this?


replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart, ClientSetHeat;
}

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[3] = Screen;
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;

	if (Arc != None)
		Arc.Destroy();
	Super.Destroyed();
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBaseX, MyFontColor);
	Tex.DrawTile(100,120,100,160,NumpadXOffset,NumpadYOffset,70,60,Numbers, MyFontColor);
}
	
simulated function UpdateScreen()
{

	if (Instigator != None && AIController(Instigator.Controller) != None)
		return;

	if (bMagnetOpen)
	{
		ScreenBaseX=ScreenBase2;
		Instigator.AmbientSound = VentingSound;
	}
	else
	{
		ScreenBaseX=ScreenBase1;
		Instigator.AmbientSound = UsedAmbientSound;
	}
}
	
// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	UpdateScreen();
	return true;
}

//=====================================================================

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_42MachineGun';
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	bMagnetOpen=false;

	UpdateScreen();
	Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bMagnetOpen)
		{
			bMagnetOpen=false;
			AdjustMagnetProperties();
		}
		if (Arc != None)	Arc.Destroy();
		return true;
	}
	return false;
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (bOverheat)
		return;
	if (level.TimeSeconds < MagnetSwitchTime || ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;

	bMagnetOpen = !bMagnetOpen;

	ReloadState = RS_GearSwitch;

	TemporaryScopeDown(0.4);
	MagnetSwitchTime = level.TimeSeconds + MagnetSwitchFireRate;
	PlayMagnetSwitching(bMagnetOpen);
	AdjustMagnetProperties();
	if(Level.NetMode == NM_Client)
		ServerWeaponSpecial(byte(bMagnetOpen));
}

function ServerWeaponSpecial (byte i)
{
	if (bOverheat)
		return;
	
	bMagnetOpen = bool(i);
	PlayMagnetSwitching(bMagnetOpen);
	AdjustMagnetProperties();
}

//Animation for magnet
simulated function PlayMagnetSwitching(bool bOpen)
{
	if (bOpen)
		PlayAnim(MagnetOpenAnim);
	else
		PlayAnim(MagnetCloseAnim);
}

simulated function Overheat(bool bForceClose)
{
	if (bForceClose)
		PlayAnim(MagnetForceCloseAnim);
	else
		PlayAnim(MagnetCloseAnim);

	ReloadState = RS_GearSwitch;
	bMagnetOpen=false;
	MagnetSwitchTime = level.TimeSeconds + 5;	//delay before magnet can be turned on again
	AdjustMagnetProperties();
	class'BallisticDamageType'.static.GenericHurt (Instigator, 30, None, Instigator.Location, vect(0,0,0), class'DT_M2020Overheat');
}

simulated function AdjustMagnetProperties ()
{
	if (bMagnetOpen)
	{
		if (Arc == None)
			class'bUtil'.static.InitMuzzleFlash(Arc, class'M2020ShieldEffect', DrawScale, self, 'tip');

		IdleAnim='IdleShield';
		BFireMode[0].FireRecoil = 64;
		WeaponModes[3].bUnavailable=false;
		
		PreviousWeaponMode = CurrentWeaponMode;
		CurrentWeaponMode = 3;
		
		SwitchWeaponMode(CurrentWeaponMode+1);
		//M2020GaussPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		
		WeaponModes[0].bUnavailable=true;
		WeaponModes[1].bUnavailable=true;
		WeaponModes[2].bUnavailable=true;
	}
	else
	{
		if (Arc != None)
			Emitter(Arc).kill();

		IdleAnim='Idle';
		Instigator.AmbientSound = UsedAmbientSound;
		BFireMode[0].FireRecoil = BFireMode[0].default.FireRecoil;
		
		WeaponModes[0].bUnavailable=false;
		WeaponModes[1].bUnavailable=false;
		if (!class'BallisticReplicationInfo'.static.IsRealism())
		{
			WeaponModes[2].bUnavailable=false;
		}
		CurrentWeaponMode = PreviousWeaponMode;
		
		SwitchWeaponMode(CurrentWeaponMode+1);
		//M2020GaussPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		
		WeaponModes[3].bUnavailable=true;
	}
	UpdateScreen();
}

simulated event WeaponTick (float DT)
{
	if (bOverheat && Heatlevel == 0.2)
		Overheat(false);
	super.WeaponTick(DT);
}

simulated event Tick (float DT)
{
	if (bMagnetOpen)
		AddHeat(DT*200, false);
	else if (Heatlevel > 0)
		Heatlevel = FMax(HeatLevel - (DT*200) * 0.45f, 0);
	else
		Heatlevel = 0;

	super.Tick(DT);
}

// Draw the scope view
simulated event RenderOverlays (Canvas C)
{
	if (MagAmmo == 0)
	{
		NumpadXOffset=160; NumpadYOffset=10;
	}
	else if (MagAmmo > 10)
	{
		NumpadXOffset=160; NumpadYOffset=60;
	}
	else
	{
		NumpadXOffset=50;
		NumpadYOffset=(10+(10-MagAmmo)*49);
	}
	if (Instigator.IsLocallyControlled())
	{
		WeaponScreen.Revision++;
	}

	Super.RenderOverlays(C);
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

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == MagnetCloseAnim && ReloadState == RS_StartShovel)
	{
		ReloadState = RS_PreClipOut;
		bMagnetOpen = False;
		AdjustMagnetProperties();
		PlayReload();
	}
	if (anim == MagnetForceCloseAnim || anim == MagnetOpenAnim)
		ReloadState = RS_None;

	Super.AnimEnd(Channel);
}

simulated function PlayReload()
{
	if (bMagnetOpen)
		SafePlayAnim(MagnetCloseAnim, 1.2, , 0, "RELOAD");
	else
		super.PlayReload();
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (bMagnetOpen)
		ReloadState = RS_StartShovel;
	else
		ReloadState = RS_PreClipOut;
	PlayReload();

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;
	bNeedReload=false;
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(0,1.0,BulletBone1);
	if (Ammo[0].AmmoAmount > 1)
		SetBoneScale(1,1.0,BulletBone2);
	
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();
	if (MagAmmo < 3)
		SetBoneScale(1,0.0,BulletBone2);
	if(MagAmmo < 2)
		SetBoneScale(0,0.0,BulletBone1);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
    local vector HitNormal;

	if( !DamageType.default.bLocationalHit )
        return;
		
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bMetallic)
		return;

    if ( CheckReflect(HitLocation, HitNormal, 0) )
    {
		AddHeat(Damage*2.5, false);

		Damage /= 2;
		Momentum /= 2;

		M2020GaussAttachment(ThirdPersonActor).BlockEffectCount += 1;
		M2020GaussAttachment(ThirdPersonActor).DoBlockEffect();
		
		PlaySound(ShieldHitSound, SLOT_None);
    }
	
	Super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

function bool CheckReflect( Vector HitLocation, out Vector RefNormal, int AmmoDrain )
{
    local Vector HitDir;
    local Vector FaceDir;

    if (!bMagnetOpen) 
		return false;

    FaceDir = Vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));

    RefNormal = FaceDir;

	//scalar "dot" product returns product of norm of both vectors (in this case, their size is 1) multiplied by the cosine of the angle between them
	//reversing this convention, we get the protection arc angle = 180-arccos(X), so we measure a cone with slant angle X, around the player's face
	//eg. 180-arccos(-0.37) = 68 degree protection arc (original value), so cos(180-68)=-0.37 is the value to use

    if ( FaceDir dot HitDir < -0.37 )	// 68 degree protection arc
        return true;

    return false;
}

simulated function AddHeat(float Amount, bool bReplicate)
{
	HeatLevel = FClamp(HeatLevel+Amount, 0, MaxHeat);
	
	if (bReplicate && !Instigator.IsLocallyControlled())
		ClientSetHeat(HeatLevel);
		
	if (HeatLevel == MaxHeat && bMagnetOpen)
	{
		PlaySound(OverHeatSound,,3.7,,32);
		Overheat(true);
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
	
	if (HeatLevel == MaxHeat && bMagnetOpen)
	{
		PlaySound(OverHeatSound,,3.7,,32);
		Overheat(true);
	}
}

simulated function float ChargeBar()
{
	return (HeatLevel/MaxHeat);
}

defaultproperties
{
	bLaserOn=True
	DrawSoundLong=Sound'BWBP_SKC_Sounds.M2020.M2020-DrawLong'
	VentingSound=Sound'BWBP_SKC_Sounds.M2020.M2020-IdleShield'
	OverheatSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
	ShieldHitSound=ProceduralSound'WeaponSounds.ShieldGun.ShieldReflection'
	MaxHeat=2400.000000	//12 seconds * 20 = 2000. this change is to avoid precision errors with adding epsilon of heat
	MagnetSwitchFireRate=2.000000
	BulletBone1="Bullet1"
	BulletBone2="Bullet2"
	MagnetOpenAnim="ShieldDeploy"
	MagnetCloseAnim="ShieldUndeploy"
	MagnetForceCloseAnim="Overheat"
	WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.M2020.M2020-ScriptLCD'
	screen=Shader'BWBP_SKC_Tex.M2020.M2020-ScriptLCD-SD'
	ScreenBase1=Texture'BWBP_SKC_Tex.M2020.M2020-Screen'
	ScreenBase2=Texture'BWBP_SKC_Tex.M2020.M2020-ScreenOff'
	Numbers=Texture'BWBP_SKC_Tex.M2020.M2020-Numbers'
	MyFontColor=(B=255,G=255,R=255,A=255)
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.M2020.BigIcon_M2020'
	
	bWT_Bullet=True
	ManualLines(0)="Power mode fires a single powerful shot with high recoil and damage. Fire rate is poor.|Recharge mode fires more quickly for greater sustained DPS but lower individual shot power.|Offline mode (or Deflecting mode when the shield is active) has the lowest power, but does not generate a bullet trail."
	ManualLines(1)="Raises the scope."
	ManualLines(2)="The Weapon Function key generates a frontal magnetic deflection shield, locking the rifle to Offline mode. This shield lasts up to 10 seconds and immunizes the user against any frontal attack which is delivered by means of any metal object. ||Effective at long range."
	SpecialInfo(0)=(Info="240.0;25.0;1.0;80.0;2.0;0.1;0.1")
	BringUpSound=(Sound=Sound'WeaponSounds.LightningGun.SwitchToLightningGun',Volume=0.182000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway',Volume=0.187000)
	CockAnimPostReload="ReloadEndCock"
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-Cock',Volume=1.400000)
	CockSelectSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-CockOld',Volume=1.400000)
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-MagHit',Volume=1.400000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-MagOut',Volume=1.400000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-MagIn',Volume=1.400000)
	ClipInFrame=0.650000
	bCockOnEmpty=True
	WeaponModes(0)=(ModeName="Gauss: Recharge",RecoilParamsIndex=0)
	WeaponModes(1)=(ModeName="Gauss: Power",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=1)
	WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
	WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BWBP_SKC_Tex.M2020.M2020ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoCrosshairInScope=True
	MinFixedZoomLevel=0.350000
	MinZoom=2.000000
	MaxZoom=16.000000
	ZoomStages=8
	GunLength=80.000000
	ParamsClasses(0)=Class'M2020WeaponParamsComp'
	ParamsClasses(1)=Class'M2020WeaponParamsClassic'
	ParamsClasses(2)=Class'M2020WeaponParamsRealistic'
    ParamsClasses(3)=Class'M2020WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.M2020GaussPrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=207,G=229,R=231,A=197),Color2=(B=226,G=0,R=0,A=255),StartSize1=77,StartSize2=68)
	PutDownTime=0.80000
	BringUpTime=0.80000
	CockingBringUpTime=2.900000
	SelectAnimRate=1.4
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	bShowChargingBar=True
	Description="The M2020 is a 2nd generation Gauss rifle in use by UTC marksmen personnel, currently in the process of being phased out by Enravion 3rd generation M30 models. These 2nd generation Gauss rifles are significantly more portable and powerful than their predecessors, however troops have complained about the M2020 in particular's bulkiness and lack of ergonomics. The rifle itself uses two parallel heavy electromagnets to boost its special 7.62mm rounds to extreme velocities. Charge is variable, and the electromagnets can be disabled at will. |UTC Note: When operating this weapon, keep all metallic objects away from the reciprocaiting chargers. While locking the weapon's magnets open can be fun for pranks, troops are advised to not use it near sensitive military equipment."
	Priority=65
	HudColor=(B=255,G=175,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=11
	PickupClass=Class'BWBP_SKC_Pro.M2020GaussPickup'

	PlayerViewOffset=(X=2.00,Y=4.50,Z=-3.50)
	SightOffset=(X=4.00,Y=0.00,Z=1.93)

	AttachmentClass=Class'BWBP_SKC_Pro.M2020GaussAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.M2020.SmallIcon_M2020'
	IconCoords=(X2=127,Y2=31)
	ItemName="M2020 Gauss DMR"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M2020'
	DrawScale=0.300000
	bFullVolume=True
	SoundVolume=64
	SoundRadius=128.000000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BWBP_SKC_Tex.M2020.M2020-ShineAlt'
	Skins(2)=Shader'BWBP_SKC_Tex.M2020.M2020-Shine'
}
