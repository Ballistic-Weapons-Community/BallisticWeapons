//=============================================================================
// DTChaffGrenade.
//
// Damage type for the MOA-C Chaff grenade impact - It explodes!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MARSGrenadeChaff extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k whipped a MARS grenade at %o's face."
     DeathStrings(1)="%o took %k's explosive smoke grenade to the face."
     SimpleKillString="MARS-2 Grenade"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%k whipped a MARS2 grenade at %o's face."
     FemaleSuicide="%o beat the walls with her grenade like a lunatic."
     MaleSuicide="%o beat the walls with his grenade like a lunatic."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
}
