//=============================================================================
// DTFP7Held.
//
// Damage type for fire from held FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTARHeld extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k lurched onto %o in a ball of flames."
     DeathStrings(1)="%k killed %o with a self propelled inferno."
     FemaleSuicides(0)="%o successfully seared off her hands."
     FemaleSuicides(1)="%o erupted in a shower of flames."
     MaleSuicides(0)="%o successfully seared off his hands."
     MaleSuicides(1)="%o erupted in a shower of flames."
     InvasionDamageScaling=2.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBPOtherPackPro.ARShotgun'
     DeathString="%k lurched onto %o in a ball of flames."
     FemaleSuicide="%o successfully seared off her hands."
     MaleSuicide="%o successfully seared off his hands."
     bSkeletize=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
}
