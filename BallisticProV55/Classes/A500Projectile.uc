//=============================================================================
// A500Projectile.
//
// An A500 projectile that corrodes the armor of damaged players.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500Projectile extends BallisticProjectile;

var() float FallSpeed;
var() float FallOffDistance;

var vector FallStart;
var float FallOff;
var float FallingSpeed;

var   Rotator			VelocityDir;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	VelocityDir = Rotation;
}

simulated function InitProjectile()
{
	Super.InitProjectile();

	FallStart=Location;
}

simulated event Tick(float DT)
{
	SetRotation(Rotator(Velocity));

	Super.Tick(DT);
}

simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	local Vector ClosestLocation, temp, BoneTestLocation;
	
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority && Other != HitActor)		// Do damage for direct hits
	{
		if (xPawn(Other) != None)
		{
			//Find a point on the victim's Z axis at the same height as the HitLocation.
			ClosestLocation = Other.Location;
			ClosestLocation.Z += (HitLocation - Other.Location).Z;
			
			//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
			temp = Normal(Velocity);
			temp *= VSize(ClosestLocation - HitLocation);
			BoneTestLocation = temp;
			BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
			BoneTestLocation += HitLocation;
			
			DoDamage(Other, BoneTestLocation);
		}
		
		else DoDamage(Other, HitLocation);
	}

	HitActor = Other;
	PTExplode(HitLocation, Normal(HitLocation - Other.Location));
}

function DoDamage (Actor Other, vector HitLocation)
{
	local A500HPReducer hpReducer;
	
	super.DoDamage(Other, HitLocation);
	
	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		hpReducer= A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
	
		if (hpReducer == None)
		{
			Pawn(Other).CreateInventory("BallisticProV55.A500HPReducer");
			hpReducer = A500HPReducer(Pawn(Other).FindInventoryType(class'A500HPReducer'));
		}
	
		hpReducer.AddStack(4);
	}
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
			Wall.TakeDamage(Max(3,Damage*(1.0-FallOff)), instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Max(5,Damage*(1.0-FallOff)), DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	if (Wall != None && Pawn(Wall)!=None)
		PTExplode(Location + ExploWallOut * HitNormal, HitNormal);
	else
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

simulated event Landed( vector HitNormal )
{
	Explode(Location + ExploWallout * HitNormal, HitNormal);
}

simulated function PTExplode(vector HitLocation, vector HitNormal)
{
	if (bExploded)
		return;

    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, 1, Level.GetLocalPlayerController()/*.Pawn*/);
	BlowUp(HitLocation);
	bExploded=true;

	if (bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
		bTearOff = true;
	Destroy();
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_A500Projectile'
     bRandomStartRotaion=False
     TrailClass=Class'BallisticProV55.A500ProjectileTrail'
     MyRadiusDamageType=Class'BallisticProV55.DTA500Blast'
     bUsePositionalDamage=False

     MaxDamageGainFactor=0.5
     DamageGainEndTime=0.3
     
     DamageTypeHead=Class'BallisticProV55.DTA500BlastHead'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=5500.000000
	 MaxSpeed=6500.000000
	 AccelSpeed=3000.000000
     Damage=22.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'BallisticProV55.DTA500Blast'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=150.000000
     LightRadius=4.000000
     bDynamicLight=True
     Physics=PHYS_Falling
     LifeSpan=8.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bFixedRotationDir=True
     bIgnoreTerminalVelocity=True
     RotationRate=(Roll=16384)
}
