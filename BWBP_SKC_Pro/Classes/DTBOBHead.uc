//=============================================================================
// DTBOBHead.
//
// Damagetype for Black Ops Blade head stabs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTBOBHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k's X5W cut some pieces out of %o's head."
     DeathStrings(1)="%k plunged %kh black ops blade deep into %o's head."
     DeathStrings(2)="%o's throat was slit by by %k's X5W wrist blade."
     DeathStrings(3)="%o lost %vh jaw to %k's X5W."
     WeaponClass=Class'BWBP_SKC_Pro.BlackOpsWristBlade'
     DeathString="%k's X5W cut some pieces out of %o's head."
     FemaleSuicide="%o licked her X5W blade."
     MaleSuicide="%o licked his X5W blade. OM NOM NOM."
     bArmorStops=False
     bAlwaysSevers=True
     bSpecial=True
     KDamageImpulse=1000.000000
}
