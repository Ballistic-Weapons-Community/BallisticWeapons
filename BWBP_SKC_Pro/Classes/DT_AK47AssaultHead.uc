//=============================================================================
// DT_AK47AssaultHead.
//
// DamageType for AK490 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AK47AssaultHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's face was rearranged by Comrade %k's AK490."
     DeathStrings(1)="%k executed a rebellious %o with an AK headshot."
     DeathStrings(2)="%k blew the Borscht out of %o's head with an AK490."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.AK47AssaultRifle'
     DeathString="%o's face was rearranged by Comrade %k's AK490."
     FemaleSuicide="%o shot heads with bullets."
     MaleSuicide="%o exploded in a shower of laser."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
