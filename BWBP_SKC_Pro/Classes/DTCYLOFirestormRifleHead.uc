//=============================================================================
// DTCYLOFirestormRifleHead.
//
// Damage type for the CYLO MK2 headshots.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOFirestormRifleHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k CYLO IV'd %o's head right off."
     DeathStrings(1)="%k put a fiery bullet in %o's head with his pyro CYLO."
     DeathStrings(2)="%k's incendiary CYLO rounds melted %o's face."
     DeathStrings(3)="%k put a incendiary round through %o's head."
     EffectChance=0.500000
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     bHeaddie=True
     InvasionDamageScaling=1.250000
     DamageIdent="Assault"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBP_SKC_Pro.CYLOFirestormAssaultWeapon'
     DeathString="%k CYLO IV'd %o's head right off."
     FemaleSuicide="%o routed herself."
     MaleSuicide="%o routed himself."
     bFastInstantHit=True
     bAlwaysGibs=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
