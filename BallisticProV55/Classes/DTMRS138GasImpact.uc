//=============================================================================
// DTMRS138GasImpact.
//
// Damage type for killing someone with a non lethal gas slug.
// Enjoy the paperwork!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTMRS138GasImpact extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k non-lethally shot a gas slug into %o's eye."
     DeathStrings(1)="%o was pacified by %k's gas slug gut shot."
     DeathStrings(2)="%k subdued %o with an MRS gas slug to the kidneys."
     DeathStrings(3)="%o learned that %k's non-lethal gas slugs still hurt."
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.MRS138Shotgun'
     DeathString="%k non-lethally shot a gas slug into %o's eye."
     FemaleSuicide="%o killed herself with a non-lethal gas slug."
     MaleSuicide="%o killed himself with a non-lethal gas slug."
     bExtraMomentumZ=True
     GibPerterbation=0.400000
     KDamageImpulse=25000.000000
}
