//=============================================================================
// IM_JunkPipeTap.
//
// Impact Manager for Pipe and Tap
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkPipeTap extends BCImpactManager;

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
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.PipeCorner.PipeCorner-Concrete'
     HitSoundVolume=1.500000
     HitSoundRadius=48.000000
     HitSoundPitch=0.600000
}
