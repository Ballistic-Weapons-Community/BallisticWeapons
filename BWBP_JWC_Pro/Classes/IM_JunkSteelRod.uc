//=============================================================================
// IM_JunkSteelRod.
//
// Impact Manager for Steel Rod
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkSteelRod extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_MetalToDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_MetalToMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_MetalToWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_MetalToGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_SmallPlayer'
     HitEffects(7)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(8)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(9)=Class'BWBP_JWC_Pro.IE_WaterHit'
     HitEffects(10)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkLightBluntConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkLightBluntConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkLightBluntDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkLightBluntMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkLightBluntWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkLightBluntDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkLightBluntDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkLightBluntConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkLightBluntDirt'
     HitDecals(9)=Class'BWBP_JWC_Pro.AD_JunkLightBluntDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkLightBluntConcrete'
     DecalScale=1.350000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Hammer.Hammer-Concrete'
     HitSoundVolume=0.800000
     HitSoundRadius=48.000000
     HitSoundPitch=1.200000
}
