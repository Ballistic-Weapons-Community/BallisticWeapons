//=============================================================================
// DTM806PistolHead.
//
// Damage type for the M806 Pistol headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTM806PistolHead extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was decapitated by %k with the M806."
     DeathStrings(1)="%k beheaded %o with %kh M806."
     bHeaddie=True
     WeaponClass=Class'BallisticProV55.M806Pistol'
     DeathString="%o was decapitated by %k with the M806."
     FemaleSuicide="%o peered down the barrel of her M806."
     MaleSuicide="%o peered down the barrel of his M806."
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
}
