//=============================================================================
// DTleMatRevolver.
//
// Damage type for the Wilson DB Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTleMatRevolver extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was mattered by %k."
     DeathStrings(1)="%o was handed a whuppin' by %k."
     DeathStrings(2)="%k inaugurated %o with %kh Wilson 41."
     DeathStrings(3)="%k shot %o with %kh duelling gun."
     DeathStrings(4)="%o was outduelled by %k."
     DeathStrings(5)="%k politely dropped %o with %kh Wilson 41."
     DeathStrings(6)="le%k mattered %o."
     DamageIdent="Pistol"
     WeaponClass=Class'BallisticProV55.leMatRevolver'
     DeathString="le%k mattered %o."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=0.000000
}
