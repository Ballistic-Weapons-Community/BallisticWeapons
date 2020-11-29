//=============================================================================
// DTR78Rifle.
//
// Damage type for the R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DTR78Rifle extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%o was silenced by %k's R78."
     DeathStrings(1)="%k picked off %o with %kh sniper rifle."
     DeathStrings(2)="%k's R78 hunted down %o."
     DeathStrings(3)="%k's Raven tucked into some delicious %o."
     DeathStrings(4)="%k's Raven strike ended %o's farcical existence."
     DeathStrings(5)="%o never even saw %k's R78 bullet coming."
     AimedString="Scoped"
     bSnipingDamage=True
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
     AimDisplacementDamageThreshold=100
     AimDisplacementDuration=0.300000
     WeaponClass=Class'BallisticProV55.R78Rifle'
     DeathString="%o was silenced by %k's R78."
     FemaleSuicide="%o held her R78 the wrong way around."
     MaleSuicide="%o held his R78 the wrong way around."
     VehicleDamageScaling=0.150000
     VehicleMomentumScaling=0.300000
}
