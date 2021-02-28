//=============================================================================
// IM_ShellHE.
//
// ImpactManager subclass for shotgun impacts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IM_ShellHE extends BCImpactManager;

defaultproperties
{
     HitEffects(0)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(1)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(2)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(3)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(4)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(5)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(6)=Class'XEffects.pclredsmoke'
     HitEffects(7)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(8)=Class'BWBP_SKC_Pro.IE_ShellHE'
     HitEffects(9)=Class'BallisticProV55.IE_ShellWater'
     HitEffects(10)=Class'BallisticProV55.IE_BulletGlass'
     HitDecals(0)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(1)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(3)=Class'BallisticProV55.AD_ShellMetal'
     HitDecals(4)=Class'BallisticProV55.AD_ShellWood'
     HitDecals(5)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(6)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(7)=Class'BallisticProV55.AD_ShellConcrete'
     HitDecals(10)=Class'BallisticProV55.AD_ShellConcrete'
     HitSounds(0)=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-Impact'
     HitSoundVolume=0.100000
     HitDelay=0.080000
}
