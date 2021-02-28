//=============================================================================
// DTChaffGrenade.
//
// Damage type for the MOA-C Chaff grenade impact - It explodes!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTChaffGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k whipped a smoke grenade at %o's face."
     DeathStrings(1)="%o took %k's explosive smoke grenade to the face."
     WeaponClass=Class'BWBPRecolorsPro.ChaffGrenadeWeapon'
     DeathString="%k whipped a smoke grenade at %o's face."
     FemaleSuicide="%o beat the walls with her grenade like a lunatic."
     MaleSuicide="%o beat the walls with his grenade like a lunatic."
     bDelayedDamage=True
     VehicleDamageScaling=0.500000
}
