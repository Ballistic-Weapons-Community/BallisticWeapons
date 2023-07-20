//=============================================================================
// IM_JunkWrench.
//
// Impact Manager for Wrench
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkWrench extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_MetalToDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_MetalToMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_MetalToWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_MetalToGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_AvgPlayer'
     HitEffects(7)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(8)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(9)=Class'BWBP_JWC_Pro.IE_WaterHit'
     HitEffects(10)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkBluntConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkBluntConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkBluntDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkBluntMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkBluntWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkBluntDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkBluntDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkBluntConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkBluntDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkBluntConcrete'
     DecalScale=0.750000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Concrete'
     HitSoundVolume=1.300000
     HitSoundRadius=48.000000
}
