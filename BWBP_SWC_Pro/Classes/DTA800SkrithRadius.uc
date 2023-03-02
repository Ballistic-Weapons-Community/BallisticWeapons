//=============================================================================
// DTA73SkrithHead.
//
// Damage type for A73 headshots
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTA800SkrithRadius extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k burned a hole through %o with the Y11."
     DeathStrings(1)="%o was scorched in half by %k's Y11."
     DeathStrings(2)="%o saw the light of %k's Y11."
     DeathStrings(3)="%k lit up %o with the Y11."
     SimpleKillString="Y11 Power Bomb Radius"
	 BloodManagerName="BallisticProV55.BloodMan_A73Burn"
     bIgniteFires=True
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     DeathString="%k burned a hole through %o with the Y11."
     FemaleSuicide="%o's Y11 turned on her."
     MaleSuicide="%o's Y11 turned on him."
     bAlwaysSevers=True
     bSpecial=True
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
}
