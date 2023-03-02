//=============================================================================
// IM_swatter.
//
// Impact Manager for swatter
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_swatter extends BCImpactManager;

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
     HitSounds(0)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(1)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(2)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(3)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(4)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(5)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(6)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(7)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(8)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(9)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSounds(10)=Sound'BWBP_JW_Sound.Extra.SlapSound'
     HitSoundVolume=1.700000
     HitSoundRadius=48.000000
}
