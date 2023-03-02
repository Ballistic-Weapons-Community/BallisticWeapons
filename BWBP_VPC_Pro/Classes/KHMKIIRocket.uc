//=============================================================================
// The TOW missile barrage projectile for the KH MarkII Cobra.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class KHMKIIRocket extends Projectile
	placeable
	config(BWBP_VPC_Pro);

var 			Actor 						HomingTarget;
var 			vector 						InitialDir;
var(Rocket) 	config float 				AccelerationAddPerSec; // How much speed is added to the rocket every second.
var 			float 						LeadTargetDelay;
var 			float 						LeadTargetStartTime;
var 			Emitter						SmokeTrailEffect;
var 			Effects						Corona;
var(Effects) 	class<Emitter>				SmokeTrailClass;
var(Effects) 	class<Effects>				CoronaClass;
var(Effects) 	class<Emitter>				ExplosionEffect;
var(Effects) 	sound						ExplosionSound;
var(Effects)	float						ExplosionSoundVolume;
var(Effects)	float						ExplosionSoundRadius;
var(Effects)	float						ExplosionSoundPitch;

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        InitialDir, HomingTarget;
}
// Destroys the trail effects, and the Corona behind the rocket.
simulated function Destroyed()
{
	if ( SmokeTrailEffect != None )
		SmokeTrailEffect.Kill();
	if ( Corona != None )
		Corona.Destroy();
	Super.Destroyed();
}
// Sets some stuff when it spawns, like it's trail and corona classes.
simulated function PostBeginPlay()
{
	local vector Dir;

	if (Level.NetMode != NM_DedicatedServer)
	{
		SmokeTrailEffect = Spawn(SmokeTrailClass,self);
		Corona = Spawn(CoronaClass,self);
		Corona.SetDrawScale(4.5 * Corona.default.DrawScale);
	}

	InitialDir = vector(Rotation);
	Velocity = InitialDir * Speed;

	if (PhysicsVolume.bWaterVolume)
		Velocity = 0.6 * Velocity;

	SetTimer(0.1, true);

	Dir = vector(Rotation);

	Velocity = speed * Dir;
	Acceleration = Dir;	//really small accel just to give it a direction for use later
	if (PhysicsVolume.bWaterVolume)
		Velocity=0.6*Velocity;
	if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}

	SetTimer(0.1, true);
	LeadTargetStartTime = Level.TimeSeconds + LeadTargetDelay;

	Super.PostBeginPlay();
}

simulated function Timer()
{
	local float VelMag;
	local vector ForceDir;

	if (HomingTarget == None)
		return;

	ForceDir = Normal(HomingTarget.Location - Location);
	if (ForceDir dot InitialDir > 0)
	{
	    	// Do normal guidance to target.
	    	VelMag = VSize(Velocity);

	    	ForceDir = Normal(ForceDir * 0.75 * VelMag + Velocity);
		Velocity =  VelMag * ForceDir;
    		Acceleration = 5 * ForceDir;

	    	// Update rocket so it faces in the direction its going.
		SetRotation(rotator(Velocity));
	}
}
// Activates the function two rows down, when it impacts with something.
simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
	{
		Explode(HitLocation, vect(0,0,1));
	}
}
// This does the damage and splash radius.
function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}
// Spawns the effects and activates the 'BlowUp' function when activated.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local PlayerController PC;

	PlaySound(ExplosionSound,,ExplosionSoundVolume,,ExplosionSoundRadius, ExplosionSoundPitch);

    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'NewExplosionA',,,HitLocation + HitNormal*20,rotator(HitNormal));
    	PC = Level.GetLocalPlayerController();
		if ( (PC.ViewTarget != None) && VSize(PC.ViewTarget.Location - Location) > 0 )
    		Spawn(ExplosionEffect,,, HitLocation + HitNormal*32, rotator(HitNormal) + rot(-16384,0,0));
    }

	BlowUp(HitLocation);
	Destroy();
}
// Increases the speed of the missile gradually.
simulated function Tick(float deltaTime)
{
	if (VSize(Velocity) >= MaxSpeed)
	{
		Acceleration = vect(0,0,0);
		disable('Tick');
	}
	else
		Acceleration += Normal(Velocity) * (AccelerationAddPerSec * deltaTime);
}
// If it is damaged it will activate the 'Explode' function.
function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	if (Damage > 0)
		Explode(HitLocation, vect(0,0,0));
}

defaultproperties
{
     AccelerationAddPerSec=1250.000000
     SmokeTrailClass=Class'BWBP_VPC_Pro.KHMKIIRocketTrail'
     CoronaClass=Class'BWBP_VPC_Pro.KHMKIIRocketFlare'
     ExplosionEffect=Class'BWBP_VPC_Pro.RocketExplosionEffect'
     ExplosionSound=SoundGroup'BWBP_Vehicles_Sound.Effects.ExplosionsSmall'
     ExplosionSoundVolume=2.000000
     ExplosionSoundRadius=900.000000
     ExplosionSoundPitch=1.000000
     Speed=500.000000
     MaxSpeed=6500.000000
     Damage=85.000000
     DamageRadius=900.000000
     MomentumTransfer=30000.000000
     MyDamageType=Class'BWBP_VPC_Pro.KHMKIIDamTypeBarrage'
     ExplosionDecal=Class'BWBP_VPC_Pro.ExplosionDecal'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BWBP_Vehicles_Static.Effects.Missile'
     CullDistance=3000.000000
     bDynamicLight=True
     AmbientSound=Sound'BWBP_Vehicles_Sound.Effects.MissileFly'
     LifeSpan=6.000000
     FluidSurfaceShootStrengthMod=0.000000
     bFullVolume=True
     bHardAttach=True
     SoundVolume=128
     SoundRadius=1000.000000
     CollisionRadius=16.000000
     bFixedRotationDir=True
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=900000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
