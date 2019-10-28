//=============================================================================
// BallisticKGrenade.
//
// SubClass for basic ballistic grenade wich gives it Karma Physics.
// A special check in the Tick() function is used to prevent it from going AWOL
// and escaping the world.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticKGrenade extends BallisticGrenade
	abstract;

var() Vector OldHitLoc, OldHitNorm, OldVelocity;
var() float LastImpactSoundTime;

simulated function InitProjectile ()
{
	local vector V;
	Super.InitProjectile();
	KGetCOMPosition(V);
	KAddImpulse(Velocity*50, V);
}

singular function BaseChange()
{
	local vector V;
	if (Base == None)
	{
		SetPhysics(PHYS_Karma);
		KGetCOMPosition(V);
		KAddImpulse(Velocity*20, V);
	}
}

simulated event ProcessTouch(actor Other, vector HitLocation)
{
	local float BoneDist;
	local Vector VNorm;

	if (Other == Instigator && (!bCanHitOwner || !bHasImpacted))
		return;
	if (Other == HitActor)
		return;
	if (Base != None)
		return;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
	if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{
		Other.TakeDamage(Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		return;
	}
	if ( (PlayerImpactType == PIT_Bounce || PlayerImpactType == PIT_Stick) && VSize(Velocity) > MinStickVelocity )
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
//		Other.TakeDamage(ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		SetPhysics(PHYS_None);
	    VNorm = (Velocity dot (HitLocation - Other.Location)) * (HitLocation - Other.Location);
		Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
		SetPhysics(PHYS_Karma);
		KAddImpulse(Velocity*20, Location);
		bHasImpacted=true;
	}
	else if (PlayerImpactType == PIT_Stick && Base == None)
	{
		SetPhysics(PHYS_None);
		if (DetonateOn == DT_ImpactTimed)
			SetTimer(DetonateDelay, false);
		HitActor = Other;
		if (Other != Instigator && Other.DrawType == DT_Mesh)
			Other.AttachToBone( Self, Other.GetClosestBone( Location, Velocity, BoneDist) );
		else
			SetBase (Other);
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
//		Other.TakeDamage(ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		SetRotation (Rotator(Velocity));
		Velocity = vect(0,0,0);
	}
}

simulated event KImpact(actor other, vector pos, vector impactVel, vector impactNorm)
{
	if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
		SetTimer(DetonateDelay, false);
	else if (DetonateOn == DT_Impact)
	{
		Explode(pos, impactNorm);
		return;
	}
//	bCanHitOwner=true;
	bHasImpacted=true;
	if (Level.NetMode != NM_DedicatedServer && VSize(impactVel) > 250 && level.TimeSeconds - LastImpactSoundTime > 0.7)
	{
		LastImpactSoundTime=level.TimeSeconds;
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
		if (ImpactManager != None && Other != None)
			ImpactManager.static.StartSpawn(pos, impactNorm, Other.SurfaceType, Owner);
    }
}

simulated event KVelDropBelow()
{
	SetPhysics(PHYS_None);
	if (Trail != None && !TrailWhenStill)
	{
		if (Emitter(Trail) != None)
			Emitter(Trail).Kill();
		else
			Trail.Destroy();
	}
}

// This little piece of code's responsible for making sure these Karma grenades
// don't fall through floors and stuff. It does a trace each tick and checks if
// there is a piece of geometry in the way of the velocity. If so, it remembers
// the hitlocation and normal and, the next tick, if the grenade is beyond the
// old hitlocation, this code will move it back into the right position and set
// a new velocity, play impact sound, etc...
simulated event Tick(float DT)
{
	local actor T;
	local Vector VNorm, NewVelocity, V;

	Super.Tick(DT);

	// Check if grenade moved beyond an obstacle
	if (Physics == PHYS_Karma && OldHitNorm != Vect(0,0,0) && Normal(Location-OldHitLoc) dot OldHitNorm < 0.0)
	{
		// Move back
		SetPhysics(PHYS_None);
		SetLocation(OldHitLoc+OldHitNorm*8);
		// New velocity
	    VNorm = (OldVelocity dot OldHitNorm) * OldHitNorm;
		NewVelocity = -VNorm * DampenFactor + (OldVelocity - VNorm) * DampenFactorParallel;
		// Fire up the karma
		SetPhysics(PHYS_Karma);
		KGetCOMPosition(V);
		KAddImpulse(NewVelocity*20, V);
		// Make some noise
		if ((Level.NetMode != NM_DedicatedServer) && (VSize(OldVelocity) > 250) && ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
	}
	// Check where we be going
	T = Trace(OldHitLoc, OldHitNorm, Location + Velocity, Location, false, vect(1,1,1));
	OldVelocity = Velocity;
}

defaultproperties
{
     DampenFactor=0.700000
     DampenFactorParallel=1.000000
     bIgnoreEncroachers=True
     Physics=PHYS_Karma
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bUseCylinderCollision=False
     bBlockKarma=True
     bFixedRotationDir=False
     Begin Object Class=KarmaParams Name=KParams0
         KMass=0.300000
         KLinearDamping=0.000000
         KAngularDamping=0.000000
         KStartEnabled=True
         KVelDropBelowThreshold=20.000000
         bHighDetailOnly=False
         bClientOnly=False
         bKDoubleTickRate=True
         KFriction=0.650000
         KRestitution=0.500000
         KImpactThreshold=100.000000
     End Object
     KParams=KarmaParams'BCoreProV55.BallisticKGrenade.KParams0'

}
