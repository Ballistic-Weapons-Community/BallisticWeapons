//=============================================================================
// X007Projectile.
//
// An electrical bolt
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mk781PulseProjectile extends BallisticProjectile;

var() Sound FlySound;

var int ImpactDamage;

simulated function PostBeginPlay()
{
	SetTimer(0.15, false);
	super.PostBeginPlay();
	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, None);
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

simulated event Tick(float DT)
{
	local Rotator R;

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);
}
// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner || ( vehicle(Instigator)!=None&&Other==Vehicle(Instigator).Driver ) )))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);

	// Spawn projectile death effects and try radius damage
	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

defaultproperties
{
     ImpactDamage=100
     ImpactManager=Class'BWBPRecolorsPro.IM_EMPRocketAlt'
     bCheckHitSurface=True
     bRandomStartRotaion=False
     AccelSpeed=50000.000000
     TrailClass=Class'Onslaught.ONSBluePlasmaSmallFireEffect'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_Mk781Bolt'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=200.000000
     Speed=2500.000000
     MaxSpeed=5000.000000
     Damage=100.000000
     DamageRadius=256.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_Mk781Bolt'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkProjBig'
     AmbientSound=Sound'WeaponSounds.ShockRifle.ShockRifleProjectile'
     LifeSpan=16.000000
     Skins(0)=FinalBlend'BallisticRecolors3TexPro.LS14.EMPProjFB'
     Skins(1)=FinalBlend'BallisticRecolors3TexPro.LS14.EMPProjFB'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
