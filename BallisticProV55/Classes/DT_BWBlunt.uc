//=============================================================================
// DT_BWBlunt.
//
// Base damage type that will play some pawn impact sounds for blunt hits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWBlunt extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
     BloodManagerName="BallisticProV55.BloodMan_Blunt"
     FlashThreshold=50
     bCanBeBlocked=True
     DamageDescription=",Blunt,"
     bInstantHit=True
     bNeverSevers=True
     PawnDamageSounds(0)=Sound'BallisticSounds2.M763.M763SmashFlesh'
     VehicleDamageScaling=0.000000
     VehicleMomentumScaling=0.100000
}
