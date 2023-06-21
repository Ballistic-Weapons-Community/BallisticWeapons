//=============================================================================
// DT_AK91Zapped.
//
// Well done, you blew it up
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SuperchargeOverheat extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="%o was overheated by %k."
     DeathStrings(1)="%k overcharged %kh supercharger in %o's face."
     FemaleSuicides(0)="%o shocked herself with a supercharger."
     FemaleSuicides(1)="%o unsafely charged a supercharger."
     FemaleSuicides(2)="%o short circuited her supercharger."
     MaleSuicides(0)="%o shocked himself with a supercharger."
     MaleSuicides(1)="%o unsafely charged a supercharger."
     MaleSuicides(2)="%o short circuited his supercharger."
	 WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
	 DeathString="%k stopped %o's heart with a supercharger."
	 FemaleSuicide="%o shocked herself with a supercharger."
	 MaleSuicide="%o shocked himself with a supercharger."
	 BloodManagerName="BallisticProV55.BloodMan_Lightning"
	 DamageDescription=",Electro,Hazard,Plasma,"
	 bDetonatesBombs=False
	 bIgniteFires=True
	 bDelayedDamage=True
	 bCauseConvulsions=True
	 GibModifier=5.000000
	 DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
	 DamageOverlayTime=0.900000
	 GibPerterbation=0.250000
	 KDamageImpulse=20000.000000
	 VehicleDamageScaling=0.400000
}
