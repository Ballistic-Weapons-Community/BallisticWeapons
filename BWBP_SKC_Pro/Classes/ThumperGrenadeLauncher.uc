//=============================================================================
// A500Reptile.
//
// An alien acid weapon that fires corrosive projectiles that do extra damage to enemy armor.
// It also fires a large blob of residual corrosive acid.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperGrenadeLauncher extends BallisticWeapon;

exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	GunLength = default.GunLength;
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
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

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	if (Dist > 2048 || Rand(100) < 10)
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

	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 1536, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{ return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

simulated function float ChargeBar()
{
	return BFireMode[1].HoldTime / BFireMode[1].MaxHoldTime;
}

defaultproperties
{
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BWBP_SKC_Tex.Thumper.BigIcon_Thumper'
	BigIconCoords=(Y1=30,Y2=230)
	bWT_Hazardous=True
	bWT_Projectile=True
	SpecialInfo(0)=(Info="210.0;30.0;0.95;80.0;0.0;0.8;0.8")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Putaway')
	MagAmmo=5
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Cock')
    ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagIn')
    ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagOut')
    ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagHit')lipInFrame=0.700000
	WeaponModes(0)=(ModeName="Blast")
	WeaponModes(1)=(bUnavailable=True,Value=4.000000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	GunLength=48.000000
	ParamsClasses(0)=Class'ThumperGrenadeLauncherWeaponParamsArena'
	ParamsClasses(1)=Class'ThumperGrenadeLauncherWeaponParamsClassic'
	ParamsClasses(2)=Class'ThumperGrenadeLauncherWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKC_Pro.ThumperPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.ThumperSecondaryFire'
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=61,G=60,R=58,A=255),Color2=(B=0,G=0,R=0,A=255),StartSize1=73,StartSize2=114)
	BringUpTime=0.950000
	PutDownTime=0.800000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Whatever the west has for their armaments, be it rifles or explosive ordinance, ZTV Exports refuses to be outclassed.  Their latest weapon to come off the assembly line is the LRGh-90 ''Topor'' Grenade Launcher, based off an old prototype that never saw the light of day until now. Firing either concussion or smoke 35mm caseless grenades in a bullpup configuration, the Topor may not look like it's ergo-friendly, but more than makes up for its versatility and ruggedness, living up to the legend that ZTV weapons can never malfunction, no matter the environment.  ZTV projects that the ''Thumper''  will be able to outshine their competitors with their newest offering, and given how the PKMA and AK-490 are doing, it could be another home run."
	Priority=39
	HudColor=(G=200,R=150)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_SKC_Pro.ThumperPickup'

	PlayerViewOffset=(X=30.000000,Y=15.000000,Z=-20.000000)
	PlayerViewPivot=(Pitch=600)
	SightOffset=(X=-30.000000,Y=-0.030000,Z=34.000000)
	SightPivot=(Pitch=-550)
	
	AttachmentClass=Class'BWBP_SKC_Pro.ThumperAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Thumper.SmallIcon_Thumper'
	IconCoords=(X2=127,Y2=31)
	ItemName="LRGh-90 'Topor' Grenade Launcher"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=54
	LightSaturation=100
	LightBrightness=150.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Thumper'
	DrawScale=0.600000
	SoundPitch=56
	SoundRadius=32.000000
}
