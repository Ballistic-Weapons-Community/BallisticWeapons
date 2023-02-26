//=============================================================================
// DTM46AssaultHead.
//
// DamageType for M46 headshots
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM46AssaultQSHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's head was ripped off by %k's Jackal rifle."
     DeathStrings(1)="%k pulled out %kh M46 and %o's head fell off in terror."
     DeathStrings(2)="%o got %vh head blown clean off by %k's M46 assault rifle."
     bHeaddie=True
     DamageIdent="Assault"
     WeaponClass=Class'BallisticProV55.M46AssaultRifle'
     DeathString="%o's head was ripped of by %k's Jackal rifle."
     FemaleSuicide="%o looked down the mouth of her Jackal."
     MaleSuicide="%o looked down the mouth of his Jackal."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
