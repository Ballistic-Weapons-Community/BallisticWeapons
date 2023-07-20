//=============================================================================
// The Shell fired from the Leopard TM V.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class LeopardShell extends Projectile
	placeable;

var 			Emitter 					SmokeTrailEffect;
var 			bool 						bHitWater;
var 			Effects 					Corona;
var 			vector 						Dir;
var(Effects) 	class<Emitter>				ExplosionEffect;
var(Effects) 	class<Emitter>				SmokeTrailClass;
var(Effects) 	class<Effects>				CoronaClass;
var(Effects)  	sound           			ExplosionSound;
var(Effects)	float						ExplosionSoundVolume;
var(Effects)	float						ExplosionSoundRadius;
var(Effects)	float						ExplosionSoundPitch;

simulated function Destroyed()
{
	if ( SmokeTrailEffect != None )
		SmokeTrailEffect.Kill();
	if ( Corona != None )
		Corona.Destroy();
	Super.Destroyed();
}

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        SmokeTrailEffect = Spawn(SmokeTrailClass,self);
		Corona = Spawn(CoronaClass,self);
	}

	Dir = vector(Rotation);
	Velocity = speed * Dir;
	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}
    if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	Super.PostBeginPlay();
}
/*
simulated function Tick(float DeltaTime)
{
    Super.Tick(DeltaTime);

	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity = (speed * 0.6) * Dir;
	}
	else if (PhysicsVolume == None || !PhysicsVolume.bWaterVolume)
	{
		bHitWater = false;
		Velocity = speed * Dir;
	}
}
*/
simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
		Explode(HitLocation,Vect(0,0,1));
}

function BlowUp(vector HitLocation)
{
	HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
	MakeNoise(1.0);
}

// Spawns the effects and activates the 'BlowUp' function when activated.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	PlaySound(ExplosionSound,,ExplosionSoundVolume,,ExplosionSoundRadius, ExplosionSoundPitch);
    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(ExplosionEffect,,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }

	BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     ExplosionEffect=Class'BWBP_VPC_Pro.RocketExplosionEffect'
     SmokeTrailClass=Class'BWBP_VPC_Pro.LeopardShellTrail'
     ExplosionSound=SoundGroup'BWBP_Vehicles_Sound.Effects.ExplosionsSmall'
     ExplosionSoundVolume=2.000000
     ExplosionSoundRadius=900.000000
     ExplosionSoundPitch=1.000000
     Speed=250000.000000
     MaxSpeed=250000.000000
     Damage=1000.000000
     DamageRadius=660.000000
     MomentumTransfer=40000.000000
     MyDamageType=Class'BWBP_VPC_Pro.LeopardDamTypeShell'
     ExplosionDecal=Class'BWBP_VPC_Pro.ExplosionDecal'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketProj'
     Physics=PHYS_Falling
     AmbientSound=Sound'VMVehicleSounds-S.HoverTank.IncomingShell'
     LifeSpan=9.000000
     Acceleration=(Z=600.000000)
     AmbientGlow=96
     FluidSurfaceShootStrengthMod=10.000000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=1000.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=1000.000000
     bFixedRotationDir=True
     Mass=0.100000
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=30000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
