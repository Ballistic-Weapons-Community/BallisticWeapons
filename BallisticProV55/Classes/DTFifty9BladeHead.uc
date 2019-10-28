//=============================================================================
// DTFifty9BladeHead.
//
// DamageType for the Fifty9 Blade headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTFifty9BladeHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k furiously hacked off %o's head with the Fifty-9."
     DeathStrings(1)="%o's head was shredded by %k's Fifty-9."
     DeathStrings(2)="%k's Fifty-9 found its way into %o's crazy cranium."
     bHeaddie=True
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=40
     AimDisplacementDuration=1.400000
     WeaponClass=Class'BallisticProV55.Fifty9MachinePistol'
     DeathString="%k furiously hacked off %o's head with the Fifty-9."
     FemaleSuicide="%o stabbed herself in the head with her Fifty-9."
     MaleSuicide="%o stabbed himself in the head with his Fifty-9."
     bAlwaysSevers=True
     bSpecial=True
     KDamageImpulse=1000.000000
}
