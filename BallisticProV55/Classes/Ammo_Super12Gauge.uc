//=============================================================================
// Super 12 - M290 ammo.
//=============================================================================
class Ammo_Super12Gauge extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=18
     InitialAmount=18
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_12GaugeFlash'
     PickupClass=Class'BallisticProV55.AP_12GaugeBox'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIcon_12GaugeBox'
     IconCoords=(X2=63,Y2=63)
     ItemName="Super 12 Gauge Shells"
}
