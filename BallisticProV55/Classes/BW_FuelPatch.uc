//=============================================================================
// BW_FuelPatch.
//
// A base class that makes flamer code a lot cleaner. Adds basic features like
// fuel behavior, ignition and an extra extent var.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BW_FuelPatch extends BallisticEmitter;

var() float		Fuel;			// Fuel remaining
var() float		MaxFuel;		// Max allowed fuel
var() float		DrainRate;		// Fuel drained per second
var() int		Extent;			// The extent of this deposit. Min distance it should be from other fuel patches

var   byte		NetFuel;		// Clumsy replicated fuel level. Its a byte so ian alternative will be needed if fuel MUST go above 255

// AI stuff
var() bool		bCanIgnite;		// This is a raw fuel patch and it can still be ignited with fire
var() bool		bCanFeed;		// This is a can still be fed with more fuel
var   bool		bIgnited;

replication
{
	reliable if (Role == ROLE_Authority)
		NetFuel, bIgnited;
}

function Reset()
{
	Destroy();
}

simulated event PostNetReceive()
{
	Fuel = NetFuel;
	FuelChanged();
}

simulated function Ignite(Pawn EventInstigator)
{
	bIgnited = true;
}

// Use this to set fuel level
function SetFuel(float Amount)
{
	Fuel = Amount;
	NetFuel = Fuel;
	FuelChanged();
}
// Add some fuel. Kept below max
function AddFuel(float Amount)
{
	SetFuel(FMin(Fuel + Amount, MaxFuel));
}
// Client and Server notification of fuel change. Used in subclasses
simulated function FuelChanged();
// Called when fuel runs out
simulated function FuelOut()
{
	SetTimer(0,false);
	Kill();
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.5, true);
}

simulated event Timer()
{
	Fuel -= TimerRate * DrainRate;

	FuelChanged();

	if (Fuel <= 0)
		FuelOut();
}

defaultproperties
{
     Fuel=10.000000
     MaxFuel=100.000000
     DrainRate=1.000000
     Extent=48
     bCanIgnite=True
     bCanFeed=True
     bNetNotify=True
}
