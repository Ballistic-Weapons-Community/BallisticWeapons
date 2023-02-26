//=============================================================================
// DTFifty9SMGHead.
//
// Damage type for the Fifty9 SMG Headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFifty9SMGHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k Fifty-9ed %o's head."
     DeathStrings(1)="%o's head was put aside by %k's Fifty-9."
     DeathStrings(2)="%k's Fifty-9 shoved lead into %o's terrified face."
     DeathStrings(3)="%o got a faceful of %k's Fifty-9 light show."
     EffectChance=0.500000
     bHeaddie=True
	 InvasionDamageScaling=1.5
     DamageIdent="SMG"
     WeaponClass=Class'BallisticProV55.Fifty9MachinePistol'
     DeathString="%k Fifty-9ed %o's head."
     FemaleSuicide="%o Fifty-9ed her head off."
     MaleSuicide="%o Fifty-9ed his head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     VehicleDamageScaling=0.000000
}
