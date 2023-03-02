//=============================================================================
// DTBOBLimb
//
// Damagetype for black ops blade limb slices.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOBLimb extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k hacked off %o's arm with %kh X5W."
     DeathStrings(1)="%o is down one limb thanks to %k's X5W."
     DeathStrings(2)="%k used %kh black ops blade to debone %o."
     DeathStrings(3)="%o's exposed limbs were removed by %k's black ops blade."
     WeaponClass=Class'BWBP_SKCExp_Pro.BlackOpsWristBlade'
     DeathString="%k hacked off %o's arm with %kh X5W."
     FemaleSuicide="%o held her black ops blade the wrong way."
     MaleSuicide="%o held his X5W by the wrong handle."
     bArmorStops=False
     KDamageImpulse=1000.000000
}
