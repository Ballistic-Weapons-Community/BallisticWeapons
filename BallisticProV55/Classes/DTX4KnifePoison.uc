//=============================================================================
// DTX4KnifePoisonBal.
//
// DamageType for the X4 knife poisoning
//
// Originally by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Modified by Kaboodles
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTX4KnifePoison extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's X4 Knife injected %o with a lethal dose of poison."
     DeathStrings(1)="%o suffered an agonizing death from %k's poisoned blade."
     DeathStrings(2)="%k's X4 Knife venom eventually overcame %o's fragile constitution."
     DamageDescription=",Poison,GearSafe,NonSniper,"
     WeaponClass=Class'BallisticProV55.X4Knife'
     DeathString="%k's X4 knife poisoned %o to an agonizing death."
     FemaleSuicide="%o pricked herself with her X4 Knife and was subsequently poisoned to death."
     MaleSuicide="%o pricked himself with his X4 Knife and was subsequently poisoned to death."
     bArmorStops=False
     bLocationalHit=False
     bCausesBlood=False
     bCauseConvulsions=True
     bDelayedDamage=True
     bNeverSevers=True
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LinkHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.000000
}
