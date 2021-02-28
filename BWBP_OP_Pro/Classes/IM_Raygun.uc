class IM_Raygun extends BCImpactManager;

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (HitSurfaceType > 0)
		HitSoundRadius=256;

	super.Initialize(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BWBP_OP_Pro.IE_RaygunChargedExplosion'
     HitEffects(1)=Class'BWBP_OP_Pro.IE_RaygunProjectile'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitDecals(1)=Class'BallisticProV55.AD_RSDarkFast'
     HitSounds(0)=Sound'BWBP_OP_Sounds.Raygun.Raygun-ImpactBig'
     HitSounds(1)=Sound'BWBP_OP_Sounds.Raygun.Raygun-Impact'
     HitSoundVolume=1.000000
     HitSoundRadius=2048.000000
}
