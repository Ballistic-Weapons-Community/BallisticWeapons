//=============================================================================
// GRS9Pickup.
//=============================================================================
class GRSXXPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Glock.Glock-LD'
     PickupDrawScale=0.160000
     InventoryType=Class'BWBP_SKCExp_Pro.GRSXXPistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the GRS-XX pistol."
     PickupSound=Sound'BWBP_SKC_SoundsExp.Glock_Glod.GRSXX-Select'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Glock.Glock-HD'
     Physics=PHYS_None
     DrawScale=0.340000
     PrePivot=(Y=-40.000000)
     CollisionHeight=4.000000
	 Skins(0)=Shader'BWBP_SKC_TexExp.Glock_Gold.GRSXX-MainShine'
}
