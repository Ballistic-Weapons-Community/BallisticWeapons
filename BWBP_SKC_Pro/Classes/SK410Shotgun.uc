//=============================================================================
// SK410Shotgun.
//
// The SK410 auto shottie, aka the LASERLASER
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SK410Shotgun extends BallisticProShotgun;

var name			BulletBone;

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		SetBoneScale(0,0.0,BulletBone);
		ReloadAnim = 'ReloadEmpty';
	}
	else
		ReloadAnim = 'Reload';

	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;
}

simulated function PlayReload()
{
    if (MagAmmo < 1)
       ReloadAnim='ReloadEmpty';
    else
       ReloadAnim='Reload';

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(0,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
		SetBoneScale(0,0.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
			SetBoneScale(0,0.0,BulletBone);
	}
	super.AnimEnd(Channel);
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

	if (Dist > 1024 || B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		return 1;
		
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

simulated function Notify_BrassOut();

defaultproperties
{
    BulletBone="Bullet1"
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    BigIconMaterial=Texture'BWBP_SKC_Tex.SK410.BigIcon_SK410'
    BigIconCoords=(Y1=40)
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    bWT_Shotgun=True
    bWT_Machinegun=True
    ManualLines(0)="Rapid fire shotgun blasts with wide spread. Short range, but high sustained damage output."
    ManualLines(1)="Fires an explosive slug. Deals good impact damage and minor radius damage. Targets hit will be knocked back a significant distance."
    ManualLines(2)="Has a melee attack. Damage improves over hold time, with a max bonus being reached at 1.5 seconds of holding. As a blunt attack, has lower damage than sharp melee attacks but inflicts a minor blind effect upon striking. Deals more damage from behind.||Extremely effective at close range and against charges and melee."
    SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
    MeleeFireClass=Class'BWBP_SKC_Pro.SK410MeleeFire'
    BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
    CockAnimRate=1.250000
    CockSound=(Sound=Sound'BWBP_SKC_Sounds.SK410.SK410-Cock',Volume=1.400000)
    ReloadAnimRate=1.250000
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.SK410.SK410-MagOut',Volume=1.300000)
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.SK410.SK410-MagIn',Volume=1.300000)
    WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
    WeaponModes(1)=(ModeName="Automatic Slug",bUnavailable=True,ModeID="WM_FullAuto")
    WeaponModes(2)=(ModeName="0451-EXECUTE",bUnavailable=True)
    CurrentWeaponMode=0
    bNoCrosshairInScope=True
    SightPivot=(Pitch=150)
    SightOffset=(X=20.000000,Y=-10.000000,Z=22.500000)
    SightDisplayFOV=30
    GunLength=48.000000
    NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M763OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M763InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,A=192),Color2=(G=0,A=192),StartSize1=113,StartSize2=120)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),SizeFactors=(X1=0.750000,X2=0.750000),MaxScale=8.000000)
    ParamsClasses(0)=Class'SK410WeaponParams'
    ParamsClasses(1)=Class'SK410WeaponParamsClassic'
    ParamsClasses(2)=Class'SK410WeaponParamsRealistic'
    ParamsClasses(3)=Class'SK410WeaponParamsTactical'
    FireModeClass(0)=Class'BWBP_SKC_Pro.SK410PrimaryFire'
    FireModeClass(1)=Class'BWBP_SKC_Pro.SK410SecondaryFire'
    SelectAnimRate=1.600000
    PutDownAnimRate=1.600000
    PutDownTime=0.350000
    BringUpTime=0.600000
	CockingBringUpTime=2.000000
    AIRating=0.850000
    CurrentRating=0.850000
    Description="The SK-410 shotgun is a large-bore, compact shotgun based off the popular AK-490 design. While it is illegal on several major planets, this powerful weapon and its signature explosive shotgun shells are almost ubiquitous. A weapon originally designed for breaching use, the SK-410 is now found in the hands of civillians and terrorists throughout the worlds. It had become so prolific with outer colony terrorist groups that the UTC began the SKAS assault weapon program in an effort to find a powerful shotgun of their own."
    Priority=245
    HudColor=(G=25)
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=7
    GroupOffset=7
    PickupClass=Class'BWBP_SKC_Pro.SK410Pickup'
    PlayerViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
    AttachmentClass=Class'BWBP_SKC_Pro.SK410Attachment'
    IconMaterial=Texture'BWBP_SKC_Tex.SK410.SmallIcon_SK410'
    IconCoords=(X2=127,Y2=35)
    ItemName="SK-410 Assault Shotgun"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=25
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=5.000000
    Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_SK410'
    DrawScale=0.350000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Texture'BWBP_SKC_Tex.SK410.SK410-C-CamoSnow'
    Skins(2)=Texture'BWBP_SKC_Tex.SK410.SK410-Misc'
    Skins(3)=Shader'BWBP_SKC_Tex.SK410.SK410-LightsOn'
}
