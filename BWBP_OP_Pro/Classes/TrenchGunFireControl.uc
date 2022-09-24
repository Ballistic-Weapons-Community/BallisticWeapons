//=============================================================================
// TrenchGunFireControl.
//
// Passive control actor used to list and control interactions between fires
// and fuel deposits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TrenchGunFireControl extends RX22AFireControl;

//var		TrenchGunFireControl	WorldFireControl;			// Quick way to get the FireControl. Set when a TrenchGunFireControl is spawned.

var array<RX22ASurfaceFire>	GroundFires;

struct SingeSpot			// Info for a spot/area that was hit with fire
{
	var vector	Loc;			// The spot
	var int		Hits;			// How many hits so far
	var RX22ASurfaceFire Fire;	// The fire actor if there is one
};
var   array<SingeSpot> SingeSpots;		// Places that have been flamed

//Azarael - added PostBeginPlay, on the server this will handle the damage for all RX22A fires via global timer.
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	if (Role == ROLE_Authority)
		SetTimer(0.4, true);
}

//Deal damage through any ground fires, respecting the Instigator
function Timer()
{
	local int i,j,k;
	local array<Actor> Served;
	
	for(i=0;i<GroundFires.length;i++)
		for(j=0;j<GroundFires[i].Touching.length;j++)
		{
			if (GroundFires[i].Touching[j] == None || Pawn(GroundFires[i].Touching[j]) == None)
				continue;
			for(k=0;k<Served.length;k++)
				if (Served[k] == GroundFires[i].Touching[j])
					break;
			if (k >= Served.length)	
			{
				GroundFires[i].Toast(GroundFires[i].Touching[j]);
				Served[Served.length] = GroundFires[i].Touching[j];	
			}
		}
}

// Purpose: Cause sprayed flame interaction, taking shotgun spread into consideration, has a rotator
// Actions: Spawn a projectile and register the delayed hit
// Sources: Flamer primary fire with traced hit info
simulated function FireShotRotated(vector Start, vector End, float Dist, bool bHit, vector HitNorm, Pawn InstigatedBy, actor HitActor, Rotator Dir)
{
	local TrenchGunFlameProjectile Proj;
	local int i;
	
	Proj = Spawn (class'TrenchGunFlameProjectile',InstigatedBy,, Start, Dir);
	if (Proj != None)
	{
		Proj.Instigator = InstigatedBy;
		Proj.FireControl = self;
		Proj.InitFlame(End);
	}
	if (bHit)
	{
		i = FlameHits.length;
		FlameHits.length = i + 1;
		FlameHits[i].Instigator = InstigatedBy;
		FlameHits[i].HitLoc = End;
		FlameHits[i].HitNorm = HitNorm;
		FlameHits[i].HitTime = level.TimeSeconds + Dist / 3600;
		FlameHits[i].HitActor = HitActor;
	}
}

// Purpose: Facilitate and limit conditions for igniting players
// Actions: Increment singe count for the specified enemy, possibly start an ActorBurner
// Sources: Flame projectiles and radius damagers or fires that can ignite a player
function FireSinge(Pawn P, Pawn InstigatedBy)
{
	local BW_FuelPatch Patch;
	local int i;

	if (HasBurner(P, Patch))
		Patch.AddFuel(0.5);
	else
	{
		for (i=0;i<SingeVictims.length;i++)
			if (SingeVictims[i].Vic == P)
			{
				SingeVictims[i].NextReduceTime = level.TimeSeconds + 2.0;
				SingeVictims[i].Burns++;
				if (SingeVictims[i].Burns > 10)
					MakeNewBurner(P, 5, InstigatedBy);
				return;
			}
		SingeVictims.length = i+1;
		SingeVictims[i].NextReduceTime = level.TimeSeconds + 2.0;
		SingeVictims[i].Vic = P;
		SingeVictims[i].Burns = 1;
	}
}

// Purpose: Facilitate and limit conditions for causing wall fires, flame wall hit interaction
// Actions: Radius damage/singe, increment singe count for hit location, start wall fire, addfuel to existing fire
// Sources: Flame firemode hit detection or preordered hits
simulated function DoFlameHit(FlameHit Hit)
{
	local int i;
	local BW_FuelPatch Other;

	BurnRadius(4, 256, class'DTTrenchBurned', 0, Hit.HitLoc, Hit.Instigator);

	if (NearFire(Hit.HitLoc, Other))
		Other.AddFuel(0.5);
	else
	{
		for(i=0;i<SingeSpots.length;i++)
			if (VSize(SingeSpots[i].Loc-Hit.HitLoc) < 128)
			{
				SingeSpots[i].Hits++;
				if (SingeSpots[i].Hits > 3)
				{
					MakeNewFire(Hit.HitLoc + Hit.HitNorm * 32, Hit.HitNorm, Hit.Instigator, Hit.HitActor);
					SingeSpots.Remove(i, 1);
					return;
				}
				break;
			}

		if (i>=SingeSpots.length)
		{
			i = SingeSpots.length;
			SingeSpots.length = i + 1;
			SingeSpots[i].Loc = Hit.HitLoc;
			SingeSpots[i].Hits = 1;
			class'IM_RX22AScorch'.static.StartSpawn(Hit.HitLoc, Hit.HitNorm, 0, self);
		}
	}
}




// Purpose: Remove a patch from the main list
// Sources: Gas/Fire expiration, destruction and ignition
function PatchRemove (Emitter Other)
{
	local int i;
	i = GetNodeIndex(Other);
	if (i > -1)
		GasNodes.Remove(i, 1);
	if (RX22ASurfaceFire(Other) != None)
	{
		for (i=0; i<GroundFires.Length && Other != GroundFires[i]; i++);
		if (i < GroundFires.Length)
			GroundFires.Remove(i, 1);
	}
}
// Purpose: Swap an entry in the main list with a different patch
// Sources: Gas deposit ignition
Function PatchReplace (BW_FuelPatch OldPatch, BW_FuelPatch NewPatch)
{
	GasNodes[GetNodeIndex(OldPatch)] = NewPatch;
	if (RX22ASurfaceFire(NewPatch) != None)
		GroundFires[GroundFires.length] = RX22ASurfaceFire(NewPatch);
}
// Internal functions



function bool HasSoak(Actor Other, out BW_FuelPatch Patch)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
		if (GasNodes[i] != None && ( GasNodes[i].Base == Other || (RX22AActorFire(GasNodes[i]) != None && RX22AActorFire(GasNodes[i]).Victim == Other) ))
		{
			Patch = GasNodes[i];
			return true;
		}
	return false;
}
function bool HasBurner(Actor Other, out BW_FuelPatch Patch)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
		if (GasNodes[i] != None && RX22AActorFire(GasNodes[i]) != None && (RX22AActorFire(GasNodes[i]).Victim == Other || GasNodes[i].Base == Other))
		{
			Patch = GasNodes[i];
			return true;
		}
	return false;
}

function MakeNewFire (vector Loc, vector Norm, Pawn InstigatedBy, actor HitActor)
{
	GasNodes[GasNodes.length] = Spawn(class'TrenchGunSurfaceFire',InstigatedBy,,Loc, rotator(Norm));
	GroundFires[GroundFires.length] = RX22ASurfaceFire(GasNodes[GasNodes.length-1]);
	
	if (RX22ASurfaceFire(GasNodes[GasNodes.length-1]) != None)
	{
		RX22ASurfaceFire(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22ASurfaceFire(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}

function MakeNewBurner (Actor Other, int Fuel, Pawn InstigatedBy)
{
	local TrenchGunActorFire PF;

	PF = Spawn(class'TrenchGunActorFire',InstigatedBy,,Other.Location, Other.Rotation);
	PF.SetFuel(Fuel);
	PF.Initialize(Other);

	GasNodes[GasNodes.length] = PF;
	PF.GasControl = self;
}

defaultproperties
{
     RemoteRole=ROLE_SimulatedProxy
     bNetNotify=True
}
