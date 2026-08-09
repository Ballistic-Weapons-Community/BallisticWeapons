//=============================================================================
// DTSKASFRAG.
//
// DamageType for the SKAS direct hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSKASFRAG extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k launched a FRAG-12 at hapless %o ."
     DeathStrings(1)="%o was the lucky recipient of %k's FRAG-12."
     DeathStrings(2)="%k's FRAG-12 whizzed right into %o's face."
     SimpleKillString="SKAS FRAG-12"
     InvasionDamageScaling=2
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDuration=0.400000
     WeaponClass=Class'BWBP_SKC_Pro.SKASShotgun'
     DeathString="%o was the lucky recipient of %k's FRAG-12."
     FemaleSuicide="%o launched a FRAG-12 and ran screaming after it."
     MaleSuicide="%o ran screaming into the path of his own FRAG-12."
     bDelayedDamage=True
}
