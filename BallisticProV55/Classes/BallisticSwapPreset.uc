//===========================================================================
// Ballistic Swap Preset
//
// Holds a preset for Ballistic Swap's configuration page. The presets are too long to be stored using
// a more natural method.
//
// by Azarael
//===========================================================================
class BallisticSwapPreset extends Object
	config(BallisticV25) 
	perobjectconfig
	DependsOn(BallisticTab_SwappingsPro);
	
var	config	array<BallisticTab_SwappingsPro.Swap>	Swaps;

defaultproperties
{
}
