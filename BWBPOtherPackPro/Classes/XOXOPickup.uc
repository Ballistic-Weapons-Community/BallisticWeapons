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
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXOBase');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXO_Light');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.hearteffect');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xeffect');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.oeffect');	
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xenon4');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXOMagicBand');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xoxoShaderMask');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.Heart');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.X');
	L.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.O');
}

//===========================================================================
// UpdatePrecacheMaterials
//
// Called on the pickup by the LevelInfo if it previously existed in the map.
//===========================================================================
simulated function UpdatePrecacheMaterials()
{	
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXOBase');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXO_Light');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.hearteffect');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xeffect');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.oeffect');	
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xenon4');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.XOXOMagicBand');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.XOXO.xoxoShaderMask');
}

//===========================================================================
// UpdatePrecacheStaticMeshes
//
// Called on the pickup by the LevelInfo if it previously existed in the map.
//===========================================================================
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.XOXOPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.XOXOPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.XOXOAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.Heart');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.X');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.XOXO.O');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.XOXO.XOXOPickupLo'
     PickupDrawScale=1.450000
     InventoryType=Class'BWBPOtherPackPro.XOXOStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up le big XOXO."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.XOXO.XOXOPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.500000
}
