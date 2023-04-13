//=============================================================================
// DT_AK91Zapped.
//
// Damage type for AK91 zaps
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK91Zapped extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o had %vh death engineered by %k's reverse-engineered AK."
     DeathStrings(1)="%k unleashed some bolts of lightning unto %o with an AK."
     DeathStrings(2)="%o shouldn't have laughed at %k and %kh modified AK, now %ve are dead."
     DeathStrings(3)="%k's AK91 wasn't so good for %o's spleen, turns out 5 bullets is 5 bullets too many."
     DeathStrings(4)="%o collapsed under the reverse-engineered might of %k and %kh AK."
     DeathStrings(5)="%k overcharged %o, but not with money, rather with bullets."
     WeaponClass=Class'BWBP_SKC_Pro.AK91ChargeRifle'
     DeathString="%k stopped %o's heart with an AK91."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     DamageDescription=",Electro,Hazard,Plasma,"
     bDetonatesBombs=False
     bIgniteFires=True
     bDelayedDamage=True
     bCauseConvulsions=True
     GibModifier=5.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=0.400000
}
