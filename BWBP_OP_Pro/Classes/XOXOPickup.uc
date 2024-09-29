class XOXOPickup extends BallisticWeaponPickup
	placeable;

var float Lewdness;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXOBase');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXO_Light');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.hearteffect');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xeffect');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.oeffect');	
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xenon4');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXOMagicBand');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xoxoShaderMask');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.Heart');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.X');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.O');
}

//===========================================================================
// UpdatePrecacheMaterials
//
// Called on the pickup by the LevelInfo if it previously existed in the map.
//===========================================================================
simulated function UpdatePrecacheMaterials()
{	
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXOBase');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXO_Light');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.hearteffect');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xeffect');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.oeffect');	
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xenon4');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.XOXOMagicBand');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.XOXO.xoxoShaderMask');
}

//===========================================================================
// UpdatePrecacheStaticMeshes
//
// Called on the pickup by the LevelInfo if it previously existed in the map.
//===========================================================================
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.XOXOPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.XOXOPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.XOXOAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.Heart');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.X');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XOXO.O');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.XOXO.XOXOPickupLo'
     PickupDrawScale=1.450000
     InventoryType=Class'BWBP_OP_Pro.XOXOStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up le big XOXO."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.XOXO.XOXOPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=1.600000
     CollisionHeight=4.500000
}
