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
    InventorySize=35
    bLeftLoaded=True
    bRightLoaded=True
    TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M290'
    BigIconCoords=(Y1=40,X2=490,Y2=225)
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    bWT_Shotgun=True
    bWT_Super=True
    ManualLines(0)="Fires both barrels at once. Deals extreme damage at close to medium range. Spread is tight, recoil is high and fire rate is moderate."
    ManualLines(1)="Fires one barrel at a time. Deals high damage with tighter spread than primary. The interval between two successive shots is short, but the weapon must cock after the second shot, or it may be manually cocked."
    ManualLines(2)="The M290 is reloaded one shell at a time.||Penetration is very poor.||The M290 is extremely effective at close range and effective at medium range."
    SpecialInfo(0)=(Info="240.0;20.0;0.5;80.0;0.0;1.0;0.0")
    BringUpSound=(Sound=Sound'BallisticSounds2.M290.M290Pullout')
    PutDownSound=(Sound=Sound'BallisticSounds2.M290.M290Putaway')
    MagAmmo=6
    CockAnimRate=1.350000
    CockSound=(Sound=Sound'BallisticSounds2.M290.M290Cock')
    ReloadAnim="ReloadLoop"
    ReloadAnimRate=1.750000
    ClipInSound=(Sound=Sound'BallisticSounds2.M290.M290LoadShell')
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
    CurrentWeaponMode=0
    bNoCrosshairInScope=True
    SightPivot=(Pitch=256)
    SightOffset=(X=-50.000000,Y=-0.040000,Z=14.050000)
    SightingTime=0.300000
    SightAimFactor=0.350000
    SprintOffSet=(Pitch=-1000,Yaw=-2048)
    JumpChaos=1.000000
    ChaosDeclineTime=1.000000	 
     
    Begin Object Class=RecoilParams Name=M290RecoilParams
        ViewBindFactor=0.2
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.900000
        DeclineDelay=0.500000
    End Object
    RecoilParamsList(0)=RecoilParams'M290RecoilParams'
	 
    FireModeClass(0)=Class'BallisticProV55.M290PrimaryFire'
    FireModeClass(1)=Class'BallisticProV55.M290SecondaryFire'
    AIRating=0.900000
    CurrentRating=0.900000
    Description="Another sturdy weapon by Black & Wood, the M290 has proven it's worth many times in combat situations, especially against alien forces, most notably the Krao. One of its greatest feats was during the second Human-Skrith war, when a wounded Captain in the UTC 27th Special Ops division single handedly defended an outpost from six advancing Krao companies, using the weapon�s wide spread to his advantage."
    DisplayFOV=55.000000
    Priority=38
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=7
    GroupOffset=1
    PickupClass=Class'BallisticProV55.M290Pickup'
    PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-13.000000)
    AttachmentClass=Class'BallisticProV55.M290Attachment'
    IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M290'
    IconCoords=(X2=127,Y2=31)
    ItemName="M290 Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=150
    LightBrightness=180.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BallisticAnims2.M290Shotgun'
    DrawScale=0.280000
    Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
