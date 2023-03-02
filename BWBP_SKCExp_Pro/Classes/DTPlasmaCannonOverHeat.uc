//=============================================================================
// DT_HVCOverheat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTPlasmaCannonOverHeat extends DT_BWMiscDamage;

//var float	FlashF;
//var vector	FlashV;

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=0.100000
     FlashV=(X=2000.000000,Y=600.000000,Z=600.000000)
     DeathStrings(0)="%o was overheated by %k."
     DeathStrings(1)="%k overcharged %kh plasma cannon in %o's face."
     FemaleSuicides(0)="%o melted her hands with the H-VPC."
     FemaleSuicides(1)="%o redlined a plasma cannon."
     FemaleSuicides(2)="%o's H-VPC fused to her hands."
     MaleSuicides(0)="%o melted his hands with the H-VPC."
     MaleSuicides(1)="%o redlined a plasma cannon."
     MaleSuicides(2)="%o's H-VPC fused to his hands."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     DamageDescription=",Electro,Hazard"
     WeaponClass=Class'BWBP_SKCExp_Pro.HVPCMk5PlasmaCannon'
     DeathString="%o was overheated by %k."
     FemaleSuicide="%o melted her hands with the H-VPC."
     MaleSuicide="%o melted his hands with the H-VPC."
     bInstantHit=True
     bCauseConvulsions=True
     bFlaming=True
     GibModifier=1.500000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.PlayerTransRed'
     DamageOverlayTime=0.900000
     GibPerterbation=0.400000
     KDamageImpulse=20000.000000
}
