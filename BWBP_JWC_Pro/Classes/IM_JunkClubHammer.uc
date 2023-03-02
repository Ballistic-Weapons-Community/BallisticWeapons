//=============================================================================
// IM_JunkClubHammer.
//
// Impact Manager for Club Hammer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkClubHammer extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_ClubDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_ClubMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_ClubWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_ClubGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_AvgPlayer'
     HitEffects(7)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(8)=Class'BWBP_JWC_Pro.IE_AvgSnow'
     HitEffects(9)=Class'BWBP_JWC_Pro.IE_WaterHit'
     HitEffects(10)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
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
     DecalScale=1.250000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-AvgBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Avg'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Concrete'
     HitSoundVolume=1.700000
     HitSoundRadius=48.000000
}
