//=============================================================================
// ScarabThrown.
//
// No longer karma based to prevent desynch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabThrown extends BallisticHandGrenadeProjectile;

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
	WeaponClass=Class'BWBP_APC_Pro.ScarabGrenade'
	DampenFactor=0.050000
	DampenFactorParallel=0.350000
	DetonateDelay=3.000000
	ImpactDamage=15
	ImpactDamageType=Class'BWBP_APC_Pro.DTScarabGrenade'
	ImpactManager=Class'BWBP_APC_Pro.IM_ScarabGrenade'
	ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
	TrailClass=Class'BWBP_APC_Pro.ScarabTrail'
	TrailOffset=(X=1.600000,Z=6.400000)
	PATrailClass=Class'BallisticProV55.PineappleTrail'
	MyRadiusDamageType=Class'BWBP_APC_Pro.DTScarabGrenadeRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=512.000000
	MotionBlurRadius=512.000000
	WallPenetrationForce=256
	FlakCount=16
	FlakClass=Class'BWBP_APC_Pro.ScarabMicroClusterFlak'
	Speed=1400.000000
	MaxSpeed=1500.000000
	Damage=50.000000
	DamageRadius=512.000000
	MyDamageType=Class'BWBP_APC_Pro.DTScarabGrenade'
	ImpactSound=SoundGroup'BWBP_CC_Sounds.CruGren.CruGren-Concrete'
	StaticMesh=StaticMesh'BWBP_CC_Static.CruGren.CruGrenProjectile'
}
