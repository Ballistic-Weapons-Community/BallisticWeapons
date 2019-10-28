//=============================================================================
// DTEKS43Katana.
//
// Damagetype for EKS43 Katana
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTEKS43Katana extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k demonstrated sepukku on %o."
     DeathStrings(1)="%k hacked %o open like a tomato."
     DeathStrings(2)="%o was cut down the middle by a blood-crazed %k."
     DeathStrings(3)="%o was sliced and diced by katana-crazy %k."
     DeathStrings(4)="%o disembowelled %vs on %k's sword."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=50
     WeaponClass=Class'BallisticProV55.EKS43Katana'
     DeathString="%k demonstrated seppuku on %o."
     FemaleSuicide="%o tried her hand at sepukku."
     MaleSuicide="%o tried his hand at sepukku."
     bNeverSevers=True
     KDamageImpulse=1000.000000
}
