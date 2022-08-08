//=============================================================================
// LAW rocket
//
// An extremely erratic and unpredictable rocket which nevertheless will blow the crap out of anything 
// it hits. Damages through walls and may be a dud.
//
// by Marc 'Sergeant Kelly' and moved off G5 code by Azarael
//=============================================================================
class LAWRocketHvy extends BallisticProjectile;

var() Sound FlySound;

var	vector		StrafeVelocity;
var	float		StrafeEndTime;

var    bool		bSideWinder;
var    int			RollRange;
var    int			ShockRadius;
var    float		ScrewRadius;

var    bool		bCrazy;

var()	float		DudChance;
var()	float		SideWinderChance;
var()	float		MaxStrafeSpeed;

var() int				ImpactDamage;			// Damage when hitting or sticking to players and not detonating
var() Class<DamageType>	ImpactDamageType;		// Type of Damage caused for striking or sticking to players

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor A;

	foreach RadiusActors( class 'Actor', A, ShockRadius, Location )
		if (A.bCanBeDamaged)
			class'BallisticDamageType'.static.Hurt(A, (1.0-(VSize(A.Location - Location)/ShockRadius))*45.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTLAWRadius');

	Super.Explode(HitLocation, HitNormal);
}

simulated event PostBeginPlay()
{
	local Rotator R;

	SetTimer(0.10, false);
	if (DudChance > FRand())
	{
		bCrazy = true;

		AccelSpeed = 6000 + Rand(2000);
		Speed += Rand(1000);
		MaxSpeed = 4000 + Rand(2000);



		RotationRate.Pitch = RollRange*(FRand()*2-1.0);
		RotationRate.Yaw = RollRange*(FRand()*2-1.0);
		RotationRate.Roll = RollRange*(FRand()*2-1.0);

		R.Yaw   = -4000 + Rand(8000);
		R.Pitch = -4000 + Rand(8000);
		SetRotation(R+Rotation);

		bSideWinder = true;
		ScrewRadius = ScrewRadius*4 + Rand(ScrewRadius*24);
	}
	else
	{
		RotationRate.Roll = RollRange*(FRand()*2-1.0);
		bSideWinder = true;
		ScrewRadius += Rand(ScrewRadius*3);
		AccelSpeed += Rand(1000);
		Speed += Rand(500);
		MaxSpeed += Rand(1000);
	}
	SetTimer(1.0 + FRand()*2.0, false);

	super.PostBeginPlay();

	if (FastTrace(Location + vector(rotation) * 3000, Location))
		PlaySound(FlySound, SLOT_Interact, 1.0, , 512, , false);

}

simulated event PostNetBeginPlay()
{
	local vector X,Y,Z;
	super.PostNetBeginPlay();

	GetAxes(Rotation, X,Y,Z);
//	StrafeVelocity = Y * (Rand(200)-100);
	StrafeVelocity = Y * (FRand()*2-1)*MaxStrafeSpeed;
	Velocity += StrafeVelocity;
	StrafeEndTime = level.TimeSeconds + FRand()*0.5;
	if (bCrazy)
		Velocity += vect(0,0,300);
}

simulated event Tick(float DT)
{
	local vector X,Y,Z, ScrewCenter;
	local Rotator R;

	if (bCrazy)
	{
		Acceleration = vsize(Acceleration) * vector(Rotation);
//		Velocity = vsize(velocity) * vector(rotation);
	}
	if (bSideWinder)
	{
		R = Rotation;
		R.Roll -= RotationRate.Roll * DT;
		GetAxes(R, X, Y, Z);
		ScrewCenter = Location + Y * ScrewRadius;

		GetAxes(Rotation, X, Y, Z);
		SetLocation(ScrewCenter - Y * ScrewRadius);
	}
	else if (StrafeEndTime != 0 && level.TimeSeconds >= StrafeEndTime)
	{
		StrafeEndTime = 0;
		Velocity -=	StrafeVelocity;

		AccelSpeed += 3000;
    	Acceleration = Vector(Rotation) * AccelSpeed;

//    	Speed += 1000;
  //  	Velocity += Vector(Rotation) * Speed;
	}
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	Explode(Location, HitNormal);
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		DoDamage(Other, HitLocation);
	}
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
	}
	else
	{	// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

defaultproperties
{
     AccelSpeed=500.000000
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     bDynamicLight=True
     bFixedRotationDir=True
     Damage=160.000000
     DamageRadius=1200.000000
     DrawScale=0.500000
     DudChance=0.010000
     FlySound=Sound'BWBP_SKC_Sounds.Flash.M202-FlyBy'
     ImpactDamage=85.000000
     ImpactDamageType=Class'BWBP_SKC_Pro.DTLAW'
     ImpactManager=Class'BWBP_SKC_Pro.IM_LAWSmall'
     LightBrightness=200.000000
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightRadius=15.000000
     LightSaturation=100
     LightType=LT_Steady
     MaxSpeed=14000.000000
     MaxStrafeSpeed=8.000000
     MomentumTransfer=300000.000000
     MotionBlurFactor=6.000000
     MotionBlurRadius=3536.000000
     MotionBlurTime=2.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTLAW'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTLAWRadius'
     RollRange=100000
     RotationRate=(Roll=32768)
     ScrewRadius=14.000000
     ShakeOffsetMag=(X=40.000000,Y=40.000000,Z=40.000000)
     ShakeOffsetRate=(X=650.000000,Y=650.000000,Z=650.000000)
     ShakeOffsetTime=10.000000
     ShakeRadius=5536.000000
     ShakeRotMag=(X=576.000000,Y=450.000000,Z=400.000000)
     ShakeRotRate=(X=7000.000000,Y=7000.000000,Z=5500.000000)
     ShakeRotTime=8.000000
     ShockRadius=2600.000000
     SideWinderChance=1.000000
     SoundRadius=128.000000
     SoundVolume=192
     Speed=6000.000000
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LAW.LAWRocket'
     TrailClass=Class'BWBP_SKC_Pro.LAWRocketTrail'
     TrailOffset=(X=-14.000000)
}
