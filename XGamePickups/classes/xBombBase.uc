//=============================================================================
// xBombBase.
// For decoration only, this actor serves no game-related purpose!
//=============================================================================
class xBombBase extends Decoration;

defaultproperties
{   
    DrawScale=1.50000
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.BombSpawnMesh
    bCollideWorld=false
    bCollideActors=false
    bStatic=false
}