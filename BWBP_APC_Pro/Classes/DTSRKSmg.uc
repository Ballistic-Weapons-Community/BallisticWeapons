//=============================================================================
// DTSRKSmg.
//
// DamageType for the MJ51 assault rifle primary fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTSRKSmg extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k ran into %o within close proximity, putting holes into their torso."
     DeathStrings(1)="%o couldn't withstand %k's super 10mm bullets entering their lungs."
     DeathStrings(2)="%k didn't need a full sized gun to kill %o, the 205 does the job."
	 DeathStrings(3)="%o had their kneecaps resemble broken stumps because of %k."
	 DeathStrings(4)="%k's super bullets destroyed the villainous %o."
	 DeathStrings(5)="%o couldn’t run or escape from %k's 205 in a confined space."
     WeaponClass=Class'BWBP_APC_Pro.SRKSubMachinegun'
     DeathString="%k shot through %o with the SRK-205."
     FemaleSuicide="%o nailed herself with the SRK-205."
     MaleSuicide="%o nailed himself with the SRK-205."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.650000
}
