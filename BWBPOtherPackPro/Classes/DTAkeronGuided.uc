//=============================================================================
// DTM50GrenadeRadius.
//
// Damage type for the M900 grenade fired from the M50
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAkeronGuided extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k callously flew his rocket into %o's face."
     DeathStrings(1)="%o was hunted and killed by %k's roving rocket."
     DeathStrings(2)="%o tragically failed to spot %k's marauding missile."
     SimpleKillString="AN-56 Akeron Guided"
     InvasionDamageScaling=3
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBPOtherPackPro.AkeronLauncher'
     DeathString="%k callously flew his rocket into %o's face."
     FemaleSuicide="%o took a selfie with an Akeron guided rocket."
     MaleSuicide="%o took a selfie with an Akeron guided rocket."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
