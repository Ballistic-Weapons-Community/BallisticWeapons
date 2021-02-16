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

var() sound      	QuickCockSound;
var() sound		UltraDrawSound;       	//56k MODEM ACTION.

var()     float Heat;
var()     float CoolRate;

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
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
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
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
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

simulated function float ChargeBar()
{
    return FMin((Heat + SKASSecondaryFire(Firemode[1]).RailPower), 1);
}

simulated event WeaponTick(float DT)
{
	Heat = FMax(0, Heat - CoolRate*DT);
	super.WeaponTick(DT);
}

defaultproperties
{
    ManualLines(0)="Automatic fire has moderate spread, moderate damage, short range and fast fire rate.||Manual fire has tight spread, long range, good damage and low fire rate."
    ManualLines(1)="Multi-shot attack. Loads a shell into each of the barrels, then fires them all at once. Very high damage, short range and wide spread."
    ManualLines(2)="Extremely effective at close range."
    QuickCockSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Cock'
    UltraDrawSound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-UltraDraw'
    CoolRate=0.700000
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=2)
    TeamSkins(1)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=3)
    BigIconMaterial=Texture'BWBP_SKC_Tex.SKAS.BigIcon_SKAS'
    BigIconCoords=(Y1=24)
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    bWT_Shotgun=True
    bWT_Machinegun=True
    SpecialInfo(0)=(Info="360.0;30.0;0.9;120.0;0.0;3.0;0.0")
    BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Select')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
    MagAmmo=24
    CockAnimRate=1.250000
    CockSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-CockLong',Volume=1.000000)
    ReloadAnimRate=1.550000
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipOut1',Volume=2.000000)
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-ClipIn',Volume=2.000000)
    ClipInFrame=0.650000
    bCockOnEmpty=True
    WeaponModes(0)=(ModeName="Semi-Automatic",bUnavailable=True)
    WeaponModes(1)=(ModeName="Automatic",ModeID="WM_FullAuto")
    WeaponModes(2)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
    WeaponModes(3)=(ModeName="Semi-Auto",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
    WeaponModes(4)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
    WeaponModes(5)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
    CurrentWeaponMode=1
    SightPivot=(Pitch=1024)
    SightOffset=(X=-20.000000,Y=9.700000,Z=19.000000)
    GunLength=32.000000
    ParamsClasses(0)=Class'SKASWeaponParams'
    FireModeClass(0)=Class'BWBPRecolorsPro.SKASPrimaryFire'
    FireModeClass(1)=Class'BWBPRecolorsPro.SKASSecondaryFire'
    IdleAnimRate=0.100000
    PutDownTime=0.700000
    AIRating=0.850000
    CurrentRating=0.850000
    bShowChargingBar=True
    Description="SKAS-21 Super Shotgun||Manufacturer: UTC Defense Tech|Primary: Variable Fire Buckshot|Secondary: Tri-Barrel Blast"
    Priority=245
    HudColor=(B=190,G=190,R=190)
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=7
    GroupOffset=4
    PickupClass=Class'BWBPRecolorsPro.SKASPickup'
    PlayerViewOffset=(X=-4.000000,Y=1.000000,Z=-10.000000)
    AttachmentClass=Class'BWBPRecolorsPro.SKASAttachment'
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
    DrawScale=0.260000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}
