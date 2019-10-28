//=============================================================================
// DTFP9BombRadius.
//
// Damage type for the FP9 Bomb radius damage
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFP9BombRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k detonated %o with %kh FP9 bomb."
     DeathStrings(1)="%o got to close to %k's FP9 bomb."
     DeathStrings(2)="%o stumbled across %k's happy package."
     DeathStrings(3)="%k dropped a bomb into %o's happy place."
     FemaleSuicides(0)="%o forgot where she left her bombs."
     FemaleSuicides(1)="%o detonated her feet off."
     FemaleSuicides(2)="%o tested out her FP9 detonator on a nearby bomb."
     FemaleSuicides(3)="%o just couldn't stop clicking her FP9 detonator."
     MaleSuicides(0)="%o forgot where he left his bombs."
     MaleSuicides(1)="%o detonated his feet off."
     MaleSuicides(2)="%o tested out his FP9 detonator on a nearby bomb."
     MaleSuicides(3)="%o just couldn't stop clicking his FP9 detonator."
     bDetonatesBombs=False
     InvasionDamageScaling=3.000000
     DamageIdent="Grenade"
     WeaponClass=Class'BallisticProV55.FP9Explosive'
     DeathString="%k detonated %o with %kh FP9 bomb."
     FemaleSuicide="%o's FP9 blew up in her face."
     MaleSuicide="%o's FP9 blew up in his face."
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
}
