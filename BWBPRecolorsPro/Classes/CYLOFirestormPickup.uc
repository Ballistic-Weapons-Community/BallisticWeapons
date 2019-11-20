//=============================================================================
// M50Pickup.
//=============================================================================
class CYLOFirestormPickup extends BallisticWeaponPickup
	placeable;
	
#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx
#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx

var float	HeatLevel;
var float	HeatTime;

function InitDroppedPickupFor(Inventory Inv)
{
    Super.InitDroppedPickupFor(None);

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
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.FirestormBase');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.CYLOMagFirestorm');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.Reflex');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.FirestormBase');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.CYLOMagFirestorm');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.Reflex');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOMk2');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOMk2'
     InventoryType=Class'BWBPRecolorsPro.CYLOAssaultWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the CYLO 'Firestorm' V."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.CYLO.CYLOMk2'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
