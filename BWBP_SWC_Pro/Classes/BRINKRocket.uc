//=============================================================================
// MRLRocket.
//
// A Crazy, unpredictable and not too powerful small 'drunk' rocket. They move
// fast and unpredictably, but usually come with lots of others.
//
// Drunkness:
// -Initial low accuracy
// -Duds
// -Strafing
// -Sidewinders
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BRINKRocket extends BallisticProjectile;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	SetTimer(0.5, false);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Timer()
{
	SetCollision(true,true);

	InitProjectile();
	
	Velocity = vector(Rotation) * MaxSpeed;
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

/*simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    Super.ApplyImpactEffect(Other, HitLocation);

	if (Pawn(Other) != None && (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact))
		ApplySlowdown(Pawn(Other), Damage/8);
}*/

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
/*function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	
	if (Victim == None)
	{
		DamageAmount *= 0.5;
		DamageRadius *= 0.75;
	}
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
			{
				if (!bCoverPenetrator)
					continue;
				else DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			else DmgRadiusScale = 1;
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			if (bCoverPenetrator && DmgRadiusScale < 1 && VSize(dir) > DamageRadius * DmgRadiusScale)
				continue;
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ (DamageRadius * DmgRadiusScale));
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
			if (Pawn(Victims) != None)
				ApplySlowdown(Pawn(Victims), Damage/8);
		 }
	 }
	bHurtEntry = false;
}*/

function ApplySlowdown(pawn Other, float Damage)
{
	local Inv_Slowdown Slow;
	
	Slow = Inv_Slowdown(Other.FindInventoryType(class'Inv_Slowdown'));
	
	if (Slow == None)
	{
		Other.CreateInventory("BallisticProV55.Inv_Slowdown");
		Slow = Inv_Slowdown(Other.FindInventoryType(class'Inv_Slowdown'));
	}
	
	Slow.AddSlow(0.7, Damage);
}

defaultproperties
{
     ModeIndex=1
	 TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBP_SWC_Pro.DTBRINKGrenade'
     ImpactManager=Class'BWBP_SWC_Pro.IM_BRINKGrenade'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=600.000000
     MaxSpeed=14000.000000
     Damage=100.000000
     DamageRadius=500.000000
     MomentumTransfer=20000.000000
	 MotionBlurRadius=768.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=10.000000
     MyDamageType=Class'BWBP_SWC_Pro.DTBRINKGrenade'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
     bCollideActors=False
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
