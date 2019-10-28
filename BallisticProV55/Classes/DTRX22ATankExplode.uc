//=============================================================================
// DTRX22AImmolation.
//
// Damage type for players caught alight by the RX22A Flamer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTRX22ATankExplode extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%k sent %o to hell with a jetpack."
     DeathStrings(1)="%o's flame tanks were erupted by %k."
     DeathStrings(2)="%k rocketed %o into oblivion."
     BloodManagerName="BallisticProV55.BloodMan_FireExploded"
     InvasionDamageScaling=3.000000
     DamageIdent="Streak"
     WeaponClass=Class'BallisticProV55.RX22AFlamer'
     DeathString="%k sent %o to hell with a jetpack."
     FemaleSuicide="%o's tank exploded."
     MaleSuicide="%o's tank exploded."
     bCausesBlood=True
     bDelayedDamage=True
     bNeverSevers=False
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
     VehicleDamageScaling=1.250000
}
