//=============================================================================
// DT_RSDarkFast.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSDarkFast extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned down %o with a Dark Star."
     DeathStrings(1)="%o was torn into tatters by %k's fiery Dark Star."
     DeathStrings(2)="%o found %vs being incinerated by %k's DarkStar."
     DeathStrings(3)="%k sprayed %o with burning hot Dark Star shots."
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",DarkStar,"
     bOnlySeverLimbs=True
     WeaponClass=Class'BallisticProV55.RSDarkStar'
     DeathString="%k burned down %o with a Dark Star."
     FemaleSuicide="%o destroyed herself with her Dark Star."
     MaleSuicide="%o destroyed himself with his Dark Star."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.200000
}
