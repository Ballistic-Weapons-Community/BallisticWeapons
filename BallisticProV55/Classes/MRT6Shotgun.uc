//=============================================================================
// MRT6Shotgun.
//
// A very short, powerful and fast double barreled sidearm like shotgun. It has
// A very low range and ridiculous spread, but is devestaing very close up and
// reloads fast. Seondary fires only one barrel.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6Shotgun extends BallisticProShotgun;

var bool bLeftLoaded;
var bool bRightLoaded;

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_12GaugeClips';
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (0, 0.0, 'Shell');
	super.PlayReload();
}
/*
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	Else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}
*/
/*
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0)
		CommonCockGun();
}
*/
simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
//	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0 &&
//		(OtherGun == None || !CanAlternate(0) || OtherGun.bNeedCock) )
	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0 )
		CommonCockGun();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (0, 1.0, 'Shell');
}

simulated function CommonCockGun(optional byte Type)
{
	super.CommonCockGun(Type);
	bLeftLoaded=true;
	bRightLoaded=true;
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

	if (Dist > 700)
		return 1;
	else if (Dist < 300)
		return 0;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticProShotgunFire(BFireMode[0]).CutOffStartRange, BallisticProShotgunFire(BFireMode[0]).CutOffDistance); 
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

defaultproperties
{
    AIRating=0.7
    CurrentRating=0.7
    ManualLines(0)="Fires both barrels. Wide spread and good damage, but requires cocking after every shot."
    ManualLines(1)="Fires one barrel at a time."
    ManualLines(2)="Effective at very close range. Spreads less from the hip than other shotguns."
    AimDisplacementDurationMult=0.33
    bLeftLoaded=True
    bRightLoaded=True
    TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
    TeamSkins(1)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny',SkinNum=3)
    BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_MRT6'
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    InventorySize=5
    bWT_Shotgun=True
    bWT_Sidearm=True
    SpecialInfo(0)=(Info="180.0;10.0;-999.0;25.0;0.0;0.8;-999.0")
    BringUpSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6Pullout')
    PutDownSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6Putaway')
    MagAmmo=8
    CockSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6Cock')
    ClipHitSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6ClipHit')
    ClipOutSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6ClipOut')
    ClipInSound=(Sound=Sound'BallisticSounds2.MRT6.MRT6ClipIn')
    bCockOnEmpty=True
    bAltTriggerReload=True
    WeaponModes(0)=(ModeName="Single Fire")
    WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
    CurrentWeaponMode=0
    SightPivot=(Pitch=768)
    SightOffset=(X=-30.000000,Z=11.000000)
    SightingTime=0.250000
    SightZoomFactor=0.85
    GunLength=24.000000
    JumpChaos=1.000000
    AimSpread=0
    ChaosDeclineTime=0.320000
    ChaosAimSpread=0

    Begin Object Class=RecoilParams Name=MRT6RecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.200000
        DeclineTime=0.700000
    End Object
    RecoilParamsList(0)=RecoilParams'MRT6RecoilParams'

    FireModeClass(0)=Class'BallisticProV55.MRT6PrimaryFire'
    FireModeClass(1)=Class'BallisticProV55.MRT6SecondaryFire'
    Description="MRT6 Shotgun Sidearm||Manufacturer: Wot ya Packin Gun Corp|Primary: Dual Barrel Shot|Secondary: Single Barrel Shot"
    Priority=35
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=2
    GroupOffset=9
    PickupClass=Class'BallisticProV55.MRT6Pickup'
    PlayerViewOffset=(X=12.000000,Y=8.000000,Z=-8.500000)
    AttachmentClass=Class'BallisticProV55.MRT6Attachment'
    IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_MRT6'
    IconCoords=(X2=127,Y2=31)
    ItemName="MRT-6 Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=130
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BallisticAnims2.MRT6Shotgun'
    DrawScale=0.300000
    Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
    Skins(1)=Texture'BallisticWeapons2.MRT6.MRT6Skin'
    Skins(2)=Texture'BallisticWeapons2.MRT6.MRT6Small'
    Skins(3)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
