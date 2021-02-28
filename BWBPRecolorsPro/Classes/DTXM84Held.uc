//=============================================================================
// DTXM84Held.
//
// Damage type for unreleased XM84
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXM84Held extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k blew off %kh hand and parts of %o."
     DeathStrings(1)="%o joined %k in %kh tactical suicide."
     DeathStrings(2)="%k decided to share his XM84 with %o."
     FemaleSuicides(0)="%o didn't realize her XM84 was on."
     FemaleSuicides(1)="%o threw the pin and not the grenade."
     MaleSuicides(0)="%o didn't realize his XM84 was on."
     MaleSuicides(1)="%o threw the pin and not the grenade."
     FlashThreshold=0
     FlashV=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     FlashF=-0.600000
     DamageIdent="Grenade"
     MinMotionBlurDamage=1.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=9.000000
     bUseMotionBlur=True
     WeaponClass=Class'BWBPRecolorsPro.XM84Flashbang'
     DeathString="%k blew off %kh hand and parts of %o."
     FemaleSuicide="%o held her XM84 to the bitter end."
     MaleSuicide="%o refused to drop his XM84."
     bArmorStops=False
     bCauseConvulsions=True
     bNeverSevers=True
     GibModifier=0.500000
     GibPerterbation=0.900000
}
