//=============================================================================
// DT_FG50Torso
//
// Damage type for FG50 ammunition
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_FG50Torso extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o took %k's FG50 round straight to the spine."
     DeathStrings(1)="%o couldn't survive %k's firey tempest of FG50 rounds."
     DeathStrings(2)="%k drilled several large holes into %o with %kh FG50."
     DeathStrings(3)="%k's FG50 put some lead into %o's diet."
     bIgniteFires=True
     DamageIdent="Machinegun"
     DamageDescription=",Bullet,Flame,"
     WeaponClass=Class'BWBPRecolorsPro.FG50MachineGun'
     DeathString="%o took %k's FG50 round straight to the spine."
     FemaleSuicide="%o's FG50 didn't like the look of its owner."
     MaleSuicide="%o's FG50 didn't like the look of its owner."
     bFastInstantHit=True
     GibModifier=1.500000
     GibPerterbation=0.200000
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.500000
}
