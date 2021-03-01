//=============================================================================
// DT_BWFire.
//
// DT with some standard defaults for BW fires
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWFire extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
    DamageBasis=DB_Heat
    bIgniteFires=True
    DamageDescription=",Flame,Hazard,NonSniper,"
    bLocationalHit=False
    bCausesBlood=False
    bNeverSevers=True
    GibPerterbation=0.500000
    KDamageImpulse=1000.000000
    VehicleDamageScaling=0.600000
    VehicleMomentumScaling=0.000000
}
