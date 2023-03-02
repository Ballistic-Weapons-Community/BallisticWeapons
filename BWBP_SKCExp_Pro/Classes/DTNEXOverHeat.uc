//=============================================================================
// DT_HVCOverheat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTNEXOverHeat extends DT_BWMiscDamage;


static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=0.500000
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     DeathStrings(0)="%o was on the receiving end of %k's overloaded NEX."
     DeathStrings(1)="%k vented %kh plasma sword into %o."
     DeathStrings(2)="%k plunged an overloaded NEX into %o."
     DeathStrings(3)="%k's Plas-Edge exploded in %o's face."
     FemaleSuicides(0)="%o melted her face off with her NEX."
     FemaleSuicides(1)="%o lost an eyebrow thanks to her Plas-Edge."
     FemaleSuicides(2)="%o's Plas-Edge looks better as part of her hands anyways."
     MaleSuicides(0)="%o melted his face off with his NEX."
     MaleSuicides(1)="%o exploded his prototype Plas-Edge."
     MaleSuicides(2)="%o's Plas-Edge looks better as part of his hands anyways."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     bDetonatesBombs=False
     bIgniteFires=True
     DamageDescription=",Electro,Hazard"
     WeaponClass=Class'BWBP_SKCExp_Pro.N3XPlaz'
     DeathString="%o was on the receiving end of %k's overloaded NEX."
     FemaleSuicide="%o melted her face off with her NEX."
     MaleSuicide="%o melted his face off with his NEX."
     bArmorStops=False
     bInstantHit=True
     bCauseConvulsions=True
     bFlaming=True
     GibModifier=5.000000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
