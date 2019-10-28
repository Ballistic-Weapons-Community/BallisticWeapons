//=============================================================================
// DT_HVCRedLightning.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_HVCRedLightning extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was torn apart by %k's fiery red lightning."
     DeathStrings(1)="%o's unfortunate head was seared off by %k's red lightning."
     DeathStrings(2)="%k ruthlessly charred %o with red lightning."
     DeathStrings(3)="%k's burning red lightning surged into %o's chest."
     DeathStrings(4)="%k exerted the wrath of Satan on %o."
     SimpleKillString="HVC-Mk9 Lightning Charged"
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     FlashThreshold=0
     FlashV=(X=2000.000000,Y=600.000000,Z=600.000000)
     FlashF=0.300000
     ShieldDamage=15
     bIgniteFires=True
     InvasionDamageScaling=3.000000
     DamageIdent="Streak"
     DamageDescription=",Electro,"
     WeaponClass=Class'BallisticProV55.HVCMk9LightningGun'
     DeathString="%o was torn apart by %k's fiery red lightning."
     FemaleSuicide="%o was struck down by the hand of Satan."
     MaleSuicide="%o was struck down by the hand of Satan."
     bInstantHit=True
     bCauseConvulsions=True
     bExtraMomentumZ=True
     bFlaming=True
     GibModifier=1.500000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.PlayerTransRed'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
     VehicleDamageScaling=1.500000
}
