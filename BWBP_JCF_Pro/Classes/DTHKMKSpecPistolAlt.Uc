//=============================================================================
// DTGRS9Pistol.
//
// Damage type for the GRS9 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DTHKMKSpecPistolAlt extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o's rib cage has some vacancy now that %k cleared it out with some buckshot."
     DeathStrings(1)="%k might've had no bullets in the mag, but a single shotgun shell buried %o."
     DeathStrings(2)="%o had their armor compromised, now they’re finished off by %k's shotgun from their HKM."
     DeathStrings(3)="%k's HKM mangled %o's shooting hand with some 00 Buckshot."
     DeathStrings(4)="%o took a lungful of %k's buckshot from their baby shotgun."
     WeaponClass=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     DeathString="%k drew %kh HKM-26 too fast for %o to react."
     FemaleSuicide="%o prosecuted herself with the HKM-26."
     MaleSuicide="%o prosecuted himself with the HKM-26."
     VehicleDamageScaling=0.750000
}
