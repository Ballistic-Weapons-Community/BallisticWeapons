//=============================================================================
// DefibFistsPickup
//=============================================================================
class DefibFistsPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Defist.LCestus');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupLo');	
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Defist.LCestus');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupLo');	
}

defaultproperties
{
	 bOnSide=False
	 LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupLo'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBP_OP_Pro.DefibFists'
     RespawnTime=70.000000
	 StaticMesh=StaticMesh'BWBP_SKC_Static.DefibFists.DefibFistsPickupHi'
	 PickupSound=Sound'BW_Core_WeaponSound.A73.A73Pullout'
     PickupMessage="You got the Combat Defibrillators."
     Physics=PHYS_None
     DrawScale=0.820000
	 PrePivot=(Z=60.000000)
     TransientSoundVolume=0.600000
     TransientSoundRadius=128.000000
     CollisionRadius=16.000000
     CollisionHeight=28.000000
     Mass=10.000000
}