//=============================================================================
// G5Rocket.
//
// Rocket projectile for the G5 RPG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5Rocket extends BallisticProjectile;

var sound ImpactSounds[6];
var float ImpactDamage, ArmedImpactDamage;
var float ImpactMomentumTransfer;
var class<DamageType> ImpactDamageType;
var float ArmingDelay;
var float FlightTime;
var bool bArmed;
delegate OnDie(Actor Cam);

replication
{
	reliable if (Role == ROLE_Authority)
		bArmed;
}

simulated function InitProjectile()
{
	Super.InitProjectile();
	if (Role == ROLE_Authority)
		SetTimer(ArmingDelay, false);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (Role == ROLE_Authority)
		bArmed=True;
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	OnDie(self);
	Damage *= 1 + FClamp(default.LifeSpan  - (LifeSpan + ArmingDelay), 0, 0.5);
	Super.Explode(HitLocation, HitNormal);
}

simulated function ApplyImpactEffect(Actor Other, vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
			
    if (!bArmed)
        class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, ImpactMomentumTransfer * Normal(Velocity), ImpactDamageType);
    else 
        class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity),MyDamageType);
}

simulated function bool Impact(Actor Other, vector HitLocation)
{
    if (bArmed)
        return false;

    Destroy();
    return true;
}

simulated singular function HitWall( vector HitNormal, actor Wall )
{
    if ( !Wall.bStatic && !Wall.bWorldGeometry 
		&& ((Mover(Wall) == None) || Mover(Wall).bDamageTriggered) )
	{
		if ( Instigator == None || Instigator.Controller == None )
			Wall.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Wall, Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
			Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
		HurtWall = Wall;
	}
 
	if(!bArmed)
	{	
		if ( !Level.bDropDetail && (FRand() < 0.4) )
			Playsound(ImpactSounds[Rand(6)]);
		Velocity = 0.45 * (Velocity - 1.33*HitNormal*(Velocity dot HitNormal)); //reflection is not complete
		SetRotation(Rotator(Velocity));
		AccelSpeed *= 0.75;
		Acceleration = AccelSpeed * Normal(Velocity);
		MakeNoise(1.0);
		return;
   	}

	else if (Role == ROLE_Authority)
	{
		MakeNoise(1.0);
		
		Damage *= 1 + FClamp(default.LifeSpan  - (LifeSpan + ArmingDelay), 0, 0.5);
		Explode(Location + ExploWallOut * HitNormal, HitNormal);
		
		HurtWall = None;
	}
}

defaultproperties
{
     ImpactSounds(0)=Sound'XEffects.Impact4Snd'
     ImpactSounds(1)=Sound'XEffects.Impact6Snd'
     ImpactSounds(2)=Sound'XEffects.Impact7Snd'
     ImpactSounds(3)=Sound'XEffects.Impact3'
     ImpactSounds(4)=Sound'XEffects.Impact1'
     ImpactSounds(5)=Sound'XEffects.Impact2'
	 ImpactDamage=100.000000
	 ArmedImpactDamage=150.000000
     ImpactMomentumTransfer=200000.000000
     ImpactDamageType=Class'BallisticProV55.DTG5Unarmed'
     ArmingDelay=0.200000
     ImpactManager=Class'BallisticProV55.IM_RPG'
     bRandomStartRotaion=False
     AccelSpeed=5000.000000
     TrailClass=Class'BallisticProV55.G5RocketTrail'
     TrailOffset=(X=-14.000000)
     MyRadiusDamageType=Class'BallisticProV55.DTG5BazookaRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=378.000000
     MotionBlurRadius=512.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=2000.000000
     MaxSpeed=25000.000000
     Damage=120.000000
     DamageRadius=768.000000
     WallPenetrationForce=384
     MomentumTransfer=90000.000000
     MyDamageType=Class'BallisticProV55.DTG5Bazooka'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BallisticHardware2.G5.G5Rocket'
     bDynamicLight=True
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     AmbientSound=Sound'BallisticSounds2.G5.G5-RocketFly'
     DrawScale=0.500000
     SoundVolume=192
     SoundRadius=128.000000
     CollisionRadius=4.000000
     CollisionHeight=4.000000
     bUseCollisionStaticMesh=True
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
