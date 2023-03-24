//=============================================================================
// DT_LK05AssaultHead.
//
// DamageType for LK05 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LK05AssaultHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k got a clean LK05 headshot on %o."
     DeathStrings(1)="%k's LK05 headshot reduced %o to a statistic."
     DeathStrings(2)="%k's LK05 turned %o's head into a pink mist."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.LK05Carbine'
     DeathString="%k got a clean LK05 headshot on %o."
     FemaleSuicide="%o took the easy way out."
     MaleSuicide="%o took the easy way out."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.150000
}
