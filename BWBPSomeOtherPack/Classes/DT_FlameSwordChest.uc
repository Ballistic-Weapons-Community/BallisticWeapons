//=============================================================================
// DT_DTSChest.
//
// Damagetype for the almighty nanosword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FlameSwordChest extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%o was laid open in a blinding flash of %k's incendiary blade."
     DeathStrings(1)="%k stands gore-soaked, with flame blade in hand, among %o's smoldering carcass."
     DeathStrings(2)="Bones cracked and tendons snapped as %k cleaved %kh fire sword through %o's wretched body."
     DeathStrings(3)="%o could not withstand the might of %k's pyrokinetic blade."
     DeathStrings(4)="%k's psychic flames washed over a sundered %o."
     DamageIdent="Melee"
     MinMotionBlurDamage=5.000000
     MotionBlurDamageRange=20.000000
     MotionBlurFactor=5.000000
     WeaponClass=Class'BWBPSomeOtherPack.FlameSword'
     DeathString="%o's torso was cut open by %k and %kh DTS."
     FemaleSuicide="%o activated her DTS backwards."
     MaleSuicide="%o activated his DTS backwards."
     bNeverSevers=True
	 BlockFatiguePenalty=0.2
	 BlockPenetration=0.2
     GibModifier=4.000000
     PawnDamageSounds(0)=Sound'PackageSounds4Pro.DTS.NanoSwordHitFlesh'
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.350000
}
