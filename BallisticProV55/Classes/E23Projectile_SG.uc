//=============================================================================
// E23Projectile_SG.
//
// Ring fire plasma projectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23Projectile_SG extends BallisticProjectile;

var  int NetY, NetP;

replication
{
	unreliable if (Role == ROLE_Authority)
		NetY, NetP;
}

event PostBeginPlay()
{
	if (level.NetMode != NM_Client && level.NetMode != NM_StandAlone)
	{
		NetY = Rotation.Yaw;
		NetP = Rotation.Pitch;
	}
	super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	local Rotator R;

	if (level.NetMode == NM_Client)
	{
		R.Yaw = NetY;
		R.Pitch = NetP;
		R.Roll = Rotation.Roll;
		SetRotation(R);
	}
	super.PostNetBeginPlay();
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local PlayerController PC;

	if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer)  )
	{
		if ( ExplosionDecal.Default.CullDistance != 0 )
		{
			PC = Level.GetLocalPlayerController();
			if ( !PC.BeyondViewDistance(Location, ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
			else if ( (Instigator != None) && (PC == Instigator.Controller) && !PC.BeyondViewDistance(Location, 2*ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
		}
		else
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	}
	HurtWall = None;
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_E23Projectile'
     bRandomStartRotaion=False
     AccelSpeed=60000.000000
     MyRadiusDamageType=Class'BallisticProV55.DTE23Plasma'
     bUsePositionalDamage=True
     
     MaxDamageGainFactor=0.25
     DamageGainEndTime=0.3

     DamageTypeHead=Class'BallisticProV55.DTE23PlasmaHead'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=5500.000000
     MaxSpeed=5500.000000
     Damage=35.000000
     DamageRadius=64.000000
     MomentumTransfer=4000.000000
     MyDamageType=Class'BallisticProV55.DTE23Plasma'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=64
     LightSaturation=96
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.VPR.VPRProjectile'
     bDynamicLight=True
     AmbientSound=Sound'BallisticSounds2.A73.A73ProjFly'
     LifeSpan=4.000000
     DrawScale=0.750000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}
