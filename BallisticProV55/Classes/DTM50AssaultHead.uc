//=============================================================================
// DTM50AssaultHead.
//
// DamageType for M50 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM50AssaultHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's head was brutally gunned off by %k's M50."
     DeathStrings(1)="%o ate too much of %k's M50 lead."
     DeathStrings(2)="%k annihilated %o's head with the M50."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BallisticProV55.M50AssaultRifle'
     DeathString="%o's head was brutally gunned off by %k with the M50."
     FemaleSuicide="%o saw a bullet coming up the barrel of her M50."
     MaleSuicide="%o saw a bullet coming up the barrel of his M50."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
