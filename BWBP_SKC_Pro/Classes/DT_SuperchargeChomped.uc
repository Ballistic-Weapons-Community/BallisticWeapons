//=============================================================================
// DT_SuperchargeChomped.
//
// Damage type for CHOMP
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SuperchargeChomped extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o got %vh hand chomped off by %k's supercharger."
     DeathStrings(1)="%k welded some hot spots where %o's lungs used to be."
     DeathStrings(2)="%k's supercharger made a meal out of %o"
     DeathStrings(3)="%%o was shocked to find out that %k's supercharger can weld and chomp at the same time."
     DeathStrings(4)="%k deconstructed %o with %kh supercharger jaws."
     WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
     DeathString="%o got %vh hand chomped off by %k's supercharger."
     FemaleSuicide="%o chomped herself."
     MaleSuicide="%o chomped himself."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     DamageDescription=",Electro,Hazard,Plasma,"
     bDetonatesBombs=False
     bIgniteFires=True
     bDelayedDamage=True
     bCauseConvulsions=True
     GibModifier=15.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=1.050000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.400000
}
