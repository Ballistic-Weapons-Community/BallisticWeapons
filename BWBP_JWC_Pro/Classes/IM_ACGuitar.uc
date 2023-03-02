//=============================================================================
// IM_JunkTwoByFour.
//
// Impact Manager for 2x4
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ACGuitar extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_MetalToConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_MetalToDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_MetalToMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_MetalToWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_MetalToGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_MetalToDirt'
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
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Conc'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Conc'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-BluntFlesh'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.ElectricGuitar.Guitar-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.ElectricGuitar.Water-Big'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Wood.Wood-Concrete'
     HitSoundVolume=1.300000
     HitSoundPitch=0.900000
}
