//=============================================================================
// DCTVThorTankShell.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DCTVThorTankShell extends ONSRocketProjectile;

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        SmokeTrailEffect = Spawn(class'DCTVThorShellTrail',self);
//		Corona = Spawn(class'RocketCorona',self);
	}

	//Speed += -1000 + Rand(2000);

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
	Super(Projectile).PostBeginPlay();
}
simulated function Explode(vector HitLocation, vector HitNormal)
{
	PlaySound(sound'WeaponSounds.BExplosion3',,5.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'DCTVShellImpact',,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }

	BlowUp(HitLocation);
	Destroy();
}

defaultproperties
{
     Speed=5500.000000
     MaxSpeed=8000.000000
     MyDamageType=Class'BWBP_VPC_Pro.DT_ThorTankShell'
     Physics=PHYS_Falling
     LifeSpan=6.000000
     bIgnoreTerminalVelocity=True
}
