//=============================================================================
// DTSRXRifleHead.
//
// DamageType for SRS900 Battle Rifle headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRXRifleHead_Incendiary extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o had their skull emptied out of anything vital by %k."
     DeathStrings(1)="%k did a Pollock tribute by using an explosive SRK and %o's blood."
     DeathStrings(2)="%o forgot that explosive bullets are bad, %k reminded them that with one to the head."
     DeathStrings(3)="%k blew up %o's game and their brains with a SRK."
	 bIgniteFires=True
	 EffectChance=1.000000
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
	 DamageDescription=",Bullet,Flame,Hazard,"
     AimedString="Scoped"
     bHeaddie=True
     DamageIdent="Sniper"
     WeaponClass=Class'BWBP_SKC_Pro.SRXRifle'
     DeathString="%k assasinated %o's head with %kh SRK-650."
     FemaleSuicide="%o found that using an explosive SRK as toenail clippers is a bad idea."
     MaleSuicide="%o couldn't use the SRK as a rocket jump tool, found that out the hard way."
     bFastInstantHit=True
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=SoundGroup'BW_Core_WeaponSound.BulletImpacts.Headshot'
     GibModifier=1.500000
     GibPerterbation=0.500000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.000000
}
