//=============================================================================
// DT_LonghornBigDirect.
//
// Damage type for the large grenade fired by the longhorn - Direct Impact
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_LonghornBigDirect extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o grabbed %k's Longhorn by the horns."
     DeathStrings(1)="%o came face-to-face with %k's Longhorn."
     DeathStrings(2)="%k gored %o with %kh explosive Longhorn."
     DeathStrings(3)="%o got rammed by %k's lethal Longhorn."
     SimpleKillString="Longhorn Grenade Impact"
     InvasionDamageScaling=2.000000
     DamageIdent="Ordnance"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=120
     AimDisplacementDuration=0.7
     WeaponClass=Class'BWBPRecolorsPro.LonghornLauncher'
     DeathString="%o grabbed %k's Longhorn by the horns."
     FemaleSuicide="%o tripped on her Longhorn charge."
     MaleSuicide="%o tripped on his Longhorn charge."
     bDelayedDamage=True
     bExtraMomentumZ=True
}
