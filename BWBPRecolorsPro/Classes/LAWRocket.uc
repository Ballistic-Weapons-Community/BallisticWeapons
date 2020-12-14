//=============================================================================
// LAW rocket
//
// An extremely erratic and unpredictable rocket which nevertheless will blow the crap out of anything 
// it hits.
//
// by Marc 'Sergeant Kelly' and moved off G5 code by Azarael
//=============================================================================
class LAWRocket extends BallisticProjectile;

var() Sound FlySound;

var	vector		StrafeVelocity;
var	float		StrafeEndTime;

var    int			RollRange;
var    int			ShockRadius;
var    float		ScrewRadius;

var()	float		MaxStrafeSpeed;

var() int				ImpactDamage;			// Damage when hitting or sticking to players and not detonating
var() Class<DamageType>	ImpactDamageType;		// Type of Damage caused for striking or sticking to players

simulated event PostBeginPlay()
{
	RotationRate.Roll = RollRange*(FRand()*2-1.0);

	super.PostBeginPlay();

	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);
}

simulated event PostNetBeginPlay()
{
	local vector X,Y,Z;
	super.PostNetBeginPlay();

	GetAxes(Rotation, X,Y,Z);
	StrafeVelocity = Y * (FRand()*2-1)*MaxStrafeSpeed;
	Velocity += StrafeVelocity;
	StrafeEndTime = level.TimeSeconds + FRand()*0.5;
}

simulated event Tick(float DT)
{
	if (StrafeEndTime != 0 && level.TimeSeconds >= StrafeEndTime)
	{
		StrafeEndTime = 0;
		Velocity -=	StrafeVelocity;

		AccelSpeed += 3000;
    	Acceleration = Vector(Rotation) * AccelSpeed;
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		DoDamage(Other, HitLocation);
	}

	Explode(HitLocation, vect(0,0,1));
}

defaultproperties
{
     FlySound=Sound'BWBP_SKC_SoundsExp.Flash.M202-Flyby'
     RollRange=100000
     ShockRadius=2600
     ScrewRadius=14.000000
     MaxStrafeSpeed=8.000000
     ImpactDamage=85
     ImpactDamageType=Class'BWBPRecolorsPro.DTLAW'
     ImpactManager=Class'BWBPRecolorsPro.IM_LAWSmall'
     bRandomStartRotaion=False
     AccelSpeed=4000.000000
     TrailClass=Class'BWBPRecolorsPro.LAWRocketTrail'
     TrailOffset=(X=-14.000000)
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTLAWRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=5536.000000
     MotionBlurRadius=3536.000000
     MotionBlurFactor=6.000000
     MotionBlurTime=2.000000
     ShakeRotMag=(X=576.000000,Y=450.000000,Z=400.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShakeOffsetMag=(X=40.000000,Y=40.000000,Z=40.000000)
     ShakeOffsetRate=(X=650.000000,Y=650.000000,Z=650.000000)
     ShakeOffsetTime=10.000000
     Speed=1000.000000
     MaxSpeed=30000.000000
     Damage=300.000000
     DamageRadius=1536.000000
     WallPenetrationForce=1024
     MomentumTransfer=300000.000000
     MyDamageType=Class'BWBPRecolorsPro.DTLAW'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.LAW.LAWRocket'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     DrawScale=0.500000
     SoundVolume=192
     SoundRadius=128.000000
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
