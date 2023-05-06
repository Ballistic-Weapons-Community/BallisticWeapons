//=============================================================================
// DTXMK5SubMachinegun.
//
// DamageType for the XMK5 submachinegun primary fire
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class DTXMK5SubMachinegun extends DT_BWBullet;

defaultproperties
{
	DeathStrings(0)="%k sprayed %o with XMk5 rounds."
	DeathStrings(1)="%o was gunned down as %ve tried to cower away from %k's XMk5 SMG."
	DeathStrings(2)="%k shovelled XMk5 rounds into %o."
	DeathStrings(3)="%k's XMk5 turned %o into a leaky piece of meat."
	InvasionDamageScaling=1.500000
	DamageIdent="SMG"
	WeaponClass=Class'BallisticProV55.XMK5SubMachinegun'
	DeathString="%k sprayed %o with XMk5 rounds."
	FemaleSuicide="%o ripped herself to shreds with an XMk5."
	MaleSuicide="%o ripped himself to shreds with an XMk5."
	bFastInstantHit=True
	GibPerterbation=0.100000
	KDamageImpulse=3000.000000
	VehicleDamageScaling=0.150000

	TagMultiplier=0.7
	TagDuration=0.1
}
