//=============================================================================
// RewindCollisionManager
//
// Manages the assignment and removal of UnlaggedPawnCollisions.
//
// This object is held by a mutator, and passed to BallisticInstantFires and 
// BallisticPawns. BallisticInstantFires notify it when they are performing 
// a trace, so that collisions can be rewound. BallisticPawns notify it when 
// they are created, so that a collision can be created, and when they are 
// destroyed, so that the collision can be freed.
// 
// by Azarael 2020
//=============================================================================
class RewindCollisionManager extends Object;

var LevelInfo                       Level;
var array<UnlaggedPawnCollision>    Collisions;

var int                             StackCount;
var float                           RewindTime;     // Level.TimeSeconds of the current rewind

// Functions called from BallisticPawn
final function RegisterPawn(xPawn pawn) // might not work due to parameter pass bug?
{
    local int index;

    for (index = 0; index < Collisions.Length && Collisions[index].UnlaggedPawn != pawn; ++index);

    if (index < Collisions.Length)
        return;

    Collisions.Insert(Collisions.Length, 1);

    Collisions[index] = pawn.Spawn(class'UnlaggedPawnCollision');
    Collisions[index].UnlaggedPawn = pawn;
}

final function UnregisterPawn(xPawn pawn) // might not work due to parameter pass bug?
{
    local int index;

    // index = index of existing collision or length of array if not found
    for (index = 0; index < Collisions.Length && Collisions[index].UnlaggedPawn != pawn; ++index);

    if (index < Collisions.Length)
    {
        if (StackCount > 0)
            Collisions[index].DisableUnlag();

        // nothing else holds it: without this every pawn that ever lived on the map left an actor ticking behind
        Collisions[index].UnlaggedPawn = None;
        Collisions[index].Destroy();
        Collisions.Remove(index, 1);
    }
}

// Functions called from BallisticWeapon
final function RewindCollisions(Actor requester, float latency)
{
    local int i;

    if (Level.NetMode != NM_DedicatedServer && Level.NetMode != NM_ListenServer)
        return;

    // A rewind only lasts for one shot. One still held from an earlier tick was never restored by the weapon that made it:
    // drop it, or every later shot would be traced against where everyone stood back then
    if (StackCount > 0 && RewindTime != Level.TimeSeconds)
    {
        for (i = 0; i < Collisions.Length; ++i)
            Collisions[i].DisableUnlag();
        StackCount = 0;
    }

    if (StackCount == 0)
    {
        RewindTime = Level.TimeSeconds;

        for (i = 0; i < Collisions.Length; ++i)
        {
            if (Collisions[i].UnlaggedPawn != requester)
            Collisions[i].EnableUnlag(latency);
        }
    }

    ++StackCount;
}

final function RestoreCollisions()
{
    local int i;

    if (StackCount == 0 || Level.NetMode != NM_DedicatedServer && Level.NetMode != NM_ListenServer)
        return;

    --StackCount;

    if (StackCount == 0)
    {
        for (i = 0; i < Collisions.Length; ++i)
            Collisions[i].DisableUnlag();
    }
}