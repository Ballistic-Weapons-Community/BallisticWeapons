//=============================================================================
// A73PowerProjectileB
//
// Un Grenaten por las A74vw.
//
// It blows stuff up.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73PowerProjectileB extends BallisticProjectile;

var vector					StartLocation;
var bool					bScaleDone;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	StartLocation = Location;
}

// Projectile grows as it comes out the gun...
simulated function Tick(float DT)
{
	local vector DS;
	local Rotator R;

	if (Speed < MaxSpeed)
	{
		Speed = FMin(MaxSpeed, Speed+16000*DT);
		Velocity = Normal(Velocity)*Speed;
		if (Speed >= MaxSpeed)
			SetPhysics(PHYS_Falling);
	}

	R.Roll = Rotation.Roll;
	SetRotation(Rotator(velocity)+R);

	if (bScaleDone)
		return;

	DS.X = VSize(Location-StartLocation)/(384*DrawScale);
	DS.Y = 0.5;
	DS.Z = 0.5;
	if (DS.X >= 1)
	{
		DS.X = 1;
		bScaleDone=true;
	}
	SetDrawScale3D(DS);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated event Landed( vector HitNormal )
{
	HitWall(HitNormal, level);
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
		bWasAlive = true;
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);

}

simulated function DoVehicleDriverRadius(Vehicle Other)
{
	local bool bWasAlive;
	local Pawn D;

	if (Other.Driver != None && Other.Driver.health > 0)
	{
		D = Other.Driver;
		bWasAlive = true;
	}

	Other.DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);

}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			DoDamage(Wall, Location);
//			Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				DoVehicleDriverRadius(Vehicle(Wall));
//				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)) || RSDarkProjectile(Other)!=None || RSDarkFastProjectile(Other)!=None)
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);

	HitActor = Other;
	Explode(HitLocation, vect(0,0,1));
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
	local bool bWasAlive;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (xPawn(Victims) != None && Pawn(Victims).Health > 0)
				bWasAlive = true;
			else if (Vehicle(Victims) != None && Vehicle(Victims).Driver!=None && Vehicle(Victims).Driver.Health > 0)
				bWasAlive = true;
			else
				bWasAlive = false;
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
	
		}
	}
	bHurtEntry = false;
}

state NetTrapped
{
	function BeginState()
	{
		HideProjectile();
		SetTimer(NetTrappedDelay, false);
		DestroyEffects();
	}
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     ModeIndex=1
    WeaponClass=Class'BallisticProV55.A73SkrithRifle'
     ImpactManager=Class'BallisticProV55.IM_A73PowerB'
     PenetrateManager=Class'BallisticProV55.IM_A73PowerB'
     bRandomStartRotation=False
     TrailClass=Class'BallisticProV55.A73PowerTrailEmitterB'
     MyRadiusDamageType=Class'BallisticProV55.DTA73SkrithPowerRadius'
     bNetTemporary=True
     bTearOnExplode=False
     DamageTypeHead=Class'BallisticProV55.DTA73SkrithHead'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=384.000000
     ShakeRotMag=(Y=200.000000,Z=128.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(Y=15.000000,Z=15.000000)
     ShakeOffsetTime=2.000000
     Speed=90.000000
     MaxSpeed=2000.000000
     bSwitchToZeroCollision=True
     Damage=90.000000
     DamageRadius=270.000000
     MomentumTransfer=80000.000000
     MyDamageType=Class'BallisticProV55.DTA73SkrithPower'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=15
     LightSaturation=40
     LightBrightness=160.000000
     LightRadius=12.000000
     DrawType=DT_None
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.DarkStar.DarkProjBig'
     bDynamicLight=True
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     Physics=PHYS_Falling
     AmbientSound=Sound'BW_Core_WeaponSound.A73.A73ProjFly'
     LifeSpan=16.000000
     Skins(0)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BPowerF2'
     Skins(1)=FinalBlend'BW_Core_WeaponTex.A73OrangeLayout.A73BPowerF1'
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     bProjTarget=True
}
