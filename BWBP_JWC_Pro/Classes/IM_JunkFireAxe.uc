//=============================================================================
// IM_JunkBigMace.
//
// Impact Manager for Fire Axe
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkFireAxe extends BCShakeImpact;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_ClubDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_ClubMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_ClubWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_ClubGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_AvgPlayer'
     HitEffects(7)=Class'BWBP_JWC_Pro.IE_BigSnow'
     HitEffects(8)=Class'BWBP_JWC_Pro.IE_BigSnow'
     HitEffects(9)=Class'BWBP_JWC_Pro.IE_WaterHit'
     HitEffects(10)=Class'BWBP_JWC_Pro.IE_ClubConcrete'
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkBigSharpConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkBigSharpConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkBigSharpDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkBigSharpMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkBigSharpWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkBigSharpDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkBigSharpDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkBigSharpConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkBigSharpDirt'
     HitDecals(9)=Class'BWBP_JWC_Pro.AD_JunkBigSharpDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkBigSharpConcrete'
     DecalScale=1.500000
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-HeavySharp'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Big'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Sledge.Sledge-Concrete'
     HitSoundVolume=1.300000
     HitSoundRadius=72.000000
     HitSoundPitch=1.200000
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=64.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=4.000000,Y=4.000000,Z=4.000000)
     ShakeOffsetTime=2.000000
}
