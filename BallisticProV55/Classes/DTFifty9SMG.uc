//=============================================================================
// DTFifty9SMG.
//
// Damage type for the Fifty9 SMG
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFifty9SMG extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k went Fifty-9 on %o."
     DeathStrings(1)="%o was expunged by %k's Fifty-9."
     DeathStrings(2)="%k's Fifty-9 sunk a few rounds into %o."
     DeathStrings(3)="%o got into %k's performance space."
     DeathStrings(4)="%k's Fifty-9 sprayed %o down in style."
     EffectChance=0.500000
     InvasionDamageScaling=1.500000
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.Fifty9MachinePistol'
     DeathString="%k went Fifty9 on %o."
     FemaleSuicide="%o Fifty-9ed herself."
     MaleSuicide="%o Fifty-9ed himself."
     bFastInstantHit=True
     VehicleDamageScaling=0.100000
}
