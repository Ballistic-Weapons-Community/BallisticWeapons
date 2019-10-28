class IM_Raygun extends BCImpactManager;

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (HitSurfaceType > 1)
		HitSoundRadius=256;

	super.Initialize(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BWBPOtherPackPro.IE_RaygunChargedExplosion'
     HitEffects(1)=Class'BWBPOtherPackPro.IE_RaygunPlagueChargedExplosion'
     HitEffects(2)=Class'BWBPOtherPackPro.IE_RaygunProjectile'
     HitEffects(3)=Class'BWBPOtherPackPro.IE_RaygunPlagueProjectile'
     HitDecals(0)=Class'BallisticProV55.AD_Explosion'
     HitDecals(1)=Class'BallisticProV55.AD_Explosion'
     HitDecals(2)=Class'BallisticProV55.AD_RSDarkFast'
     HitDecals(3)=Class'BallisticProV55.AD_RSDarkFast'
     HitSounds(0)=Sound'BWBPOtherPackSound.Raygun.Raygun-ImpactBig'
     HitSounds(1)=Sound'BWBPOtherPackSound.Raygun.Raygun-PlagueImpactBig'
     HitSounds(2)=Sound'BWBPOtherPackSound.Raygun.Raygun-Impact'
     HitSounds(3)=Sound'BWBPOtherPackSound.Raygun.Raygun-Impact'
     HitSoundVolume=1.000000
     HitSoundRadius=2048.000000
}
