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

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticRecolors3TexPro.SK410.BigIcon_SK410'
     BigIconCoords=(Y1=40)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     bWT_Machinegun=True
     ManualLines(0)="Fires shotgun blasts with wide spread. These blasts inflict heavy damage and knock the enemy back."
     ManualLines(1)="Fires an explosive slug. Deals good impact damage and minor radius damage. Targets hit will be knocked back a significant distance."
     ManualLines(2)="Has a melee attack. Damage improves over hold time, with a max bonus being reached at 1.5 seconds of holding. As a blunt attack, has lower damage than sharp melee attacks but inflicts a minor blind effect upon striking. Deals more damage from behind.||Extremely effective at close range and against charges and melee."
     SpecialInfo(0)=(Info="300.0;30.0;0.5;60.0;0.0;1.0;0.0")
     MeleeFireClass=Class'BWBPRecolorsPro.SK410MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
     MagAmmo=6
     CockAnimRate=1.250000
     CockSound=(Sound=Sound'PackageSounds4Pro.SK410.SK410-Cock',Volume=1.400000)
     ReloadAnimRate=1.250000
     ClipOutSound=(Sound=Sound'PackageSounds4Pro.SK410.SK410-MagOut',Volume=1.300000)
     ClipInSound=(Sound=Sound'PackageSounds4Pro.SK410.SK410-MagIn',Volume=1.300000)
     WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Automatic Slug",bUnavailable=True,ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="0451-EXECUTE",bUnavailable=True)
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     bNoCrosshairInScope=True
     SightPivot=(Pitch=150)
     SightOffset=(X=15.000000,Y=-10.000000,Z=22.500000)
	 SightDisplayFOV=40
     SightingTime=0.250000
	 SightZoomFactor=0
     GunLength=48.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=0
     ChaosAimSpread=0
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.070000),(InVal=0.300000,OutVal=-0.150000),(InVal=0.500000,OutVal=0.050000),(InVal=0.750000,OutVal=0.120000),(InVal=1.000000,OutVal=-0.050000)))
     RecoilYCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
     RecoilYFactor=0.750000
     RecoilMinRandFactor=0.250000
     RecoilMax=8192.000000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.750000
     FireModeClass(0)=Class'BWBPRecolorsPro.SK410PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.SK410SecondaryFire'
     SelectAnimRate=1.600000
     PutDownAnimRate=1.600000
     PutDownTime=0.350000
     BringUpTime=0.600000
     AIRating=0.850000
     CurrentRating=0.850000
     Description="The SK-410 shotgun is a large-bore, compact shotgun based off the popular AK-490 design. While it is illegal on several major planets, this powerful weapon and its signature explosive shotgun shells are almost ubiquitous. A weapon originally designed for breaching use, the SK-410 is now found in the hands of civillians and terrorists throughout the worlds. It had become so prolific with outer colony terrorist groups that the UTC began the SKAS assault weapon program in an effort to find a powerful shotgun of their own."
     Priority=245
     HudColor=(G=25)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=7
     PickupClass=Class'BWBPRecolorsPro.SK410Pickup'
     PlayerViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
     AttachmentClass=Class'BWBPRecolorsPro.SK410Attachment'
     IconMaterial=Texture'BallisticRecolors3TexPro.SK410.SmallIcon_SK410'
     IconCoords=(X2=127,Y2=35)
     ItemName="SK-410 Assault Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.SK410_FP'
     DrawScale=0.350000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Texture'BallisticRecolors3TexPro.SK410.SK410-C-CamoSnow'
     Skins(2)=Texture'BallisticRecolors3TexPro.SK410.SK410-Misc'
     Skins(3)=Shader'BallisticRecolors3TexPro.SK410.SK410-LightsOn'
}
