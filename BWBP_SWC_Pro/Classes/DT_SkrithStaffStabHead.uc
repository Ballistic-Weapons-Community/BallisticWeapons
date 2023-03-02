//=============================================================================
// DTA73StabHead.
//
// Damagetype for the A73 bayonette attack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_SkrithStaffStabHead extends DT_BWBlade;

defaultproperties
{
     DeathStrings(0)="%k rammed the blades of %kh Shillelagh into %o's head."
     DeathStrings(1)="%o was jabbed in the jaw by %k's Shillelagh."
     DeathStrings(2)="%o tried to chew on %k's Shillelagh."
     DamageDescription=",Stab,"
     WeaponClass=Class'BWBP_SWC_Pro.SkrithStaff'
     DeathString="%k rammed the blades of an Shillelagh into %o's head."
     FemaleSuicide="%o sliced her own head in half with the Shillelagh."
     MaleSuicide="%o sliced his own head in half with the Shillelagh."
     bArmorStops=False
     bAlwaysSevers=True
     bSpecial=True
     PawnDamageSounds(0)=Sound'BW_Core_WeaponSound.A73.A73StabFlesh'
     KDamageImpulse=2000.000000
}
