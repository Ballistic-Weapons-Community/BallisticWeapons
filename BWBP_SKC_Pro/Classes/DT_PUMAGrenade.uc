//=============================================================================
// DT_PUMAGrenad.
//
// DamageType for the PUMA direct hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_PUMAGrenade extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%k bounced a PUMA round off %o."
     DeathStrings(1)="%o was hit by %k's passing PUMA round."
     WeaponClass=Class'BWBP_SKC_Pro.PumaRepeater'
     DeathString="%k bounced a PUMA round off %o."
     FemaleSuicide="%o tripped on her PUMA grenade."
     MaleSuicide="%o tripped on his PUMA grenade."
     bDelayedDamage=True
}
