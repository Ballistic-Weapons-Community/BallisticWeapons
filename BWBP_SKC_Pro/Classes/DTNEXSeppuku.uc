//=============================================================================
// DT_HVCOverheat.
//
// Because plunging a sword into your chest is the same as blowing up a plasma cannon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTNEXSeppuku extends DT_BWMiscDamage;

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
     DeathStrings(0)="%o stared a bit too closely at %k's demonstration."
     FemaleSuicides(0)="%o performed seppuku."
     MaleSuicides(0)="%o performed seppuku."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     DamageDescription=",Electro,Hazard"
     WeaponClass=Class'BWBP_SKC_Pro.N3XPlaz'
     DeathString="%o stared a bit too closely at %k's demonstration."
     MaleSuicide="%o performed seppuku."
     bArmorStops=False
     bInstantHit=True
     bNeverSevers=True
     bFlaming=True
     GibModifier=3.500000
     GibPerterbation=1.400000
     KDamageImpulse=20000.000000
}
