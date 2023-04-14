//=============================================================================
// DT_MG36Assault.
//
// DamageType for the MG36 Carbine primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_MG36Assault extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k ambushed %o in the dark and silently gunned him down."
     DeathStrings(1)="%o couldn't find %k the predator and was filled with lead for his troubles."
     DeathStrings(2)="%k found %o using tracer vision before shooting him with a MG36."
     DeathStrings(3)="%o took a drum full of bullets from %k's MG36."
     DamageIdent="Assault"
     WeaponClass=Class'BWBP_SKC_Pro.MG36Machinegun'
     DeathString="%k's MG36 confirmed a kill on %o."
     FemaleSuicide="%o took the easy way out with an MG36."
     MaleSuicide="%o took the easy way out with an MG36."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
	 VehicleDamageScaling=1.000000
}
