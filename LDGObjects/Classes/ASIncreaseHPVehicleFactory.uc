class ASIncreaseHPVehicleFactory extends ASVehicleFactory
	placeable;

var(ASVehicleFactory) int IncreaseHealthRate;

function VehicleSpawned()
{
	Super.VehicleSpawned();
	VehicleHealth += IncreaseHealthRate;
}

defaultproperties
{
}
