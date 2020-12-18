//=============================================================================
// IM_A73Knife.
//
// ImpactManager subclass for A73 Bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_A73Knife extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BallisticProV55.IE_A73KnifeConcrete'
     HitEffects(1)=Class'BallisticProV55.IE_A73KnifeConcrete'
     HitEffects(2)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(3)=Class'BallisticProV55.IE_KnifeMetal'
     HitEffects(4)=Class'BallisticProV55.IE_BulletWood'
     HitEffects(5)=Class'BallisticProV55.IE_BulletGrass'
     HitEffects(6)=Class'BallisticProV55.IE_BulletDirt'
     HitEffects(7)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(8)=Class'BallisticProV55.IE_BulletIce'
     HitEffects(9)=Class'BallisticProV55.IE_ProjWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
     HitDecals(0)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(1)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(2)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(3)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(4)=Class'BallisticProV55.AD_A73StabWood'
     HitDecals(5)=Class'BallisticProV55.AD_A73StabWood'
     HitDecals(6)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(7)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(8)=Class'BallisticProV55.AD_A73Stab'
     HitDecals(10)=Class'BallisticProV55.AD_A73Stab'
     HitSounds(0)=SoundGroup'BallisticSounds2.A73.A73ConcreteHit'
     HitSounds(1)=SoundGroup'BallisticSounds2.A73.A73ConcreteHit'
     HitSounds(2)=SoundGroup'BallisticSounds2.A73.A73WoodHit'
     HitSounds(3)=SoundGroup'BallisticSounds2.A73.A73MetalHit'
     HitSounds(4)=SoundGroup'BallisticSounds2.A73.A73WoodHit'
     HitSounds(5)=SoundGroup'BallisticSounds2.A73.A73WoodHit'
     HitSounds(6)=SoundGroup'BallisticSounds2.A73.A73ConcreteHit'
     HitSounds(7)=SoundGroup'BallisticSounds2.A73.A73WoodHit'
     HitSounds(8)=SoundGroup'BallisticSounds2.A73.A73WoodHit'
     HitSounds(9)=SoundGroup'BallisticSounds2.NRP57.NRP57-Water'
     HitSounds(10)=SoundGroup'BallisticSounds2.A73.A73MetalHit'
     HitSoundVolume=0.700000
     HitSoundRadius=32.000000
     HitDelay=0.100000
}
