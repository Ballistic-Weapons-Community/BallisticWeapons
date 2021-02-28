//=============================================================================
// DTSRXRifle.
//
// DamageType for the SRS900 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRXRifle_Incendiary extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o had their bones broken by %k's explosive SRK."
     DeathStrings(1)="%k brought some 7.62 dynamite on %o, they went boom in response."
     DeathStrings(2)="%o couldn't dance even after %k gave them some explosive encouragement."
     DeathStrings(3)="%k blew off %o's bad kneecaps, doing them a solid."
	 bIgniteFires=True
	 EffectChance=1.000000
     BloodManagerName="BallisticFix.BloodMan_GRS9Laser"
	 DamageDescription=",Bullet,Flame,Hazard,"
     AimedString="Scoped"
     DamageIdent="Sniper"
     WeaponClass=Class'BWBPRecolorsPro.SRXRifle'
     DeathString="%k assasinated %o with %kh SRK-650."
     FemaleSuicide="%o found that using an explosive SRK as toenail clippers is a bad idea."
     MaleSuicide="%o couldn't use the SRK as a rocket jump tool, found that out the hard way."
     bFastInstantHit=True
	 GibModifier=1.500000
     GibPerterbation=0.500000
     KDamageImpulse=3000.000000
}
