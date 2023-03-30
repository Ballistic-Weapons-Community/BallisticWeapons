//=============================================================================
// DTScarabGrenade.
//
// Damage type for the NRP57 Grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTScarabGrenadeCluster extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o had a plague of explosive scarabs brought down by %k."
     DeathStrings(1)="%k's swarm of scarabs devoured %o alive."
     DeathStrings(2)="%o couldn't outrun %k's swarm and was eaten up as a result."
     DeathStrings(3)="%k caught %o in a storm of cluster bombs, the hidden 11th plague."
     DeathStrings(4)="%o had %vh shins shredded by %k's cluster bombs."
     BloodManagerName="BallisticProV55.BloodMan_BluntSmall"
     bDetonatesBombs=False
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     DamageDescription=",Blunt,Hazard,"
     WeaponClass=Class'BWBP_APC_Pro.ScarabGrenade'
     DeathString="%k rammed a pineapple down %k's throat."
     FemaleSuicide="%o held onto their explosive treasure a bit too long."
     MaleSuicide="%o became a meal for their own swarm of Scarabs."
     bDelayedDamage=True
     GibPerterbation=0.500000
     KDamageImpulse=20000.000000
}
