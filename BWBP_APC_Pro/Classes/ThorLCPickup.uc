//=============================================================================
// AK47Pickup.
//=============================================================================
class ThorLCPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     //LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.ProtonPackPickupLo'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBP_APC_Pro.ThorLightningCannon'
     RespawnTime=20.000000
     PickupMessage="You picked up the BR-99 'Thor' Lightning Cannon."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     //StaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.ProtonPackPickupHi'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.500000
	 Skins(1)=Shader'BWBP_OP_Tex.ProtonPack.proton_pack_SH_1'
}
