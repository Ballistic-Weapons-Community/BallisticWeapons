class VehicleTags extends Object
	config(LDGObjects);
	
struct VTag
{
	var string TypeTag;
	var string TypeClass;
};

var config array<VTag> VTags;

defaultproperties
{
}
