//=============================================================================
// DT_NukeRadius.
//
// DamageType for the poor bastards who actually get hit with the nuke explosion
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_NukeRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o stared into the horrifying nuclear fires of %k."
     DeathStrings(1)="%o is gone with %k's blastwave. Nuclear blastwave."
     DeathStrings(2)="%k's romantically apocalyptic world doesn't have %o in it."
     DeathStrings(3)="%k went all Three Mile Island on %o."
     DeathStrings(4)="%k went all Cuban Missile Crisis on %o."
     DeathStrings(5)="%k went all Chernobyl on %o."
     DeathStrings(6)="%k went all Hiroshima on %o."
     DeathStrings(7)="%k escalated %o's nuclear cold war."
     FemaleSuicides(0)="%o probably should have shot her nuke more than 10 feet away."
     FemaleSuicides(1)="%o used the ultimate suicide bomb."
     FemaleSuicides(2)="%o authorized his nuke for all the wrong reasons."
     MaleSuicides(0)="%o probably should have shot his nuke more than 10 feet away."
     MaleSuicides(1)="%o used the ultimate suicide bomb."
     MaleSuicides(2)="%o authorized his nuke for all the wrong reasons."
     MaleSuicides(3)="%o brought a nuke to a wall fight."
     WeaponClass=Class'BWBP_KFC_DE.M807Pistol'
     DeathString="%o stared into the horrifying nuclear fires of %k."
     FemaleSuicide="%o probably should have shot her nuke more than 10 feet away."
     MaleSuicide="%o probably should have shot his nuke more than 10 feet away."
     bSuperWeapon=True
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=0.800000
}
