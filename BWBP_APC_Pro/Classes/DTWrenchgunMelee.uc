//=============================================================================
// DTCoachMelee.
//
// You got beat down by the coach gun biznitch.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTWrenchgunMelee extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%k wrench-pummeled %o with %kh wrenchgun wrench bayonet."
     DeathStrings(1)="%o was wrenched down by %k's wrenchgun wrench."
     DeathStrings(2)="%k's wrenchgun wrenched a couple of %o's ribs."
     DamageIdent="Melee"
     AimDisplacementDamageThreshold=60
     AimDisplacementDuration=1.700000
     WeaponClass=Class'BWBP_APC_Pro.Wrenchgun'
     DeathString="%k wrench-pummeled %o with %kh wrenchgun wrench bayonet."
     FemaleSuicide="%o bashed herself with the wrenchgun."
     MaleSuicide="%o headbutted his wrenchgun."
     bExtraMomentumZ=True
}
