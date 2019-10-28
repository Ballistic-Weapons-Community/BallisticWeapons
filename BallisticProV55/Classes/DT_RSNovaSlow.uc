//=============================================================================
// DT_RSNovaSlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_RSNovaSlow extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%k repulsed %o with a Nova Staff."
     DeathStrings(1)="%o annihilated %vs on %k's Nova bolts."
     DeathStrings(2)="%k harshly raged over %o with %kh Nova."
     DeathStrings(3)="%o got dispelled by %k's Nova."
     SimpleKillString="Nova Staff Bolt"
     BloodManagerName="BallisticProV55.BloodMan_NovaSlow"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",NovaStaff,"
     WeaponClass=Class'BallisticProV55.RSNovaStaff'
     DeathString="%k repulsed %o with a Nova Staff."
     FemaleSuicide="%o pointed her Nova Staff in the wrong direction."
     MaleSuicide="%o pointed his Nova Staff in the wrong direction."
     bExtraMomentumZ=True
     GibModifier=4.000000
     GibPerterbation=0.200000
     KDamageImpulse=1000.000000
     VehicleDamageScaling=0.600000
     VehicleMomentumScaling=0.200000
}
