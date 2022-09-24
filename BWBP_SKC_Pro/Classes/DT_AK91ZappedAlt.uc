//=============================================================================
// DT_AK91Zapped.
//
// Damage type for AK91 zaps
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK91ZappedAlt extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was dumped on by %k's lightning emissions from an AK97."
     DeathStrings(1)="%k had to unload their feelings and lightning bolts onto a hapless %o."
     DeathStrings(2)="%o is now the new recipient of a shockingly powerful emulsion from %k's AK."
     DeathStrings(3)="%k gave %o unlimited power, and by unlimited power, they were fried by lightning."
     DeathStrings(4)="%o made a new form of interpretive dance after being shocked tod earth by %k."
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
