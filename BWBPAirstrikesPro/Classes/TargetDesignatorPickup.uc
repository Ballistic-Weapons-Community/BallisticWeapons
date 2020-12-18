class TargetDesignatorPickup extends BallisticWeaponPickup
	placeable;
	
#EXEC OBJ LOAD File=BWBPOtherPackStatic.usx
#EXEC OBJ LOAD File=BallisticSounds2.uax

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Designator.DesignatorBase');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Designator.DesignatorScreen');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Designator.DesignatorScreenNo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.Designator.DesignatorPickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.Designator.DesignatorPickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBPAirstrikesPro.TargetDesignator'
     RespawnTime=120.000000
     PickupMessage="You picked up the MAU-52 Target Designator."
     PickupSound=Sound'BallisticSounds2.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.Designator.DesignatorPickup'
     Physics=PHYS_None
     DrawScale=1.450000
     CollisionHeight=6.000000
}
