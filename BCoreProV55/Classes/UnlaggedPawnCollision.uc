//=============================================================================
// UnlaggedPawnCollision.
//
// This class is adapted from Wormbo's Unlagged Instagib mod.
// Copyright notice preserved below.
//
// In BW, this class does not forward damage. Instead, BallisticInstantFires 
// check if they've hit this class, and perform their own logic.
//
// Each BallisticPawn is registered with the RewindCollisionManager class on 
// spawn, and removed in its Destroy method. Registration spawns an
// UnlaggedPawnCollision for the BallisticPawn and tracks both in an array.
//
// When BallisticInstantFires begin tracing, the RewindCollisionManager is notified
// to enable unlagged collision for any actors that are registered with it.
//
// Alterations by Azarael 2020
//=============================================================================
/******************************************************************************
Copyright (c) 2006 by Wormbo <wormbo@onlinehome.de>

Keeps track of Pawn positions for unlagging.
******************************************************************************/
class UnlaggedPawnCollision extends Actor
    notplaceable;

const LADDER_SANITY_DIST = 128;
const UPDATE_EPSILON = 0.005f; // ignore positional updates within 5ms

struct HistoryEntry
{
    var Vector  location;
    var Vector  head_location;
    var int     collision_radius;
    var int     collision_height;
    var Rotator rotation;
    var float   timestamp;
};

//=============================================================================
// Variables
//=============================================================================
var() float                 MaxUnlagTime;                           // Maximum rewind time in ms. Players with latency higher than this will still be required to lead shots.
var xPawn                   UnlaggedPawn;                           // The pawn whom this collision represents
var bool                    bUnlagged;                              // If true, this collision represents the owner Pawn's hit cylinder and the owner Pawn's collision is disabled
var float                   LastLocationUpdateTime;
var Vector                  LastHeadLocation;                       // last location of head on trace
var array<HistoryEntry>     History;

var bool            PawnCollideActors, PawnBlockActors, PawnBlockPlayers;
/**
Update the pawn location for this tick.
*/
function Tick(float DeltaTime)
{
    if (UnlaggedPawn != None)
        UpdateUnlagLocation();
}

final function bool HasCompatiblePhysics(xPawn P)
{
    return P.Physics == PHYS_Walking ||
        P.Physics == PHYS_Falling ||
        P.Physics == PHYS_Ladder ||
        P.Physics == PHYS_Flying;
}

/*
Remember the last ticks' locations for serverside ping compensation.
*/
final function UpdateUnlagLocation()
{
    local int i;

    if (LastLocationUpdateTime > Level.TimeSeconds - UPDATE_EPSILON || !UnlaggedPawn.bCollideActors || !HasCompatiblePhysics(UnlaggedPawn))
        return;

    LastLocationUpdateTime = Level.TimeSeconds;

    while (History.Length > 1 && History[0].timestamp < LastLocationUpdateTime - MaxUnlagTime) 
    {
        //log(LastLocationUpdateTime@"- removing"@History[0].timestamp);
        History.Remove(0, 1);
    }
    
    i = History.Length;

    History.Length = i + 1;
    History[i].location = UnlaggedPawn.Location;
    History[i].head_location = UnlaggedPawn.GetBoneCoords('head').Origin;
    History[i].collision_radius = UnlaggedPawn.CollisionRadius;
    History[i].collision_height = UnlaggedPawn.CollisionHeight;
    History[i].rotation = UnlaggedPawn.Rotation;
    History[i].timestamp = LastLocationUpdateTime;
}

/*
Enable the unlagged collision cylinder.
*/
final function EnableUnlag(float PingTime)
{
    local float ShotTime;
    local int i;
  
    if (Level.NetMode == NM_Standalone || UnlaggedPawn == None || !UnlaggedPawn.bCollideActors || UnlaggedPawn.Health <= 0)
        return;

    UpdateUnlagLocation();

    //log(Name @ "Unlagging:" @ PingTime @ UnlagTimeRange.Min @ UnlagTimeRange.Max);
    ShotTime = Level.TimeSeconds - FMin(PingTime, MaxUnlagTime);

    // find index in history
    // use last valid index if not found
    for (i = 0; i < History.Length - 1 && History[i].timestamp <= ShotTime; ++i);

    // TODO:
    // could interpolate, but given tick frequency and UT move speed, probably not needed - could produce some whacky results for interim states

    // sanity checks
    // disable unlag if parameters unlikely to be valid
    if (History[i].collision_radius == 0 || History[i].collision_height == 0)
        return;

    if (UnlaggedPawn.Physics == PHYS_Ladder && VSize(History[i].Location - UnlaggedPawn.Location) > LADDER_SANITY_DIST)
        return;

    SetLocation(History[i].location);
    SetRotation(History[i].rotation);
    SetCollisionSize(History[i].collision_radius, History[i].collision_height);
    LastHeadLocation = History[i].head_location;

    SetCollision(true, true, true); // TODO / FIXME: try (true, false, false) - these don't need to perform blocking

    UnlaggedPawn.bBlockZeroExtentTraces=False;
    UnlaggedPawn.bBlockNonZeroExtentTraces=False;

    //log(Name @ "Pawn: X:" $ UnlaggedPawn.Location.X $ "Y: " $ UnlaggedPawn.Location.Y $ "Z: " $ UnlaggedPawn.Location.Z);
    //log(Name @ "Collision: X:" $ History[i].location.X $ "Y: " $ History[i].location.Y $ "Z: " $ History[i].location.Z  $ " Rot:" $ History[i].rotation $ " ColH: " $ History[i].collision_height $ " ColR:" $ History[i].collision_radius);
    
    bUnlagged = True;
}

/*
If in rewind state, redirect damage taken by the cylinder (explosive rounds, FP9 hijack etc) to the owning Pawn
*/
function TakeDamage( int damage, Pawn instigated_by, Vector hit_loc, Vector momentum_dir, class<DamageType> damage_type)
{
    if (!bUnlagged || UnlaggedPawn == None)
        return;

	UnlaggedPawn.TakeDamage(damage, instigated_by, hit_loc, momentum_dir, damage_type);
}

/**
Disable the unlagged collision cylinder for the UnlaggedPawn.
*/
final function DisableUnlag()
{
    if (Level.NetMode == NM_Standalone) 
        return;

    if (!bUnlagged)
        return;

    UnlaggedPawn.bBlockZeroExtentTraces=True;
    UnlaggedPawn.bBlockNonZeroExtentTraces=True;

    SetCollision(false, false, false);
    bUnlagged = False;


    //if (AIController(UnlaggedPawn.Controller) != None)
    //    Spawn(class'TransEffectRed');
}

//=============================================================================
// Default properties
//=============================================================================
defaultproperties
{
     MaxUnlagTime=0.25f
     bHidden=True
     RemoteRole=ROLE_None
}
