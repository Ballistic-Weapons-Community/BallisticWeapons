//=============================================================================
// WeaponCamo.
//
// Subobject designed to hold a set of skins to load in.
// Has a friendly name for menus and a locking var to ensure the camo is not 
// put on layouts with model changes.
//
// by Azarael and SK
//=============================================================================
class WeaponCamo extends Object
    editinlinenew;
	
// Struct used for skin replacements
struct MaterialSwap
{
    var()   Material    Material;
	var()	string		MaterialName;
    var()   int         Index;
    var()   int         PIndex; //Pickup
    var()   int         AIndex; //Attachment
};


var() int					Weight;					// How likely it is for this layout to be chosen, higher is more likely
var() String				CamoName;				// The camo name in menus
var() array<MaterialSwap>   WeaponMaterialSwaps;	// The set of skins used in this camo

var() int					Index;					// Used to find our index number in a cut down array of allowed camos