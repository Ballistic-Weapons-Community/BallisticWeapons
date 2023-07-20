//=============================================================================
// DTXMV850MGHead.
//
// Damage type for the XMV850 Minigun headshot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMV850MGHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's monster gun tore %o's head off."
     DeathStrings(1)="%o's head was turned to red dust by %k's minigun."
     DeathStrings(2)="%o found %vh cranium being vaporised by %k's XMV-850."
     DeathStrings(3)="%k pumped XMV-850 lead into %o's twitchy head."
     HipString="HIP SPAM"
     bHeaddie=True
     DamageIdent="Machinegun"
     WeaponClass=Class'BallisticProV55.XMV850Minigun'
     DeathString="%k's monster gun tore %o's head off."
     FemaleSuicide="%o minigunned her own head off."
     MaleSuicide="%o minigunned his own head off."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     VehicleDamageScaling=0.600000
}
