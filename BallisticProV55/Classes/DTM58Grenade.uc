//=============================================================================
// DTM58Grenade.
//
// Damage type for the M58 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM58Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bounced an M58 off %o's head."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.M58Grenade'
     DeathString="%k bounced an M58 off %o's head."
     FemaleSuicide="%o tripped on her own M58."
     MaleSuicide="%o tripped on his own M58."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
