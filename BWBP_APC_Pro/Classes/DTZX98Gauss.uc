//=============================================================================
// DTZX98Rifle.
//
// Damage type for the ZX-98
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZX98Gauss extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was gaussed to the point of no return by %k's Reaper."
     DeathStrings(1)="%k opened several wormholes into %o's torso."
     DeathStrings(2)="%o was ferried to the afterlife, %k's gauss powered reaper helped speed it along."
     DeathStrings(3)="%k took %o's soul using newfound gauss technology."
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     DeathString="%o was perforated by %k's ZX-98 fire."
     FemaleSuicide="OH NO YOU SOMEHOW SHOT YOURSELF. WHYYYY."
     MaleSuicide="OH GOD YOU SHOT YOURSELF. HOW DID YOU DO THAT."
     bFastInstantHit=True
     GibPerterbation=0.200000
     KDamageImpulse=3000.000000
}
