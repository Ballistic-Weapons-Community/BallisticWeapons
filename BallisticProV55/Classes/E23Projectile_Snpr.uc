//=============================================================================
// E23Projectile_Snpr.
//
// Sniper mode plasma projectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23Projectile_Snpr extends BallisticProjectile;

simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	Super.GetDamageVictim(Other, HitLocation, Dir, Dmg, DT);
	
	Dmg *= 1 + 4 * FMin(default.LifeSpan - LifeSpan, 0.35)/0.35;
		
	return Other;
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
    bRandomStartRotation=False
    MyRadiusDamageType=Class'BallisticProV55.DTE23Plasma'
    DamageTypeHead=Class'BallisticProV55.DTE23PlasmaHead'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    MyDamageType=Class'BallisticProV55.DTE23Plasma'
    LightType=LT_Steady
    LightEffect=LE_QuadraticNonIncidence
    LightHue=64
    LightSaturation=96
    LightBrightness=192.000000
    LightRadius=6.000000
    StaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRProjectile'
    bDynamicLight=True
    AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
    LifeSpan=4.000000
    DrawScale3D=(X=2.000000,Y=1.300000,Z=1.300000)
    Style=STY_Additive
    SoundVolume=255
    SoundRadius=75.000000
    CollisionRadius=3.000000
    CollisionHeight=3.000000
    bFixedRotationDir=True
    RotationRate=(Roll=16384)
}
