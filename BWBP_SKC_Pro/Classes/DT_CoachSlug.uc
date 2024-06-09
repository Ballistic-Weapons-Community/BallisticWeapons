//=============================================================================
// DT_CoachSlug.
//
// I have been informed that coach has a slug
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_CoachSlug extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="%k sent a massive slug through %o with %kh coach gun."
	DeathStrings(1)="%k's super magnum slug tore a chunk off %o."
	DeathStrings(2)="%o was hunted to extinction by %k's coach slug."
	SimpleKillString="Redwood Coach Gun Slug"
	InvasionDamageScaling=2.500000
	DamageIdent="Shotgun"
	WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
	DeathString="%k sent a massive slug through %o with %kh coach gun."
	FemaleSuicide="%o doesn't know how to aim."
	MaleSuicide="%o can't aim very well."
	GibModifier=1.500000
	GibPerterbation=0.400000
	KDamageImpulse=15000.000000
	VehicleDamageScaling=0.600000

	TagMultiplier=0.6
	TagDuration=0.2
}
