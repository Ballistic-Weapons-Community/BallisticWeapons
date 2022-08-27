class TrenchGunSurfaceFire extends RX22ASurfaceFire
	placeable;
	
	
function Toast(Actor A)
{
	local int		  Health;
	if ( (Instigator == None || Instigator.Controller == None) && InstigatorController != None)
		A.SetDelayedDamageInstigatorController( InstigatorController );
	if (Pawn(A) != None)
		Health = Pawn(A).Health;
	if (Ignitioneer != None && (A == Instigator || BW_FuelPatch(A)!=None) || (Instigator==None && InstigatorController==None))
		class'BallisticDamageType'.static.GenericHurt (A, Damage, Ignitioneer, A.Location, vect(0,0,0), DamageType);
	else
		class'BallisticDamageType'.static.GenericHurt (A, Damage, Instigator, A.Location, vect(0,0,0), DamageType);	
}

defaultproperties
{
     Damage=30.000000
     DamageType=Class'BWBP_OP_Pro.DTTrenchBurned'
}
