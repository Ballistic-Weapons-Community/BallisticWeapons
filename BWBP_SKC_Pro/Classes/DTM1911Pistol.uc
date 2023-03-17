//=============================================================================
// DTGRSXXPistol.
//
// Damage type for the Colt M1911 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM1911Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k shot %o down in %vh prime with his RS04."
     DeathStrings(1)="%o couldn't escape %k's RS04."
     DeathStrings(2)="%k's RS04 sent %o home in a body bag."
     WeaponClass=Class'BWBP_SKC_Pro.RS04Pistol'
     DeathString="%k shot down %o in %vh prime with his RS04."
     FemaleSuicide="%o somehow shot herself."
     MaleSuicide="%o managed to shoot himself."
     VehicleDamageScaling=0.500000
}
