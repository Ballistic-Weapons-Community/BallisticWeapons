class TargetDesignatorPickup extends BallisticWeaponPickup
	placeable;
	
#EXEC OBJ LOAD File=BWBP_OP_Static.usx
#EXEC OBJ LOAD File=BW_Core_WeaponSound.uax

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Designator.DesignatorBase');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Designator.DesignatorScreen');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Designator.DesignatorScreenNo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Designator.DesignatorPickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Designator.DesignatorPickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBPAirstrikesPro.TargetDesignator'
     RespawnTime=120.000000
     PickupMessage="You picked up the MAU-52 Target Designator."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Designator.DesignatorPickup'
     Physics=PHYS_None
     DrawScale=1.450000
     CollisionHeight=6.000000
}
