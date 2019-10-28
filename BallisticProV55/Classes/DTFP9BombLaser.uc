//=============================================================================
// DTFP9BombRadius.
//
// Damage type for the FP9 Bomb radius damage when detonated by laser
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFP9BombLaser extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o wandered towards the pretty light of %k's FP9 laser."
     DeathStrings(1)="%o strayed too near to %k's lurking FP9 laser."
     DeathStrings(2)="%k's FP9 laser turned %o into ketchup."
     DeathStrings(3)="%o did %vh bug impression into %k's FP9 beam."
     DeathStrings(4)="%o accidentally staggered into %k's waiting FP9 beam."
     FemaleSuicides(0)="%o tried to see if her trip mines were working."
     FemaleSuicides(1)="%o didn't know what the pretty blue lights did."
     MaleSuicides(0)="%o tried to see if his trip mines were working."
     MaleSuicides(1)="%o didn't know what the pretty blue lights did."
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BallisticProV55.FP9Explosive'
     DeathString="%o wandered towards the pretty light of %k's FP9 laser."
     FemaleSuicide="%o tried to see if her trip mines were working."
     MaleSuicide="%o tried to see if his trip mines were working."
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
}
