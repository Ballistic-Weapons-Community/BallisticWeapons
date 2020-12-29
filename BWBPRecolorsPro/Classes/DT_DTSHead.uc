//=============================================================================
// DT_DTSHead.
//
// Damagetype for nanosword decapitations.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_DTSHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's Dragon's Tooth Sword bit off %o's head."
     DeathStrings(1)="%k swung %kh nanosword through %o's neck."
     DeathStrings(2)="%o's head was lopped off by %k's speeding DTS."
     DeathStrings(3)="%o was decapitated by %k's lethal nanosword."
     bHeaddie=True
     DamageIdent="Melee"
     WeaponClass=Class'BWBPRecolorsPro.DragonsToothSword'
     DeathString="%k's Dragon's Tooth Sword bit off %o's head."
     FemaleSuicide="%o swung her Dragon's Tooth like a fool."
     MaleSuicide="%o swung his Dragon's Tooth like a fool."
     bAlwaysSevers=True
     bSpecial=True
	 BlockFatiguePenalty=0.1
     PawnDamageSounds(0)=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     KDamageImpulse=1000.000000
}
