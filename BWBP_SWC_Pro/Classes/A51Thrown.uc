//=============================================================================
// FP7Thrown.
//
// Thrown overhand FP7. Spawns fires on detonation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A51Thrown extends BallisticHandGrenadeProjectile;

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

simulated event KImpact(actor other, vector pos, vector impactVel, vector impactNorm)
{
	super.KImpact(other, pos, impactVel, impactNorm);
	if (PATrail!= None && VSize(impactVel) > 200)
		PATrail.Destroy();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local A51AcidControl F;

	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    	if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if ( Role == ROLE_Authority )
	{
		F = Spawn(class'A51AcidControl',self,,HitLocation-HitNormal*2, rot(0,0,0));
		if (F!=None)
		{
			F.Instigator = Instigator;
			F.Initialize(vect(0,0,1),8);
		}
	}
	Destroy();
}

defaultproperties
{
	WeaponClass=class'A51Grenade'
	DampenFactor=0.050000
	DampenFactorParallel=0.350000
	ImpactDamage=15
	ImpactDamageType=Class'BWBP_SWC_Pro.DTA51Grenade'
	ImpactManager=Class'BWBP_SWC_Pro.IM_AcidGrenade'
	TrailOffset=(X=1.600000,Z=6.400000)
	PATrailClass=Class'BallisticProV55.PineappleTrail'
	MyRadiusDamageType=Class'BWBP_SWC_Pro.DTA51Pool'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Damage=100.000000
	DamageRadius=250.000000
	MyDamageType=Class'BWBP_SWC_Pro.DTA51Grenade'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	//StaticMesh=StaticMesh'BWBP_SWC_Static.SG.SkrithGrenadeProj'
	DrawScale=0.500000
}
