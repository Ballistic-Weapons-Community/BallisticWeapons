//=============================================================================
// DTG28Explode
//
// Damage type for the G28 when ignited
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTG28Explode extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k turned %o's G28 into a fuel air explosive."
     DeathStrings(1)="%o's G28 'spontaneously' combusted thanks to %k."
     DeathStrings(2)="%k demonstrated the effects of combustion to %o."
     DeathStrings(3)="%k blew up the G28 %o was busy huffing."
     WeaponClass=Class'BWBP_SKC_Pro.G28Grenade'
     DeathString="%k turned %o's G28 into a fuel air explosive."
     FemaleSuicide="%o didn't read the flammable label on her G28."
     MaleSuicide="%o didn't read the flammable label on his G28."
     bDelayedDamage=True
     VehicleDamageScaling=0.350000
     VehicleMomentumScaling=0.500000
}
