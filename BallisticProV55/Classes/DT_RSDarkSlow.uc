//=============================================================================
// DT_RSDarkSlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSDarkSlow extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k obliterated %o with %kh Dark Star."
     DeathStrings(1)="%o was sent to Satan's domain with %k's Dark shots."
     DeathStrings(2)="%k completely annihilated %o in a fiery DarkStar frenzy."
     DeathStrings(3)="%o got %vs smelted by %k's Dark Star."
     SimpleKillString="Dark Star Bolt"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",DarkStar,"
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%k obliterated %o %kh Dark Star."
     FemaleSuicide="%o nebulised herself with a Dark Star."
     MaleSuicide="%o nebulised himself with a Dark Star."
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.200000
}
