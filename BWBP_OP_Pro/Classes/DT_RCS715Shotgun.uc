//=============================================================================
// DT_SK410.
//
// Damage type for the HE SK410 shells
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RCS715Shotgun extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was tactically busted by %k's RCS-715."
     DeathStrings(1)="%k shredded %o to pieces with their RCS-715 shells."
     DeathStrings(2)="%k emptied their RCS-715 drum magazine all over %o."
     DeathStrings(3)="%o was met with a barrage of RCS-715 shotgun shells from %k."
     DeathStrings(4)="%o had their nuts busted by %k's RCS-715."
     bIgniteFires=True
     InvasionDamageScaling=2
     DamageIdent="Shotgun"
     DamageDescription=",Bullet,"
     WeaponClass=Class'BWBP_OP_Pro.RCS715Shotgun'
     DeathString="%o was tactically busted by %k's RCS-715."
     FemaleSuicide="%o pointed her RCS-715 the wrong way round."
     MaleSuicide="%o pointed his RCS-715 the wrong way round."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibPerterbation=2.000000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.600000
}
