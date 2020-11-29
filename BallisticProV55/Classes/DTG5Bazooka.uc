//=============================================================================
// DTG5Bazooka.
//
// DamageType for the G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTG5Bazooka extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o was blown to pieces by %k's G5."
     DeathStrings(1)="%o caught %k's G5 rocket."
     DeathStrings(2)="%k launched %kh G5 rocket into %o's face."
     AimedString="Scoped"
     InvasionDamageScaling=3.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.700000
     WeaponClass=Class'BallisticProV55.G5Bazooka'
     DeathString="%o was blown to pieces by %k's G5."
     FemaleSuicide="%o splattered the walls with her gibs using a G5."
     MaleSuicide="%o splattered the walls with his gibs using a G5."
     bDelayedDamage=True
     VehicleDamageScaling=1.500000
     VehicleMomentumScaling=1.500000
}
