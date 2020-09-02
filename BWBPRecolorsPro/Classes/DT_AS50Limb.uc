//=============================================================================
// DT_AS50Limb
//
// DamageType for FSSG50 Limb Hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AS50Limb extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's FSSG-50 round ripped an arm off %o."
     DeathStrings(1)="%k missed %o's head, but %kh FSSG still got an arm."
     DeathStrings(2)="%k's FSSG-50 made %o's legs a little more stumpy."
     DeathStrings(3)="%k crippled %o with an accurate FSSG-50 shot."
     AimedString="Scoped"
     bIgniteFires=True
     DamageIdent="Sniper"
	 InvasionDamageScaling=1.5
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.AS50Rifle'
     DeathString="%k's FSSG-50 round ripped an arm off %o."
     FemaleSuicide="%o did some self amputation with an FSSG-50."
     MaleSuicide="%o did some self amputation with an FSSG-50."
     bFastInstantHit=True
     bExtraMomentumZ=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.500000
}
