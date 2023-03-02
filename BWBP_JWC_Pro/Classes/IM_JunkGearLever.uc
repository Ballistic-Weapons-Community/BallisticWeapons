//=============================================================================
// IM_JunkGearLever.
//
// Impact Manager for Gear Lever
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkGearLever extends BCImpactManager;

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
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkBasicConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkBasicConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkBasicDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkBasicMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkBasicWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkBasicDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkBasicDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkBasicConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkBasicDirt'
     HitDecals(9)=Class'BWBP_JWC_Pro.AD_JunkBasicDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkBasicConcrete'
     DecalScale=0.750000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-LightBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Small'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSoundVolume=0.700000
     HitSoundRadius=48.000000
     HitSoundPitch=1.200000
}
