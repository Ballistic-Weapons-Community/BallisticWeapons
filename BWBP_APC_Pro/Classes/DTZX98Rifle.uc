//=============================================================================
// DTZX98Rifle.
//
// Damage type for the ZX-98
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTZX98Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o feared %k's Reaper and was sent to the great beyond."
     DeathStrings(1)="%k harvested %o's soul and organs with the Reaper."
     DeathStrings(2)="%o donated his bullet filled organs to %k's Reaper for science."
	 DeathStrings(3)="%k's Reaper collected %o's life with a hailstorm of lead."
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     DeathString="%o was perforated by %k's ZX-98 fire."
     FemaleSuicide="OH NO YOU SOMEHOW SHOT YOURSELF. WHYYYY."
     MaleSuicide="OH GOD YOU SHOT YOURSELF. HOW DID YOU DO THAT."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
