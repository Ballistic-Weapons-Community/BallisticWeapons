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

struct SavedRotation
{
    var Rotator rotation;
    var float   time;
};

//=============================================================================
// Variables
//=============================================================================
var() float         MaxUnlagTime;                           // Maximum rewind time in ms. Players with latency higher than this will still be required to lead shots.
var xPawn           UnlaggedPawn;                           // The pawn whom this collision represents
var bool            bUnlagged;                              // If true, this collision represents the owner Pawn's hit cylinder and the owner Pawn's collision is disabled
var float           LastLocationUpdateTime;
var InterpCurve     LocX, LocY, LocZ, CollRadius, CollHeight;   // Interpolation curves for determining location, collision radius and collision height for any given period in time
var array<SavedRotation>  Rotations;

var bool            PawnCollideActors, PawnBlockActors, PawnBlockPlayers;
/**
Update the pawn location for this tick.
*/
function Tick(float DeltaTime)
{
    if (UnlaggedPawn != None)
        UpdateUnlagLocation();
}

/**
Remember the last ticks' locations for serverside ping compensation.
*/
final function UpdateUnlagLocation()
{
    local int i;

    if (LastLocationUpdateTime == Level.TimeSeconds || !UnlaggedPawn.bCollideActors || UnlaggedPawn.Physics != PHYS_Walking && UnlaggedPawn.Physics != PHYS_Falling && UnlaggedPawn.Physics != PHYS_Flying)
        return;

    LastLocationUpdateTime = Level.TimeSeconds;

    while (LocX.Points.Length > 1 && LocX.Points[1].InVal < LastLocationUpdateTime - MaxUnlagTime) 
    {
        //log(LastLocationUpdateTime@"- removing"@LocationHistory.LocX.Points[0].InVal);
        LocX.Points.Remove(0, 1);
        LocY.Points.Remove(0, 1);
        LocZ.Points.Remove(0, 1);
        CollRadius.Points.Remove(0, 1);
        CollHeight.Points.Remove(0, 1);
    }

    while (Rotations.Length > 1 && Rotations[1].time < LastLocationUpdateTime - MaxUnlagTime)
    {
        Rotations.Remove(0, 1);
    }
    
    i = LocX.Points.Length;

    LocX.Points.Length = i + 1;
    LocX.Points[i].InVal = LastLocationUpdateTime;
    LocX.Points[i].OutVal = UnlaggedPawn.Location.X;

    LocY.Points.Length = i + 1;
    LocY.Points[i].InVal = LastLocationUpdateTime;
    LocY.Points[i].OutVal = UnlaggedPawn.Location.Y;

    LocZ.Points.Length = i + 1;
    LocZ.Points[i].InVal = LastLocationUpdateTime;
    LocZ.Points[i].OutVal = UnlaggedPawn.Location.Z;

    CollRadius.Points.Length = i + 1;
    CollRadius.Points[i].InVal = LastLocationUpdateTime;
    CollRadius.Points[i].OutVal = UnlaggedPawn.CollisionRadius;

    CollHeight.Points.Length = i + 1;
    CollHeight.Points[i].InVal = LastLocationUpdateTime;
    CollHeight.Points[i].OutVal = UnlaggedPawn.CollisionHeight;

    i = Rotations.Length;
    Rotations.Length = i + 1;

    Rotations[i].Rotation = UnlaggedPawn.Rotation;
    Rotations[i].time = LastLocationUpdateTime;
}

/**
Enable the unlagged collision cylinder.
*/
final function EnableUnlag(float PingTime)
{
    local vector UnlaggedLocation;
    local float UnlagTime;
    local range UnlagTimeRange;
    local float UnlaggedRadius, UnlaggedHeight;
    local int i;
  
    if (Level.NetMode == NM_Standalone || UnlaggedPawn == None || !UnlaggedPawn.bCollideActors || UnlaggedPawn.Health <= 0)
        return;

    UpdateUnlagLocation();
    
    InterpCurveGetInputDomain(LocX, UnlagTimeRange.Min, UnlagTimeRange.Max);
    //log(Name @ "Unlagging:" @ PingTime @ UnlagTimeRange.Min @ UnlagTimeRange.Max);
    UnlagTime = FClamp(Level.TimeSeconds - PingTime, Level.TimeSeconds - MaxUnlagTime, UnlagTimeRange.Max);
    UnlaggedRadius = InterpCurveEval(CollRadius, UnlagTime);
    UnlaggedHeight = InterpCurveEval(CollHeight, UnlagTime);
    // should result in 0/0 if too early, i.e. no chance to hit with trace weapon
    
    UnlagTime = FClamp(Level.TimeSeconds - PingTime, UnlagTimeRange.Min, UnlagTimeRange.Max);
    UnlaggedLocation.X = InterpCurveEval(LocX, UnlagTime);
    UnlaggedLocation.Y = InterpCurveEval(LocY, UnlagTime);
    UnlaggedLocation.Z = InterpCurveEval(LocZ, UnlagTime);
    
    SetLocation(UnlaggedLocation);
    SetCollisionSize(UnlaggedRadius, UnlaggedHeight);

    SetCollision(true, true, true);

/*
    PawnCollideActors = UnlaggedPawn.bCollideActors;
    PawnBlockActors = UnlaggedPawn.bBlockActors;
    PawnBlockPlayers = UnlaggedPawn.bBlockPlayers;
    
    UnlaggedPawn.SetCollision(false, false, false);
*/

    UnlaggedPawn.bBlockZeroExtentTraces=False;
    UnlaggedPawn.bBlockNonZeroExtentTraces=False;

    for (i = 0; i < Rotations.Length - 1 && Rotations[i].time >= UnlagTime; ++i);

    SetRotation(Rotations[i].Rotation);

    //log(Name @ "Pawn: X:" $ UnlaggedPawn.Location.X $ "Y: " $ UnlaggedPawn.Location.Y $ "Z: " $ UnlaggedPawn.Location.Z);
    //log(Name @ "Collision: X:" $ Location.X $ "Y: " $ Location.Y $ "Z: " $ Location.Z  $ " Rot:" $ Rotation $ " ColH: " $ CollisionHeight $ " ColR:" $ CollisionRadius);
    
    bUnlagged = True;
}

/*
If in rewind state, redirect damage taken by the cylinder (explosive rounds, FP9 hijack etc) to the owning Pawn
*/
function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, Vector Momentum, class<DamageType> damageType, optional int HitIndex)
{
    if (!bUnlagged || UnlaggedPawn == None)
        return;

	UnlaggedPawn.TakeDamage( Damage, InstigatedBy, Hitlocation, Momentum, damageType);
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

/*
    if (UnlaggedPawn != None && UnlaggedPawn.Health > 0)
    {
        //log(Name @ "Pawn: Restoring collision parameters");
        UnlaggedPawn.SetCollision(PawnCollideActors, PawnBlockActors, PawnBlockPlayers);
    }    
*/

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
     MaxUnlagTime=1.000000
     bHidden=True
     RemoteRole=ROLE_None
}
