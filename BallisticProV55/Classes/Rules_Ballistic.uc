//Scales any ballistic damagetypes.
class Rules_Ballistic extends GameRules
	config(System);

var() float	DamageScale;		// Damage is scaled by this
var() float	VehicleDamageScale;	// Damage is scaled by this for vehicles

function PostBeginPlay()
{
	DamageScale = class'BallisticReplicationInfo'.default.DamageScale;
	VehicleDamageScale = class'BallisticReplicationInfo'.default.VehicleDamageScale;
}

function int NetDamage( int OriginalDamage, int Damage, pawn Injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType )
{
	if (class<BallisticDamageType>(DamageType) != None)
	{		
		if (Vehicle(Injured) != None)
			Damage = float(Damage) * VehicleDamageScale;
		else
			Damage = float(Damage) * DamageScale;
	}
	
	if ( NextGameRules != None )
		return NextGameRules.NetDamage( OriginalDamage,Damage,injured,instigatedBy,HitLocation,Momentum,DamageType );
	return Damage;
}

defaultproperties
{
     DamageScale=1.000000
     VehicleDamageScale=1.000000
}
