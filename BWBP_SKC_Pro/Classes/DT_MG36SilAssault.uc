//=============================================================================
// DT_MG36SilAssault.
//
// DamageType for the _MG36 that is sulenced. DETH MASSAGES
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MG36SilAssault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k quietly eliminated %o with the MG36."
     DeathStrings(1)="%o was silenced by %k's MG36 rounds."
     DeathStrings(2)="%k assasinated %o with a suppressed MG36."
     DeathStrings(3)="%o was silently downed by %k's MG36."
     SimpleKillString="MG36 Night Ops Suppressed"
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.MG36Machinegun'
     DeathString="%k quietly eliminated %o with the MG36."
     FemaleSuicide="%o is quite horrible with firearms."
     MaleSuicide="%o is quite horrible with firearms."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=1.000000
}
