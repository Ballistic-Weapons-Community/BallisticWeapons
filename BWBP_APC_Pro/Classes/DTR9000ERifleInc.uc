//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR9000ERifleInc extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was purged in the fire of %k's Chimera without even seeing them."
     DeathStrings(1)="%k can now see %o from a mile away thanks to some fiery bullets."
     DeathStrings(2)="%o got their sausage or taco burned to a crisp thanks to %k's Chimera."
     DeathStrings(3)="%k reduced %o's kneecaps into ashes from well placed shots with a fiery Chimera."
     DeathStrings(4)="%o not only failed to save the princess, but was burned to cinders by %k."
     DeathStrings(5)="%k lit up %o while abiding by the 6 feet rule."
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
