//=============================================================================
// DTGRS9Pistol.
//
// Damage type for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTGRS9Pistol extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k prosecuted %o with %kh GRS-9."
     DeathStrings(1)="%o was acquitted by %k's GRS-9."
     DeathStrings(2)="%o was vindicated by %k's GRS-9."
     DeathStrings(3)="%k intimidated %o to pieces with %kh GRS-9."
     DamageIdent="Pistol"
	 InvasionDamageScaling=1.5
     WeaponClass=Class'BallisticProV55.GRS9Pistol'
     DeathString="%k prosecuted %o with %kh GRS-9."
     FemaleSuicide="%o prosecuted herself with the GRS-9."
     MaleSuicide="%o prosecuted himself with the GRS-9."
     VehicleDamageScaling=0.000000

	TagMultiplier=0.7
	TagDuration=0.1
}
