//===========================================================================
// Ballistic Swap Preset
//
// Holds a preset for Ballistic Swap's configuration page. The presets are too long to be stored using
// a more natural method.
//
// by Azarael
//===========================================================================
class BallisticSwapPreset extends Object
	config(BallisticProV55) 
	perobjectconfig
	DependsOn(ConfigTab_Swappings);
	
var	config	array<ConfigTab_Swappings.Swap>	Swaps;

defaultproperties
{
}
