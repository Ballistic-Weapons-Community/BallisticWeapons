//=============================================================================
// DT_RCS715Frag.
//
// Damage type for RCS-715 Shotgun frag rounds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RCS715Frag extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k fired an explosive slug into a terrified %o."
     DeathStrings(1)="%o took a direct hit from %k's RCS frag."
     DeathStrings(2)="%k tagged and fragged %o with an RCS-715."
     DeathStrings(3)="%k slugged %o out with %kh RCS-715's explosive shell."
     DeathStrings(4)="%k exploded %o's guts out with %kh RCS-715."
     InvasionDamageScaling=2
     DamageIdent="Shotgun, Ordnance"
     WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
     DeathString="%k fired an explosive slug into a terrified %o."
     FemaleSuicide="%o caught her own frag round."
     MaleSuicide="%o caught his own frag round."
     bExtraMomentumZ=True
     GibPerterbation=0.700000
     KDamageImpulse=25000.000000
}
