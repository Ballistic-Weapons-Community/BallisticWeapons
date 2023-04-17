//=============================================================================
// DT_Supercharge.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_Supercharge extends DT_BWFire;

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
	 //DeathStrings(0)="%o erupted into a show of lights and blood after being overcharged by %k."
     //DeathStrings(1)="%k popped %o like a balloon after charging them up."
     //DeathStrings(2)="%o's heart, mind, soul and body was reduced to mist by being supercharged thanks to %k."
     //DeathStrings(3)="%k reduced %o into a fine red mist after charging them beyond their limits."
     DeathStrings(0)="%k SUPERCHARGED %o!"
     FemaleSuicides(0)="%o SUPERCHARGED herself."
     MaleSuicides(0)="%o SUPERCHARGED himself."
     BloodManagerName="BallisticProV55.BloodMan_Lightning"
     ShieldDamage=200
     DamageDescription=",Electro,Hazard,Plasma,"
     bNoSeverStumps=True
     WeaponClass=Class'BWBP_SKC_Pro.Supercharger_AssaultWeapon'
     DeathString="%k SUPERCHARGED %o!"
     FemaleSuicide="%o SUPERCHARGED herself!"
     MaleSuicide="%o SUPERCHARGED himself!"
     SimpleKillString="SUPERCHARGE"
     bInstantHit=True
     bSkeletize=True
     bCauseConvulsions=True
     bCausesBlood=True
     bNeverSevers=False
     bDelayedDamage=True
     bFlaming=True
     GibModifier=5.500000
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=1.200000
     KDamageImpulse=20000.000000
}
