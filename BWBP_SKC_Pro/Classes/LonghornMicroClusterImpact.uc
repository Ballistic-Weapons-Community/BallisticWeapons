//=============================================================================
// LonghornMicroClusterImpact.
//
// Small cluster bomb spawned from LonghornClusterGrenade when used as artillery.
// Does a lot of damage with large radius.
//
// by Casey "Xavious" Johnson.
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================

class LonghornMicroClusterImpact extends LonghornMicroClusterFlak; //Artillery

simulated function InitProjectile ()
{
    super.InitProjectile();

	Velocity.Z *= 0.50;
	if (Velocity.Z < 0)
		Velocity.Z = 5;
}

defaultproperties
{
	 bApplyParams=False
     DetonateOn=DT_Impact
	DampenFactor=0.05
     DampenFactorParallel=0.250000
     DetonateDelay=0.100000
     ImpactDamage=20
     ImpactDamageType=Class'BWBP_SKC_Pro.DT_LonghornArtilleryDirect'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_LonghornArtilleryRadius'
     Speed=100.000000
     Damage=150.000000
     DamageRadius=500.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_LonghornArtilleryRadius'
     AmbientSound=Sound'ONSBPSounds.Artillery.ShellAmbient'
     AmbientGlow=100
     SoundVolume=64
     SoundRadius=100.000000
}
