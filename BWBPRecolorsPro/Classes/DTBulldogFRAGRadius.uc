//=============================================================================
// DTBulldogFRAGRadius.
//
// DamageType for the FRAG-12 radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBulldogFRAGRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o bit the explosive end of %k's FRAG-12."
     DeathStrings(1)="%o's organs were relocated by %k's FRAG-12."
     DeathStrings(2)="%k fragged %o real good with a FRAG-12."
     DeathStrings(3)="%k's FRAG-12 reduced %o to bloody paste."
     FemaleSuicides(0)="%o's FRAG-12 rocket jump ended in disaster."
     FemaleSuicides(1)="%o forgot that FRAG-12s explode."
     FemaleSuicides(2)="%o couldn't control her Bulldog's explosives."
     MaleSuicides(0)="%o's FRAG-12 rocket jump ended in disaster."
     MaleSuicides(1)="%o forgot that FRAG-12s explode."
     MaleSuicides(2)="%o couldn't control his Bulldog's explosives."
     SimpleKillString="Bulldog FRAG-12"
     InvasionDamageScaling=1.500000
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBPRecolorsPro.BulldogAssaultCannon'
     DeathString="%k fragged %o real good with a FRAG-12."
     FemaleSuicide="%o forgot that FRAG-12s explode."
     MaleSuicide="%o forgot that FRAG-12s explode."
     bDelayedDamage=True
}
