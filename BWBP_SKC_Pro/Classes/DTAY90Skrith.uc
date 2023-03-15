//=============================================================================
// DTA73BSkrith.
//
// Damage type for A73B projectiles
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTAY90Skrith extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k's vulture will feast on %o's plasma filled corpse."
     DeathStrings(1)="%o became carrion for %k's bird of prey."
     DeathStrings(2)="%k led %o into his explosive plasma bolt and blew his legs off."
     DeathStrings(3)="%o no longer has a bowel obstruction, or any bowels thanks to %k."
     DeathStrings(4)="%k is a marksman, accurately nailing %o with many plasma bolts."
     DeathStrings(5)="%o was crucified due to %k's boltcaster."
	 BloodManagerName="BWBP_SKC_Pro.BloodMan_A73B"
     bIgniteFires=True
     bOnlySeverLimbs=True
     DamageDescription=",Flame,Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.AY90SkrithBoltcaster'
     DeathString="%k fused parts of %o with the AY90."
     FemaleSuicide="%o's AY90 turned on her."
     MaleSuicide="%o's AY90 turned on him."
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.900000
}
