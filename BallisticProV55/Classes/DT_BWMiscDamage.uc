//=============================================================================
// DT_BWMiscDamage.
//
// Padding to prevent DoBloodEffects on BWPawns
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class DT_BWMiscDamage extends BallisticDamageType;

static function DoBloodEffects( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (BallisticPawn(Victim) == None)
		super.DoBloodEffects( HitLocation, Damage, Momentum, Victim, bLowDetail );
}

defaultproperties
{
}
