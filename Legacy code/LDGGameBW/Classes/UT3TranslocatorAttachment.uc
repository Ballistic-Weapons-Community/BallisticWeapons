//=============================================================================
// UT3SniperAttachment.uc
// Transcendential locator?..
// 2010, GreatEmerald
//=============================================================================

class UT3TranslocatorAttachment extends TransAttachment;

simulated event BaseChange()
{
    if ( (Pawn(Base) != None) && (Pawn(Base).PlayerReplicationInfo != None) && (Pawn(Base).PlayerReplicationInfo.Team != None) )
    {
        if ( Pawn(Base).PlayerReplicationInfo.Team.TeamIndex == 1 )
        {
            Skins[0] = Material'TranslocatorSkinBlue';
            Skins[1] = Material'TranslocatorSkinBlue';
        }
        else
        {
            Skins[0] = Material'TranslocatorSkinRed';
            Skins[1] = Material'TranslocatorSkinRed';
        }
    }
}

function InitFor(Inventory I)
{
    LoopAnim('WeaponIdle', , 0.0);
    Super.InitFor(I);
}

defaultproperties
{
     Mesh=SkeletalMesh'LDGGameBW_rc.SK_WP_Translocator_3P_Mid'
     RelativeLocation=(Y=-2.000000,Z=1.000000)
     RelativeRotation=(Pitch=32768,Yaw=16384)
     DrawScale=0.850000
     Skins(0)=Shader'LDGGameBW_rc.Translocator.TranslocatorSkinRed'
     Skins(1)=Shader'LDGGameBW_rc.Translocator.TranslocatorSkinRed'
}
