//=============================================================================
// DT_SK410.
//
// Damagetype for DT_SK410 Melee attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SK410Hit extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k saved Soviet shells and just beat %o to death."
     DeathStrings(1)="%k drunkenly chased down %o with a crude SK410 shaped hammer."
     DeathStrings(2)="%k doesn't need reloads! %ke beats %o with gun!"
     DeathStrings(3)="%o learned that %k's SK-410 makes a GREAT club."
     DamageIdent="Melee"
     DisplacementType=DSP_Linear
	 BlockFatiguePenalty=0.2
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1
     WeaponClass=Class'BWBPRecolorsPro.SK410Shotgun'
     DeathString="%k saved Soviet shells and just beat %o to death."
     FemaleSuicide="%o wanted her SK-410 to be closer to her."
     MaleSuicide="%o had explods to smitheroons. :("
}
