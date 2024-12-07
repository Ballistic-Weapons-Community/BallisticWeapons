//=============================================================================
// NRP57Thrown.
//
// No longer karma based to prevent desynch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57Thrown extends BallisticHandGrenadeProjectile;

var	    Actor					PATrail;					// The trail Actor
var() class<Actor>			    PATrailClass;				// Actor to use for trail

simulated function InitEffects ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Speed > 400 && PATrailClass != None && PATrail == None && level.DetailMode == DM_SuperHigh)
	{
		PATrail = Spawn(PATrailClass, self,, Location);
		if (Emitter(PATrail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(PATrail), DrawScale);
		if (PATrail != None)
			PATrail.SetBase (self);
	}
}

simulated function Destroyed()
{
	if (PATrail != None)
	{
		if (Emitter(PATrail) != None)
			Emitter(PATrail).Kill();
		else
			PATrail.Destroy();
	}
	Super.Destroyed();
}

defaultproperties
{
    WeaponClass=Class'BallisticProV55.NRP57Grenade'
     DampenFactor=0.050000
     DampenFactorParallel=0.350000
     DetonateDelay=3.000000
     ImpactDamage=15
     ImpactDamageType=Class'BallisticProV55.DTNRP57Grenade'
     ImpactManager=Class'BallisticProV55.IM_NRP57Grenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.NRP57Trail'
     TrailOffset=(X=1.600000,Z=6.400000)
     PATrailClass=Class'BallisticProV55.PineappleTrail'
     MyRadiusDamageType=Class'BallisticProV55.DTNRP57GrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=512.000000
     WallPenetrationForce=16
     Speed=1400.000000
     MaxSpeed=1500.000000
     Damage=150.000000
     DamageRadius=1024.000000
     MyDamageType=Class'BallisticProV55.DTNRP57Grenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.NRP57.Pineapple'
}
