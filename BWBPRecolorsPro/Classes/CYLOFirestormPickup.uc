//=============================================================================
// M50Pickup.
//=============================================================================
class CYLOFirestormPickup extends BallisticWeaponPickup
	placeable;
	
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx

var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(Inv);

    if (CYLOAssaultWeapon(Inv) != None)
    {
    	HeatLevel = CYLOAssaultWeapon(Inv).HeatLevel;
    	HeatTime = level.TimeSeconds;
    }
}

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.FirestormBase');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.CYLOMagFirestorm');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.FirestormBase');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.CYLOMagFirestorm');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.Reflex');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStorm');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStorm'
     InventoryType=Class'BWBPRecolorsPro.CYLOAssaultWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the CYLO 'Firestorm' V."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStorm'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
