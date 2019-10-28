//=============================================================================
// BallisticCrosshairpack.
//
// This class is used to add crosshairs to the ballistic crosshair system.
// It contains a list of crosshairs with their texture, name and dimesions.
// References to BallisticCrosshairPack subclasses can be added to int files
// to allow crosshair config menus to find the lists.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticCrosshairPack extends Object
	config(BallisticProV55);

struct BWCrosshair		// Info for a single crosshair
{
	var() config string		FriendlyName;	// Display name for menus and so on
	var() config Material	Image;			// Material for this crosshair
	var() config int		USize, VSize;	// The dimensions of the material
};
var()	array<BWCrosshair>	Crosshairs;			// A list of crosshairs

defaultproperties
{
}
