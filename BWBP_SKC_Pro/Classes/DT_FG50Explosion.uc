//=============================================================================
// DTCyloMk2Rifle.
//
// Damage type for the incendiary Mk2 CYLO.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Explosion extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="The outcome after %k came at %o with an FG50? %o go boom."
	DeathStrings(1)="%o failed to withstand %k's orbital assault, being exploded from up above."
	DeathStrings(2)="%k popped %o with some very, very big bullets."
	DeathStrings(3)="%o had %vh blood spilled onto the battlefield by %k's FG50."
	SimpleKillString="FG50 Explosive Rounds"
	BloodManagerName="BallisticProV55.BloodMan_GRS9Laser"
	bIgniteFires=True
	InvasionDamageScaling=2.000000
	DamageIdent="Machinegun"
	DamageDescription=",Bullet,Flame,"
	WeaponClass=Class'BWBP_SKC_Pro.FG50MachineGun'
	DeathString="%o took %k's FG50 round straight to the spine."
	FemaleSuicide="%o trashed herself with her own explosive rounds."
	MaleSuicide="%o trashed himself with his own explosive rounds."
	bFastInstantHit=True
	bAlwaysSevers=True
	bFlaming=True
	GibModifier=1.500000
	GibPerterbation=0.200000
	KDamageImpulse=3500.000000
	VehicleDamageScaling=0.500000
}
