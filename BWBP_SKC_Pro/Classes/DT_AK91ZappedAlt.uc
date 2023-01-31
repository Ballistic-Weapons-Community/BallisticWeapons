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
     DeathStrings(0)="%o was dumped on by %k's AK91 lightning emissions."
     DeathStrings(1)="%k's AK91 unloaded its feelings and excess electricity onto a hapless %o."
     DeathStrings(2)="%o is the new recipient of a shockingly powerful emulsion from %k's AK."
     DeathStrings(3)="%k gave %o unlimited power, unlimited excruciatingly deadly power."
     DeathStrings(4)="%o performed a new interpretive dance after being shocked to death by %k's AK91."
     DeathStrings(5)="%o made a great heat sink for %k's AK91."
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
