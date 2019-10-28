//=============================================================================
// DTleMatShotgun.
//
// Damage type for Wilson DB Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTleMatShotgun extends DT_BWShell;

defaultproperties
{
     DeathStrings(0)="%k blasted sixteen ounces of lead into %o."
     DeathStrings(1)="%k fired %kh desperate shot at %o."
     DeathStrings(2)="%o didn't realize %k had one more shot."
     DeathStrings(3)="%o tried to run away from a duel, but %k didn't let %vm."
     DeathStrings(4)="%o got three paces before %k's desperate shot when off in %vh back."
     SimpleKillString="Wilson 41 Shotgun"
     DamageIdent="Shotgun"
     WeaponClass=Class'BallisticProV55.leMatRevolver'
     DeathString="%k blasted sixteen ounces of lead into %o."
     FemaleSuicide="%o nailed herself with the Wilson 41."
     MaleSuicide="%o nailed himself with the Wilson 41."
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=0.000000
     VehicleMomentumScaling=0.000000
}
