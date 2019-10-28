//=============================================================================
// Conqueror ammo type.
//=============================================================================
class Ammo_MGL extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=12
     InitialAmount=12
     IconFlashMaterial=Shader'BallisticTextures_25.BOGP.AmmoIcon_BOGPFlash'
     PickupClass=Class'BallisticProV55.AP_BOGPGrenades'
     IconMaterial=Texture'BallisticTextures_25.BOGP.AmmoIcon_BOGP'
     IconCoords=(X2=64,Y2=64)
     ItemName="Conqueror Grenades"
}
