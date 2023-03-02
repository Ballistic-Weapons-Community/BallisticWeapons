//=============================================================================
// DTXMVCHEAT.
//
// Damage type for people who fire at high speeds while moving.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMVCHEAT extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was gunned down by %k's XMB-500."
     DeathStrings(1)="%k filled %o with XMB-500 lead."
     DeathStrings(2)="%o was shredded by %k's XMB-500 minigun."
     DeathStrings(3)="%o was at the business end of %k's minigun."
     FemaleSuicides(0)="%o forgot to read her XMB instruction manual."
     FemaleSuicides(1)="%o broke her wrists with a malfunctioning XMB-500."
     FemaleSuicides(2)="%o tried firing an uncontrollable XMB-500."
     MaleSuicides(0)="%o forgot to read his XMB instruction manual."
     MaleSuicides(1)="%o broke his wrists with a malfunctioning XMB-500."
     MaleSuicides(2)="%o tried firing an uncontrollable XMB-500."
     WeaponClass=Class'BWBP_SKCExp_Pro.XMV500Minigun'
     DeathString="%o was gunned down by %k's XMB-500."
     FemaleSuicide="%o forgot to read her XMB instruction manual."
     MaleSuicide="%o forgot to read his XMB instruction manual."
     bArmorStops=False
     bCausesBlood=False
     VehicleDamageScaling=0.100000
     VehicleMomentumScaling=0.050000
}
