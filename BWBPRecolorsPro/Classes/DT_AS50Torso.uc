//=============================================================================
// DT_AS50Torso
//
// Damage type for FSSG-50 ammunition
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AS50Torso extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o noticed %k's FSSG-50 scope glint a second too late."
     DeathStrings(1)="%k stopped %o's heart with an accurate FSSG-50 round."
     DeathStrings(2)="%k took %o out with a FSSG-50 round to center of mass."
     DeathStrings(3)="%k introduced %o to the business end of %kh FSSG-50."
     AimedString="Scoped"
     bIgniteFires=True
     DamageIdent="Sniper"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.AS50Rifle'
     DeathString="%o noticed %k's FSSG-50 scope glint a second too late."
     FemaleSuicide="%o's FSSG-50 didn't like the look of its owner."
     MaleSuicide="%o's FSSG-50 didn't like the look of its owner."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.500000
}
