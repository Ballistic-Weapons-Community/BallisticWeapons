//=============================================================================
// DTSRXRifle.
//
// DamageType for the SRS900 Battle Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRXRifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's organs got popped one by one due to %k's SRK."
     DeathStrings(1)="%k ripped %o open with some 7.62mm bullets."
     DeathStrings(2)="%o couldn't adapt to %k's tactics and the SRK."
     DeathStrings(3)="%k blew off %o's toes with precise aiming and the SRK."
     DeathStrings(4)="%o's spleen was ruptured by %k."
     AimedString="Aimed"
     DamageIdent="Sniper"
     WeaponClass=Class'BWBPRecolorsPro.SRXRifle'
     DeathString="%k assasinated %o with %kh SRK-650."
     FemaleSuicide="%o nailed herself with the SRK-650."
     MaleSuicide="%o nailed himself with the SRK-650."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
}
