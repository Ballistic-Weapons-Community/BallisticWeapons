class ASTaggedVehicleFactory extends ASVehicleFactory;

var(VehicleTypeTag) string VehicleTypeTag;

function PreBeginPlay()
{
	local int i;
	
	Super.PreBeginPlay();
	
	if (VehicleTypeTag == "")
		return;
	
	for (i = 0; i < class'VehicleTags'.default.VTags.Length; i++)
	{
		if (class'VehicleTags'.default.VTags[i].TypeTag ~= VehicleTypeTag)
		{
			VehicleClass = class<Vehicle>(DynamicLoadObject(class'VehicleTags'.default.VTags[i].TypeClass, class'Class'));
			return;
		}
	}
	
	Log(Name$": Could not find replacement for type tag: "$VehicleTypeTag);
}

defaultproperties
{
}
