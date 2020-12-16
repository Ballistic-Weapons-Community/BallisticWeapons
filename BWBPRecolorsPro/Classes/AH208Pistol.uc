//=============================================================================
// AH208Pistol.
//
// A powerful sidearm designed for long range combat. The .44 bulelts are very
// deadly. Secondary is a pistol whip.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH208Pistol extends BallisticWeapon;

var(AH208Pistol) name		RDSBone;			// Bone to use for hiding Red Dot Sight
var(AH208Pistol) name		MuzzBone;			// Bone to use for hiding Compensator
var(AH208Pistol) name		LAMBone;			// Bone to use for hiding LAM
var(AH208Pistol) name		ScopeBone;			// Bone to use for hiding scope
var(AH208Pistol) name		BulletBone;			// Bone to use for hiding bullet

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, ScopeBone);
	SetBoneScale (3, 0.0, MuzzBone);
	SetBoneScale (5, 0.0, LAMBone);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'OpenPullout';
		BringUpTime=default.BringUpTime;
		SetBoneScale(4,0.0,BulletBone);
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		BringUpTime=default.BringUpTime;
	}

	Super.BringUp(PrevWeapon);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSim()
{
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale(4,0.0,BulletBone);
}


simulated function Notify_ShowBullet()
{
	SetBoneScale(4,1.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == 'OpenFire' || Anim == 'OpenSightFire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			PutDownAnim = 'OpenPutaway';
			SelectAnim = 'OpenPullout';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
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
function byte BestMode()	{	return 0;	}


function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
    RDSBone="RedDotSight"
    MuzzBone="Compensator"
    LAMBone="LAM"
    ScopeBone="Scope"
    BulletBone="Bullet"
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
    AIReloadTime=1.500000
    BigIconMaterial=Texture'BWBP_SKC_Tex.Eagle.BigIcon_EagleGold'
    BigIconCoords=(X1=47,Y1=16,X2=455,Y2=245)
    BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
    bWT_Bullet=True
    ManualLines(0)="Powerful .44 fire. Massive damage, long range and excellent fire rate."
    ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
    ManualLines(2)="Effective at all ranges."
    SpecialInfo(0)=(Info="140.0;12.0;0.7;70.0;0.55;0.0;-999.0")
    BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
    PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
    CockSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Cock',Volume=5.100000,Radius=32.000000)
    ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipHit',Volume=2.500000,Radius=32.000000)
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipOut',Volume=2.500000,Radius=32.000000)
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipIn',Volume=2.500000,Radius=32.000000)
    ClipInFrame=0.650000
    WeaponModes(0)=(ModeName="Semi-Automatic")
    WeaponModes(1)=(ModeName="Mode-2",bUnavailable=True,Value=7.000000)
    WeaponModes(2)=(bUnavailable=True)
    CurrentWeaponMode=0
    bNoCrosshairInScope=True
    SightOffset=(X=20.000000,Y=-7.350000,Z=45.400002)
    SightDisplayFOV=40.000000
    GunLength=4.000000
    ParamsClass=Class'AH208WeaponParams'
    FireModeClass(0)=Class'BWBPRecolorsPro.AH208PrimaryFire'
    FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
    MeleeFireClass=Class'BWBPRecolorsPro.AH208MeleeFire'
    SelectAnimRate=2.000000
    PutDownAnimRate=1.600000
    PutDownTime=0.500000
    BringUpTime=0.600000
    SelectForce="SwitchToAssaultRifle"
    Description="Built as a more affordable alternative to the AH104, the AH208 is an alternate design chambered for .44 magnum rounds instead of the usual $100 .600 HEAP ones. It is less accurate than the AH104 and D49, but its 8 round magazine and faster reload times let it put more rounds down range than both. Its significant weight and recoil means it requires both hands to shoot and is harder to control than its revolver and handcannon siblings, a fact that comes into play where range is a concern. While not as popular as its larger .600 cousin, the AH208 packs a formidable punch and is a force to be reckoned with."
    Priority=96
    HudColor=(G=217)
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=2
    GroupOffset=14
    PickupClass=Class'BWBPRecolorsPro.AH208Pickup'
	PlayerViewOffset=(X=15,Y=12,Z=-37)
    BobDamping=1.200000
    AttachmentClass=Class'BWBPRecolorsPro.AH208Attachment'
    IconMaterial=Texture'BWBP_SKC_Tex.Eagle.SmallIcon_EagleGold'
    IconCoords=(X2=127,Y2=31)
    ItemName="AH208 Golden Pistol"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=30
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=4.000000
    Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AHDeagle'
    DrawScale=0.800000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Shader'BWBP_SKC_Tex.Eagle.Eagle-GoldShine'
    Skins(2)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack'
    Skins(3)=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeGold'
    Skins(4)=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontBlack'
    Skins(5)=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen'
}
