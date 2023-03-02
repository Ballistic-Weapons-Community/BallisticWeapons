//=============================================================================
// DTE23PlasmaHead.
//
// Damage type for E23 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTE5PlasmaHead extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o had their brain imprinted with %k's plasma bolts and death."
     DeathStrings(1)="%k sunk their viper's fangs into %o's skull and injected them with plasma."
     DeathStrings(2)="%o's visage turned into glowing syrup thanks to %k's miniature viper."
	 DeathStrings(3)="%k ripped open a yellow portal right through %o's face."
	 DeathStrings(4)="There's no antivenom for %o to take after getting blasted by %k's plasma viper."
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     bHeaddie=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_APC_Pro.E5PlasmaRifle'
     DeathString="%k left %o stumped with %kh E-5."
     FemaleSuicide="%o stumped herself with the E-5."
     MaleSuicide="%o stumped himself with the E-5."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
