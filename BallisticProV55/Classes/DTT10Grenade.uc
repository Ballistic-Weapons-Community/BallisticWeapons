//=============================================================================
// DTT10Grenade.
//
// Damage type for the T10 Grenade hit
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTT10Grenade extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k bounced a T10 off %o's head."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     DamageIdent="Grenade"
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BallisticProV55.T10Grenade'
     DeathString="%k bounced a T10 off %o's head."
     FemaleSuicide="%o tripped on her own T10."
     MaleSuicide="%o tripped on his own T10."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
