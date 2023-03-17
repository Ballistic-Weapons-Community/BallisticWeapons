//=============================================================================
// DTBOBTorso.
//
// Damagetype for X5W black ops blade stabs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOBTorso extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k cut open %o with his black ops blade."
     DeathStrings(1)="%k hacked %o to death in a frenzy."
     DeathStrings(2)="%o was cut in half by %k's X5W."
     DeathStrings(3)="%k's X5W split open the chest of %o."
     DeathStrings(4)="%o was brutally chopped by %k's X5W."
     WeaponClass=Class'BWBP_SKC_Pro.BlackOpsWristBlade'
     DeathString="%k cut open %o with his black ops blade."
     FemaleSuicide="%o cut her own heart out."
     MaleSuicide="%o cut his own heart out."
     bArmorStops=False
     bNeverSevers=True
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.500000
}
