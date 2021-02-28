class IM_XOXO extends BCImpactManager;

simulated function Initialize (int HitSurfaceType, vector Norm, optional byte Flags)
{
	if (HitSurfaceType == 1)
	{
		HitSoundVolume = 0.700000;
		HitSoundRadius = 96.000000;
	}
	else if (HitSurfaceType == 2)
	{
		HitSoundVolume=2;
		HitSoundRadius=2048;
		DecalScale=4;
	}
	super.Initialize(HitSurfaceType, Norm, Flags);
}

defaultproperties
{
     HitEffects(0)=Class'BWBP_OP_Pro.IE_XOXOExplosion'
     HitEffects(1)=Class'BWBP_OP_Pro.IE_XOXOSmall'
     HitEffects(2)=Class'BWBP_OP_Pro.IE_XOXONukeExplosion'
     HitDecals(0)=Class'BallisticProV55.AD_A42General'
     HitDecals(1)=Class'BallisticProV55.AD_A42General'
     HitDecals(2)=Class'BallisticProV55.AD_Explosion'
     HitSounds(0)=Sound'BWBP_OP_Sounds.XOXO.XOXO-ImpactBig'
     HitSounds(1)=Sound'BWBP_OP_Sounds.XOXO.XOXO-ImpactSmall'
     HitSounds(2)=Sound'BWBP_OP_Sounds.XOXO.XOXO-Sexplosion'
     HitSoundVolume=1.300000
     HitSoundRadius=378.000000
}
