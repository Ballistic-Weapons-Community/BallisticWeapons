//=============================================================================
// Conqueror ammo type.
//=============================================================================
class Ammo_MGL extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=12
     InitialAmount=6
     IconFlashMaterial=Shader'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGPFlash'
     PickupClass=Class'BallisticProV55.AP_BOGPGrenades'
     IconMaterial=Texture'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGP'
     IconCoords=(X2=64,Y2=64)
     ItemName="Conqueror Grenades"
}
