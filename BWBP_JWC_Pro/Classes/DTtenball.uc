//=============================================================================
// DTrock.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTtenball extends DTJunkDamage;

defaultproperties
{
     DeathStrings(0)="%o got killed by %k's tennis ball. How embarassing."
     DeathStrings(1)="%k didn't have any other weapons so %ke just killed %o with a tennis ball."
     DeathStrings(2)="%k killed %o with a tennis ball. I'm serious, %ke's like freaking Rambo."
     ShieldDamage=2
     DamageDescription=",Stab,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
     DeathString="%k threw a tennis ball at %o."
     FemaleSuicide="%o threw a tennis ball at herself and died painfully."
     MaleSuicide="%o threw a tennis ball at himself and died painfully."
     VehicleDamageScaling=0.000000
}
