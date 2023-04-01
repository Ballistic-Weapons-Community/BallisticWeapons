//=============================================================================
// DT_NukePiercingRadius.
//
// DamageType for the full scale nukes when they rape you through walls
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_NukePiercingRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o incorrectly thought a small wall would stop %k's massive nuke!"
     DeathStrings(1)="%o ducked and covered but was anihilated by %k's nuke!"
     DeathStrings(2)="%k inadvertantly atomized %o during routine nuclear testing."
     DeathStrings(3)="%o couldn't quite escape %k's nuclear blast zone!"
     DeathStrings(4)="%k brought down nuclear hell on %o distant head."
     DeathStrings(5)="%o's fight was interrupted by %k's nuclear explosion."
     FemaleSuicides(0)="%o learned that in a nuclear war, nobody wins."
     FemaleSuicides(1)="%o frolicked in her nuclear blast zone."
     FemaleSuicides(2)="%o had a tactical nuclear error."
     MaleSuicides(0)="%o learned that in a nuclear war, nobody wins."
     MaleSuicides(1)="%o frolicked in his nuclear blast zone."
     MaleSuicides(2)="%o had a tactical nuclear error."
     WeaponClass=Class'BWBP_KFC_DE.M807Pistol'
     DeathString="%o incorrectly thought a small wall would stop %k's massive nuke!"
     FemaleSuicide="%o learned that in a nuclear war, nobody wins."
     MaleSuicide="%o learned that in a nuclear war, nobody wins."
     bDelayedDamage=True
     VehicleDamageScaling=0.900000
     VehicleMomentumScaling=0.800000
}
