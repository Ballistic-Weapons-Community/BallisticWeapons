//=============================================================================
// DTA73BSkrithHead.
//
// Damage type for A73B headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90SkrithHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's Vulture went straight for %o's eyes and plucked them out."
     DeathStrings(1)="%o's face was ripped off due to %k's boltcaster."
     DeathStrings(2)="%k turned %o's head into dust with an explosive headshot."
     DeathStrings(3)="%o caught %k's explosive plasma bolt with his teeth."
	 DeathStrings(4)="%k gave %o a smiley face made out of multiple plasma bolts."
	 DeathStrings(5)="%o's noggin was a perfect target for %k to practice some archery."
     BloodManagerName="BWBP_SKCExp_Pro.BloodMan_A73B"
     bIgniteFires=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKCExp_Pro.AY90SkrithBoltcaster'
     DeathString="%k burned through %o's scalp with the AY90."
     FemaleSuicide="%o's AY90 turned on her."
     MaleSuicide="%o's AY90 turned on him."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
