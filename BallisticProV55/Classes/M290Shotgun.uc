//=============================================================================
// M290Shotgun.
//
// Big double barreled shotgun. Primary fires both barrels at once, secondary
// fires them seperately. Slower than M763 with less range and uses up ammo
// quicker, but has tons of damage at close range.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M290Shotgun extends BallisticProShotgun;

var bool bLeftLoaded;
var bool bRightLoaded;

simulated function PlayShovelEnd()
{
	PlayAnim(EndShovelAnim, EndShovelAnimRate, 0.0);
}

simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	if ((!bRightLoaded || (bRightLoaded && bLeftLoaded)) && bNeedCock && MagAmmo > 0)
		CommonCockGun();
}

simulated function CommonCockGun(optional byte Type)
{
	super.CommonCockGun(Type);
	if (MagAmmo > 1)
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
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
    bLeftLoaded=True
    bRightLoaded=True
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_M290'
    BigIconCoords=(Y1=40,X2=490,Y2=225)
    
    bWT_Shotgun=True
    ManualLines(0)="Fires both barrels at once. Deals extreme damage at close to medium range. Spread is tight, recoil is high and fire rate is moderate."
    ManualLines(1)="Fires one barrel at a time. Deals high damage with tighter spread than primary. The interval between two successive shots is short, but the weapon must cock after the second shot, or it may be manually cocked."
    ManualLines(2)="The M290 is reloaded one shell at a time.||Penetration is very poor.||The M290 is extremely effective at close range and effective at medium range."
    SpecialInfo(0)=(Info="240.0;20.0;0.5;80.0;0.0;1.0;0.0")
    BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Pullout')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Putaway')
    CockAnimRate=1.350000
    CockSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Cock')
    ReloadAnim="ReloadLoop"
    ReloadAnimRate=1.750000
    ClipInSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290LoadShell')
    bCockOnEmpty=True
    bCanSkipReload=True
    bAltTriggerReload=True
    bShovelLoad=True
    StartShovelAnim="PrepReload"
    StartShovelAnimRate=1.900000
    EndShovelAnim="FinishReload"
    EndShovelAnimRate=1.500000
    WeaponModes(0)=(ModeName="Single Fire")
    WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(bUnavailable=True)
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(R=0,A=192),Color2=(A=223),StartSize1=186,StartSize2=152)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.600000
	
    CurrentWeaponMode=0
    bNoCrosshairInScope=True


    ParamsClasses(0)=Class'M290WeaponParamsComp'
    ParamsClasses(1)=Class'M290WeaponParamsClassic'
    ParamsClasses(2)=Class'M290WeaponParamsRealistic'
    ParamsClasses(3)=Class'M290WeaponParamsTactical'
    FireModeClass(0)=Class'BallisticProV55.M290PrimaryFire'
    FireModeClass(1)=Class'BallisticProV55.M290SecondaryFire'
    AIRating=0.900000
    CurrentRating=0.900000
    Description="Another sturdy weapon by Black & Wood, the M290 has proven it's worth many times in combat situations, especially against alien forces, most notably the Krao. One of its greatest feats was during the second Human-Skrith war, when a wounded Captain in the UTC 27th Special Ops division single handedly defended an outpost from six advancing Krao companies, using the weapon�s wide spread to his advantage."
    Priority=38
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=7
    GroupOffset=1
    PickupClass=Class'BallisticProV55.M290Pickup'
    PlayerViewOffset=(X=6.5,Y=9.6,Z=-13.5)
	SightOffset=(X=-7.5,Y=-0.04,Z=6)
	SightPivot=(Pitch=256)
	SightBobScale=0.75
    AttachmentClass=Class'BallisticProV55.M290Attachment'
    IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_M290'
    IconCoords=(X2=127,Y2=31)
    ItemName="M290 Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=150
    LightBrightness=180.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M290'
    DrawScale=0.3
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	SightAnimScale=0.5
}
