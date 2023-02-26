//=============================================================================
// DT_LK05SilAssaultHead.
//
// DamageType for _LK050 Silent Headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LK05SilAssaultHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's head was picked off by %k's silent LK05."
     DeathStrings(1)="%o throughts were silenced by %k's LK05."
     DeathStrings(2)="%k's LK05 spat death in %o's face."
     SimpleKillString="LK-05 Advanced Carbine Suppressed"
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.LK05Carbine'
     DeathString="%o's head was picked off by %k's silent LK05."
     FemaleSuicide="%o saw a bullet coming up the barrel of her LK05."
     MaleSuicide="%o saw a bullet coming up the barrel of his LK05."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
