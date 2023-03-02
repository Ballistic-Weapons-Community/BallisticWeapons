//=============================================================================
// Bonesaw.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBonesaw extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%k sliced up %o with a bonesaw."
     DeathStrings(1)="%o's bones got cut by %k's bonesaw."
     DeathStrings(2)="%k went straight through %o's bones with a bone saw."
     DeathStrings(3)="%o's limbs were sawed away by %k."
     DeathStrings(4)="%k went through %o's neck after a couple of sawing motions."
     DeathStrings(5)="%o's head was donated to medicine thanks to %k's bone saw."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with a bonesaw."
     FemaleSuicide="%o sliced herself with a bonesaw."
     MaleSuicide="%o slice himself with a bonesaw."
     bNeverSevers=False
}
