//=============================================================================
// DTA909Blades.
//
// Damagetype for A909 Blades
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA909Blades extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k did %kh Skrith impression on %o."
     DeathStrings(1)="%k hacked %o to pieces in a wild frenzy."
     DeathStrings(2)="%k turned %o into sushi."
     DeathStrings(3)="%o was filleted by %k's A909 blades."
     DeathStrings(4)="%k savagely skinned %o with %kh Skrith Blades."
     DamageIdent="Melee"
     DamageDescription=",Stab,Slash,"
     WeaponClass=Class'BallisticProV55.A909SkrithBlades'
     DeathString="%k did %kh Skrith impression on %o."
     FemaleSuicide="%o stabbed herself with her A909 blades."
     MaleSuicide="%o stabbed himself with his A909 blades."
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
