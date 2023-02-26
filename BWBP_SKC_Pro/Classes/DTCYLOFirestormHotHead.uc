//=============================================================================
// DTCYLOFirestormHotHead.
//
// Damage type for hot CYLO headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOFirestormHotHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's flaming Firestorm roasted %o's head off."
     DeathStrings(1)="%k headshotted %o with his torching Firestorm."
     DeathStrings(2)="%k scalded %o's brain with his melting Firestorm."
     EffectChance=1.000000
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=1.250000
     DamageIdent="Assault"
     DamageDescription=",Bullet,Flame,Hazard,"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=3.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBP_SKC_Pro.CYLOFirestormAssaultWeapon'
     DeathString="%k's overheating Firestorm roasted %o's head off."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysSevers=True
     bFlaming=True
     GibModifier=1.200000
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
