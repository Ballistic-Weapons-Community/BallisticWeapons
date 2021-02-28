//=============================================================================
// DTLAWShot.
//
// DamageType for jerk faces who shoot the poor defenseless LAW mine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLAWShot extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was loitering near the LAW mine %k blew up."
     DeathStrings(1)="%o happily stood on the LAW mine %k's destabilized."
     DeathStrings(2)="%k blew up a LAW mine and %o came with."
     DeathStrings(3)="%k detonated the LAW mine %o was sitting on."
     FemaleSuicides(0)="%o had the great idea to shoot her glowing LAW rocket."
     FemaleSuicides(1)="%o shot her LAW rocket to see if it worked. It did."
     FemaleSuicides(2)="%o tried to unlock the secrets of her LAW rocket by shooting it."
     MaleSuicides(0)="%o had the great idea to shoot his glowing LAW rocket."
     MaleSuicides(1)="%o shot his LAW rocket to see if it worked. It did."
     MaleSuicides(2)="%o tried to unlock the secrets of his LAW rocket by shooting it."
     SimpleKillString="LAW Mine Detonation"
     InvasionDamageScaling=3.000000
     DamageIdent="Killstreak"
     WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
     DeathString="%o was loitering near the LAW mine %k blew up."
     FemaleSuicide="%o had the great idea to shoot her glowing LAW rocket."
     MaleSuicide="%o had the great idea to shoot his glowing LAW rocket."
     bDelayedDamage=True
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=0.800000
}
