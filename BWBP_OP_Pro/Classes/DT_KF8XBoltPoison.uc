//=============================================================================
// DT_KF8XBoltPoison.
//
// DamageType for the KF8X dart poisoning
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_KF8XBoltPoison extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's KF-8X bolt delivered a lethal toxic dose to %o."
     DeathStrings(1)="%o succumbed to %k's toxic bolts."
     DeathStrings(2)="%k's xbow poison eventually overcame %o's fragile constitution."
     SimpleKillString="KF-8X Poison"
     DamageDescription=",Poison,GearSafe,NonSniper,"
     WeaponClass=Class'BWBP_OP_Pro.KF8XCrossbow'
     DeathString="%k's KF-8X bolt delivered a lethal toxic dose to %o."
     FemaleSuicide="%o pricked herself with a KF-8X bolt."
     MaleSuicide="%o pricked himself with a KF-8X dart."
     bArmorStops=False
     bFastInstantHit=True
     bDirectDamage=True
     bCausesBlood=False
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BWBP_OP_Sounds.XBow.BX85-Poison'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
}
