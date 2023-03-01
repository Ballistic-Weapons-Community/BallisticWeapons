//=============================================================================
// DTGRS9PistolHead.
//
// Damage type for GRS9 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRS9PistolHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's head was objected to by %k's GRS-9."
     DeathStrings(1)="%k's GRS-9 liquidated %o's head."
     DeathStrings(2)="%o's head was struck off the role by %k's GRS-9."
     DeathStrings(3)="%k litigated %o's head off."
     bHeaddie=True
     DamageIdent="Pistol"
	 InvasionDamageScaling=1.5
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%k litigated %o's head off."
     FemaleSuicide="%o litigated her own head off."
     MaleSuicide="%o litigated his own head off."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
