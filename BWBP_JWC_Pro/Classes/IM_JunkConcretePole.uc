//=============================================================================
// IM_JunkConcretePole.
//
// Impact Manager for Concrete Pole
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_JunkConcretePole extends BCShakeImpact;

defaultproperties
{
     HitEffects(0)=Class'BWBP_JWC_Pro.IE_BigConcrete'
     HitEffects(1)=Class'BWBP_JWC_Pro.IE_BigConcrete'
     HitEffects(2)=Class'BWBP_JWC_Pro.IE_BigDirt'
     HitEffects(3)=Class'BWBP_JWC_Pro.IE_BigMetal'
     HitEffects(4)=Class'BWBP_JWC_Pro.IE_BigWood'
     HitEffects(5)=Class'BWBP_JWC_Pro.IE_BigGrass'
     HitEffects(6)=Class'BWBP_JWC_Pro.IE_BigPlayer'
     HitEffects(7)=Class'BWBP_JWC_Pro.IE_BigSnow'
     HitEffects(8)=Class'BWBP_JWC_Pro.IE_BigSnow'
     HitEffects(9)=Class'BWBP_JWC_Pro.IE_WaterHit'
     HitEffects(10)=Class'BWBP_JWC_Pro.IE_BigConcrete'
     HitDecals(0)=Class'BWBP_JWC_Pro.AD_JunkHeavyConcrete'
     HitDecals(1)=Class'BWBP_JWC_Pro.AD_JunkHeavyConcrete'
     HitDecals(2)=Class'BWBP_JWC_Pro.AD_JunkHeavyDirt'
     HitDecals(3)=Class'BWBP_JWC_Pro.AD_JunkHeavyMetal'
     HitDecals(4)=Class'BWBP_JWC_Pro.AD_JunkHeavyWood'
     HitDecals(5)=Class'BWBP_JWC_Pro.AD_JunkHeavyDirt'
     HitDecals(6)=Class'BWBP_JWC_Pro.AD_JunkHeavyDirt'
     HitDecals(7)=Class'BWBP_JWC_Pro.AD_JunkHeavyConcrete'
     HitDecals(8)=Class'BWBP_JWC_Pro.AD_JunkHeavyDirt'
     HitDecals(9)=Class'BWBP_JWC_Pro.AD_JunkHeavyDirt'
     HitDecals(10)=Class'BWBP_JWC_Pro.AD_JunkHeavyConcrete'
     HitSounds(0)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Concrete'
     HitSounds(1)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Concrete'
     HitSounds(2)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Dirt'
     HitSounds(3)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Metal'
     HitSounds(4)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Wood'
     HitSounds(5)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Dirt'
     HitSounds(6)=SoundGroup'BWBP_JW_Sound.Flesh.Flesh-HeavyBlunt'
     HitSounds(7)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Dirt'
     HitSounds(8)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Dirt'
     HitSounds(9)=Sound'BWBP_JW_Sound.Misc.Water-Big'
     HitSounds(10)=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Concrete'
     HitSoundVolume=2.000000
     HitSoundRadius=72.000000
     ShakeRotMag=(X=192.000000,Y=192.000000,Z=192.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=4.000000
     ShakeOffsetMag=(X=8.000000,Y=8.000000,Z=8.000000)
     ShakeOffsetTime=4.000000
}
