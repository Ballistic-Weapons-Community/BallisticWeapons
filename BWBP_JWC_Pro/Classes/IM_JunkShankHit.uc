//=============================================================================
// IM_JunkShankHit.
//
// Impact manager for Shank
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkShankHit extends BCImpactManager;

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
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkSharpConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkSharpConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkSharpDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkSharpMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkSharpWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkSharpDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkSharpDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkSharpConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkSharpDirt'
     HitDecals(9)=Class'BWBP_JWC_Pro.AD_JunkSharpDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkSharpConcrete'
     DecalScale=1.750000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-LightSharp'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Small'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Concrete'
     HitSoundVolume=0.900000
     HitSoundRadius=48.000000
}
