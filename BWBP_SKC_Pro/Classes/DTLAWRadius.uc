//=============================================================================
// DTLAWRadius.
//
// DamageType for the LAW mini-nuke radius
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTLAWRadius extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o perished in %k's massive LAW shockwave."
     DeathStrings(1)="%o was blown to the heavens by %k's LAW."
     DeathStrings(2)="%k blasted the hell out of %o with a LAW."
     DeathStrings(3)="%k brought the LAW down on %o."
     DeathStrings(4)="%k brought justice to %o with the LAW."
     FemaleSuicides(0)="%o's body couldn't take the punishment of the LAW."
     FemaleSuicides(1)="%o underestimated the power of her LAW."
     FemaleSuicides(2)="%o got on the wrong side of the LAW."
     MaleSuicides(0)="%o's body couldn't take the punishment of the LAW."
     MaleSuicides(1)="%o failed to distance himself from his LAW blast."
     MaleSuicides(2)="%o got on the wrong side of the LAW."
     SimpleKillString="LAW Rocket"
     InvasionDamageScaling=3.000000
     DamageIdent="Killstreak"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.500000
     WeaponClass=Class'BWBP_SKC_Pro.LAWLauncher'
     DeathString="%o was blown to smithereens by %k's LAW blast."
     FemaleSuicide="%o set the LAW on herself."
     MaleSuicide="%o underestimated the full extent of the LAW."
     bDelayedDamage=True
     VehicleDamageScaling=2.000000
     VehicleMomentumScaling=0.800000
}
