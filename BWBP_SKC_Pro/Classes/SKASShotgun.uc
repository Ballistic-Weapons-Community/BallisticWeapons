//=============================================================================
// SKASShotgun.
//
// Automatic shotgun.
//
// by Nolan "Dark Carnivour" Richert
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASShotgun extends BallisticProShotgun;

var bool		bIsSuper;			// Manual mode!
var float		lastModeChangeTime;
var() sound     QuickCockSound;
var() sound		UltraDrawSound;       	//56k MODEM ACTION.

var()     float Heat;
var()     float CoolRate;

var   float DesiredSpeed, BarrelSpeed;
var   float MaxRotationSpeed;
var   int	BarrelTurn;
var() Sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	SKASPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	SKASPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		SKASPrimaryFire(FireMode[0]).bRequireSpool=true;
	}
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SKASPrimaryFire(FireMode[0]).MainGun = self;
}

// takes more time to reach higher speeds
// this is unrealistic because miniguns are electric with extremely powerful motors and provide constant torque,
// but do you really want the xmv to spin up to 3600rpm instantly? I for one don't
simulated function float GetRampUpSpeed()
{
	local float mult;
	
	mult = 1 - (BarrelSpeed / MaxRotationSpeed);
	
	if (class'BallisticReplicationInfo'.static.IsRealism())
		return 0.075f + (3.0 * mult * (1 + 0.25*int(bBerserk)));
	else
		return 0.075f + (mult * (1 + 0.25*int(bBerserk)));
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	if (Heat > 0)
		Heat = FMax(0, Heat - CoolRate*DT);

	super.WeaponTick(DT);

	if (class'BallisticReplicationInfo'.static.IsClassic())
		return;
	
	BT.Pitch = BarrelTurn;
	SetBoneRotation('BarrelRotator', BT);
	DesiredSpeed = MaxRotationSpeed;
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		Instigator.AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (class'BallisticReplicationInfo'.static.IsClassic() || CurrentWeaponMode != 0)
		return;

	if (FireMode[0].IsFiring() && !bServerReloading)
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.35*DT, GetRampUpSpeed() *DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-2.0*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			Instigator.AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		Instigator.AmbientSound = BarrelSpinSound;
		Instigator.SoundPitch = 32 + 96 * BarrelSpeed;
	}
}

simulated function float GetSecCharge()
{
	return SKASSecondaryFire(FireMode[1]).RailPower;
}

simulated function float ChargeBar()
{
	if (Heat + SKASSecondaryFire(Firemode[1]).RailPower > 0)
		return FMin((Heat + SKASSecondaryFire(Firemode[1]).RailPower), 1);
	
	if (class'BallisticReplicationInfo'.static.IsClassic())
		return 0;
	
    return BarrelSpeed / DesiredSpeed;
}

function ServerSwitchWeaponMode(byte NewMode)
{
	if (BarrelSpeed > 0)
		return;
		
	super.ServerSwitchWeaponMode(NewMode);
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SKASDrum';
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None )
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
		{
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(!bNonCocking) *  int(bMagPlusOne) * int(!bNeedCock));
		}
    }
    else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;
		
	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 400)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.1)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(B.Velocity) < 0.5))
		return 1;

	return Rand(2);
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
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.5;
	return AIController(Instigator.Controller).Skill / 7;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return -0.5;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = -1 * (B.Skill / 6);
	Result *= (1 - (Dist/4000));
    return FClamp(Result, -1.0, -0.3);
}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

simulated function Notify_ManualBrassOut()
{
	BFireMode[0].EjectBrass();
}

defaultproperties
{
	BarrelSpinSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelSpinLoop'
	BarrelStopSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStop'
	BarrelStartSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-BarrelStart'
	
	MaxRotationSpeed=1.00
    ManualLines(0)="Automatic fire has moderate spread, moderate damage, short range and fast fire rate.||Manual fire has tight spread, long range, good damage and low fire rate."
    ManualLines(1)="Multi-shot attack. Loads a shell into each of the barrels, then fires them all at once. Very high damage, short range and wide spread."
    ManualLines(2)="Extremely effective at close range."
    QuickCockSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Cock'
    UltraDrawSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-UltraDraw'
    CoolRate=0.700000
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BWBP_SKC_Tex.SKAS.BigIcon_SKAS'
    BigIconCoords=(Y1=24)
    
    bWT_Shotgun=True
    bWT_Machinegun=True
    SpecialInfo(0)=(Info="360.0;30.0;0.9;120.0;0.0;3.0;0.0")
    BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Select')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
    MagAmmo=24
    CockSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-CockLong',Volume=1.000000)
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipOut1',Volume=2.000000)
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipIn',Volume=2.000000)
    ClipInFrame=0.650000
    bCockOnEmpty=True
    NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc6',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,R=255,A=192),Color2=(B=0,G=0,R=255,A=98),StartSize1=113,StartSize2=120)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),SizeFactors=(X1=0.750000,X2=0.750000),MaxScale=8.000000)
	WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
    WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
    WeaponModes(2)=(ModeName="Semi-Auto",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
    WeaponModes(3)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
    WeaponModes(4)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
    CurrentWeaponMode=0
    GunLength=32.000000
    ParamsClasses(0)=Class'SKASWeaponParamsComp'
    ParamsClasses(1)=Class'SKASWeaponParamsClassic'
    ParamsClasses(2)=Class'SKASWeaponParamsRealistic'
    ParamsClasses(3)=Class'SKASWeaponParamsTactical'
    FireModeClass(0)=Class'BWBP_SKC_Pro.SKASPrimaryFire'
    FireModeClass(1)=Class'BWBP_SKC_Pro.SKASSecondaryFire'
    IdleAnimRate=0.100000
    PutDownTime=0.700000
    AIRating=0.850000
    CurrentRating=0.850000
    bShowChargingBar=True
    Description="SKAS-21 Super Shotgun||Manufacturer: UTC Defense Tech|Primary: Variable Fire Buckshot|Secondary: Tri-Barrel Blast||The SKAS-21 Super Assault Shotgun is a brand-new, state-of-the-art weapons system developed by UTC Defense Tech. It has been nicknamed 'The Decimator' for its ability to sweep entire streets clean of hostiles in seconds. Built to provide sustained suppressive fire, the fully automatic SKAS fires from an electrically assisted, rotating triple-barrel system. An electric motor housed in the stock operates various internal functions, making this gun one of the few gas-operated/Gatling hybrids. Non-ambidexterous models can disable this system for use with low-impulse ammunition, however use with standard ammunition is not recommended due to the resulting overpressurization. This heavy duty shotgun fires 10 gauge ammunition from a 18 round U drum by default, however 12 gauge (SKAS/M-21), grenade launching (SRAC/G-21), and box fed (SAS/CE-3) variants exist as well. Handle with care, as this is one expensive gun."
    Priority=245
    HudColor=(B=190,G=190,R=190)
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=7
    GroupOffset=4
    PickupClass=Class'BWBP_SKC_Pro.SKASPickup'

    PlayerViewOffset=(X=10.00,Y=5.00,Z=-4.50)
    SightOffset=(X=-22.50,Y=0.00,Z=8.80)
	SightPivot=(Pitch=1024)
	SightBobScale=0.75
	
    AttachmentClass=Class'BWBP_SKC_Pro.SKASAttachment'
    IconMaterial=Texture'BWBP_SKC_Tex.SKAS.SmallIcon_SKAS'
    IconCoords=(X2=127,Y2=30)
    ItemName="SKAS-21 Automatic Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_SKAS'
    DrawScale=0.30000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
