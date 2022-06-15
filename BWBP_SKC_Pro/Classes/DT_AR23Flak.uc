//=============================================================================
// DT_MD402Flak.
//
// Damagetype for the 40mm SHOTGUN
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_AR23Flak extends DT_BWExplode;

defaultproperties
{
     DeathStrings(0)="%o received a 40mm serving of buckshot from %k's AR23."
     DeathStrings(1)="%k prerforated %o with %kh 40mm shotgun!"
     DeathStrings(2)="%k's AR23 shotgun turned %o into meaty paste."
     DeathStrings(3)="%o was decimated by %k's CAWS!"
     WeaponClass=Class'BWBP_SKC_Pro.AR23HeavyRifle'
     DeathString="%o received a 40mm serving of buckshot from %k's AR23"
     FemaleSuicide="%o made a severe tactical error."
     MaleSuicide="%o made a severe tactical error."
//     bAlwaysGibs=True
//     bLocationalHit=False
//     bAlwaysSevers=True
     PawnDamageSounds(0)=Sound'BWBP_SKC_Sounds.Berserk.Berserk-Squish'
     GibPerterbation=4.000000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.050000
     VehicleMomentumScaling=1.300000
}
