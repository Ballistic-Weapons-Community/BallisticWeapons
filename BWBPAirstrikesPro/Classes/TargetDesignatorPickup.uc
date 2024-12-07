class TargetDesignatorPickup extends BallisticWeaponPickup
	placeable;
	
#EXEC OBJ LOAD File=BWBP_OP_Static.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Designator.DesignatorBase');
	L.AddPrecacheMaterial(Combiner'BWBP_OP_Tex.Designator.DesignatorScreenModel');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Designator.DesignatorBase');
	Level.AddPrecacheMaterial(Combiner'BWBP_OP_Tex.Designator.DesignatorScreenModel');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupLo'
     PickupDrawScale=1.250000
     InventoryType=Class'BWBPAirstrikesPro.TargetDesignator'
     RespawnTime=120.000000
     PickupMessage="You picked up the MAU-52 Target Designator."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Designator.DesignatorPickupHi'
     Physics=PHYS_None
     DrawScale=1.450000
     CollisionHeight=6.000000
}
