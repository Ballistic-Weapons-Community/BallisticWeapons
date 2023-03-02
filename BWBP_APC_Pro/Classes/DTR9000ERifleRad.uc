//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR9000ERifleRad extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o didn’t need to be in close proximity for %k to irradiate them."
     DeathStrings(1)="%k rearranged %o's DNA from a distance away."
     DeathStrings(2)="%o mutated into a pile of goop from %k's radioactive Chimera."
     DeathStrings(3)="%k forced a evolutionary virus into %o with a rad amped Chimera."
     DeathStrings(4)="%o is pissing neon green from getting shot by %k's Chimera."
     DeathStrings(5)="%k turned %o into a ghoul, then had to put them down for going feral."
     AimedString="Scoped"
     bSnipingDamage=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.300000
     WeaponClass=Class'BWBP_APC_Pro.R9000ERifle'
     DeathString="%o was silenced by %k's R9000-E."
     FemaleSuicide="%o held her R9000-E the wrong way around."
     MaleSuicide="%o held his R9000-E the wrong way around."
     VehicleDamageScaling=0.150000
     VehicleMomentumScaling=0.300000
}
