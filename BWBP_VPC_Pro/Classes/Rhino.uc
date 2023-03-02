//-----------------------------------------------------------
//Modified Hellbender. This piece of hardware, can ram and smash others,
//and is outfitted with greater weaponry
//-----------------------------------------------------------
class Rhino extends ONSPRV;

event TakeImpactDamage(float AccelMag)
{
	if (Driver != None && Vehicle(ImpactInfo.Other) != None && Vehicle(ImpactInfo.Other).GetTeamNum() != Controller.Pawn.GetTeamNum() && Normal(ImpactInfo.Pos - Location) Dot Vector(Rotation) >= 0.75)
		ImpactInfo.Other.TakeDamage(AccelMag * 0.025, self, ImpactInfo.Pos, ImpactInfo.ImpactVel * 0.7, class'DamTypeONSVehicle');

	super.TakeImpactDamage(AccelMag);
}

function float ImpactDamageModifier()
{
    local float Multiplier;

    if (Normal(ImpactInfo.Pos - Location) Dot Vector(Rotation) >= 0.75)
    	Multiplier = 0.005;
    else
        Multiplier = 1.0;

    return Super.ImpactDamageModifier() * Multiplier;
}

defaultproperties
{
     TorqueCurve=(Points=((OutVal=40.000000),(InVal=200.000000,OutVal=19.000000),(InVal=1500.000000,OutVal=20.000000),(InVal=2800.000000)))
     TransRatio=0.150000
     PassengerWeapons(0)=(WeaponPawnClass=Class'BWBP_VPC_Pro.RhinoMGPawn')
     ImpactDamageMult=0.000300
     VehicleMass=6.000000
     VehiclePositionString="in a Rhino"
     VehicleNameString="Rhino"
}
