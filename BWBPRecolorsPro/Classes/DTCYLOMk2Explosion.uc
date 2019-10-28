//=============================================================================
// DTCyloMk2Rifle.
//
// Damage type for the incendiary Mk2 CYLO.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTCYLOMk2Explosion extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's chest was given airholes by %k's CYLO Firestorm."
     DeathStrings(1)="%k turned %o into a human clarinet with %kh CYLO Firestorm."
     DeathStrings(2)="%k's CYLO Firestorm made short work of %o."
     DeathStrings(3)="%k's CYLO Firestorm made %o into mincemeat."
     SimpleKillString="CYLO Firestorm V Radius"
     BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
     bIgniteFires=True
     InvasionDamageScaling=2.000000
     DamageIdent="Assault"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.CYLOAssaultWeapon'
     DeathString="%o's chest was given airholes by %k's CYLO Firestorm."
     FemaleSuicide="%o spat fire at her feet."
     MaleSuicide="%o spat fire at his feet."
     bFastInstantHit=True
     bAlwaysSevers=True
     bFlaming=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.600000
}
