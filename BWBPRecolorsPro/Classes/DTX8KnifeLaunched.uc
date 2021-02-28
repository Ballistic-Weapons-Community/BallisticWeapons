//=============================================================================
// DTX8KnifeLaunched .
//
// Damagetype for HandLaunched X8 Knife
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX8KnifeLaunched extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's X8 Ballistic Knife reached out and touched %o."
     DeathStrings(1)="%k fired an X8 into %o's chest."
     DeathStrings(2)="%k launched an X8 Ballistic Knife into unwitting %o."
     SimpleKillString="X8 Ballistic Knife Launched"
     bCanBeBlocked=False
     WeaponClass=Class'BWBPRecolorsPro.X8Knife'
     DeathString="%k's X8 Ballistic Knife reached out and touched %o."
     FemaleSuicide="%o shot a knife at herself."
     MaleSuicide="%o shot a knife at himself."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.100000
}
