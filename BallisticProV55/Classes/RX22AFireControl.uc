//=============================================================================
// RX22AFireControl.
//
// Passive control actor used to list and control interactions between fires
// and fuel deposits
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AFireControl extends Info;

//var		RX22AFireControl	WorldFireControl;			// Quick way to get the FireControl. Set when a RX22AFireControl is spawned.

// Considder splitting Current Functions:
//	List + Interactions for fires and gas
//  Stoopid delays and lists for flamer and its multi hit fires


// Elements:

// -FireSpray				Forget, weapon can handle it. Just detach and unhide when die
// -GasSpray				Same...
// -List of Fires.
// -List of Fuel clouds
// -List of lit actors
// -List of fueled actors

/*
Elements:
	FireSpray				FM / Weapon / Attachment
	GasSpray				FM / Weapon / Attachment
	GasTank					Attachment / gasTank
	RogueTank				RogueTank / Attachment / Weapon
	FireHitEffect
	FireHitRadius
	FireEnemyDetection
	EnemyFire
	FloorFire
	GasPool
	GasCloud
	GasSoak
	CloudExplosion

Classes:
	FireSpray				PrimaryFire Effect
	GasSpray				SecondaryFire Effect
	Weapon					The gun
	Attachment				Gun 3PA. Handles 3P FX, FireSpray, GasSpray, FireHit, TankSpawn
	Control					WorldFireList and controls
	Primary
	Secondary
	GasTank					3PA. Takes damage, boosts player, explodees, leak + blast FX
	RogueTank				Detached tank actor
	Projectile				Actor hit detection for primary
	WallFire				Surface aligned fire effect. Fuel level, Radius HD, ignition
	ActorFire				Victim attached fire. Fuel, Radius HD, ignition
	GasCloud				Free gas effect. Fuel level, ignitable
	GasPool					Surface aligned gas effect. Fuel level, ignitable
	GasSoak					Victim attached gas. Fuel, ignitable

Lists:
	ActorSinges				FireProjHit / FireRadiusHit count for victims.	Adds up to cause actor fire
	WallSinges				FireHitWall count for different hit locations	Adds up to cause residual fire
	GasPools				All gas pool actors								Used by gas spray to avoid more patchee and add fuel
	GasClouds				All gas cloud actors							Used by gas spray to avoid more clouds and add fuel
	ActorFires				All fires attached to actors					Used by sprays to avoid reignite or soak and add fuel
	ActorSoaks				All gas clouds attached to actors				Used by gas spray to avoid resoak and add fuel
	WallFires				All residual fires								Used by sprays to avoid more fires and add fuel

Fire Spawners:
	SprayFireAtWall
	IgniteGasPatch
	IgniteCloudNearFloor
Burner Spawners:
	IgniteSoak
	SprayFireAtActor
	FireHitRadiusNearActor
Soak Spawners:
	GasSprayActor
	ActorTouchGasCloud

KeyWords:
	Pool		Surface gas deposit
	Cloud		Air gas deposit
	Soak		Attached gas deposit
	Fire		Surface fire
	Burner		Attached fire
	Patch		Any FuelPatch, Gas or Fire

Damages:
	SingedByProjectile	DTRX22ABurned
	FlameHitRadius		DTRX22ABurned
	ResidualFire		DTRX22AFireTrap
	GasCloudExplode		DTRX22ACloudBomb
	ActorBurner			DTRX22AImmolation

Procedures:
	PrimaryFire->SpawnProj->ProjHitActor->???->SpawnActorFire|AddFuelToFire

	PrimaryFire->TraceWall->RegisterWallHit->???->RadiusDamage->???->SpawnActorFire|AddFuelToFire

	PrimaryFire->TraceWall->RegisterWallHit->???->FloorFire|AddFuelToFire

	SecFire->TraceActor->SpawnSoaker|AddFuelToSoak|AddFuelToFire

	SecFire->TraceWall->SpawnGasPool|AddToGasPool

	SecFire->SprayAir->SpawnGasCloud|AddToCloud

	SecFire->SprayIgnition->SwitchToPrimary

	HurtSoak->KillSoak+SpawnActorFire

	HurtCloud->Explode->CheckForFloor->SpawnFire

	HurtPool->Ignite->SpawnFire

	TouchCloud->SpawnSoaker|AddFuelToSoak
*/

var array<BW_FuelPatch>	GasNodes;		// Big list of all fires and fuel deposits
var array<RX22ASurfaceFire>	GroundFires;

var  array<struct SingeVictim {var Pawn Vic; var int Burns; var float NextReduceTime;}> SingeVictims;

struct FlameHit				// Info about a shot fired
{
	var Pawn			Instigator;
	var vector			HitLoc;	// Where it hits
	var vector			HitNorm;// Normal for hit
	var float			HitTime;// When it will hit
	var actor			HitActor;
};
var   array<FlameHit>		FlameHits;		// Shots fired, used to time impacts

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
	{
		for(j=0;j<GroundFires[i].Touching.length;j++)
		{
			if (GroundFires[i].Touching[j] == None || ( Pawn(GroundFires[i].Touching[j]) == None && BW_FuelPatch(GroundFires[i].Touching[j]) == None) )
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
}

//EntryFunctions
/*
//function function FireShot(vector Start, Vector End, float Dist, bool bHit, vector HitNorm, Pawn InstigatedBy)
	SpawnProj
	?HitWall->RegisterHit

//function FireSinge(Pawn P)
	?CustomerRegistered->?HasFire->AddToFire
					   ->!HasFire->AddSinge->?OverTheshold->SpawnActorFire
	!CustomerRegistered->RegisterCustomer

//function SprayWall(vector Loc, vector Norm)
	?NearGasPool->AddFuel
	!NearGasPool->SpawnGasPool

//function SprayAir (vector Loc)
	?NearGasCloud->AddFuel
	!NearGasCloud->SpawnGasCloud

//function SpraySoak(Actor Other)
	?CustomerSoaked->AddFuel
	?CustomerOnFire->AddFuel
	!CustomerSoaked->SpawnSoak

//function function DoFlameHit(vector Loc, vector Norm)
	BurnRadius
	?NearFire->AddFuel
	!NearFire->AddToHitCount?OverTheshold->SpawnFire

//function PatchRemove (Emitter Other)
	RemovePatch

//Function PatchReplace (Emitter OldPatch, Emitter NewPatch)
	ReplacePatch
*/

// Purpose: Cause sprayed flame interaction
// Actions: Spawn a projectile and register the delayed hit
// Sources: Flamer primary fire with traced hit info
simulated function FireShot(vector Start, Vector End, float Dist, bool bHit, vector HitNorm, Pawn InstigatedBy, actor HitActor)
{
	local RX22AProjectile Proj;
	local int i;

	Proj = Spawn (class'RX22AProjectile',InstigatedBy,, Start, Rotator(End-Start));
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
		{
			if (SingeVictims[i].Vic == P)
			{
				SingeVictims[i].NextReduceTime = level.TimeSeconds + 2.0;
				SingeVictims[i].Burns++;

				if (SingeVictims[i].Burns > 10)
					MakeNewBurner(P, 5, InstigatedBy);

				return;
			}
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

	BurnRadius(4, 256, class'DTRX22ABurned', 0, Hit.HitLoc, Hit.Instigator);

	if (NearFire(Hit.HitLoc, Other))
		Other.AddFuel(0.5);
	else if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
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

// Purpose: Create a surface fuel deposit
// Actions: Create new gas pool or add fuel to existing pool
// Sources: Gas firemode hit detection
function SprayWall(vector Loc, vector Norm, Pawn InstigatedBy, Actor HitActor)
{
	local BW_FuelPatch Other;
	if (NearPool(Loc, Other))
		Other.AddFuel(1);
	else
		MakeNewPool(Loc, Norm, InstigatedBy, HitActor);
}
// Purpose: Create a hovering fuel deposit
// Actions: Create new gas cloud or add fuel to existing cloud
// Sources: Gas firemode hit detection
function SprayAir (vector Loc, Pawn InstigatedBy)
{
	local BW_FuelPatch Other;
	if (NearCloud(Loc,Other))
		Other.AddFuel(1.5);
	else
		MakeNewCloud(Loc, InstigatedBy);
}
// Purpose: Create a player-attached fuel deposit
// Actions: Create new gas soak or add fuel to existing soak
// Sources: Gas firemode hit detection, floating gas cloud touches
function SpraySoak(Actor Other, Pawn InstigatedBy, optional float FuelAmount)
{
	local BW_FuelPatch Patch;
	if (FuelAmount == 0)
		FuelAmount =  1;
	if (HasSoak(Other, Patch))
		Patch.AddFuel(FuelAmount);
	else
		MakeNewSoaker(Other, InstigatedBy);
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
/*
//function Tick
	DoHits

//function BurnRadius
	HurtVic
	FireSinge
*/
event Tick(float DT)
{
	local int i;

	super.Tick(DT);

	for (i=0;i<FlameHits.length;i++)
		if (level.TimeSeconds >= FlameHits[i].HitTime)
		{
			DoFlameHit(FlameHits[i]);
			FlameHits.Remove(i,1);
			i--;
		}

	for (i=0;i<SingeVictims.length;i++)
		if (level.TimeSeconds >= SingeVictims[i].NextReduceTime)
		{
			SingeVictims[i].Burns--;
			if (SingeVictims[i].Burns < 1)
			{
				SingeVictims.Remove(i,1);
				i--;
			}
			else
				SingeVictims[i].NextReduceTime = level.TimeSeconds + 0.25;
		}
}

simulated function BurnRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Pawn InstigatedBy, Optional actor Victim)
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if (Pawn(Victims) != None && FRand()-0.4 < damageScale)
				FireSinge(Pawn(Victims), InstigatedBy);
//			if ( Instigator == None || Instigator.Controller == None )
//				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				InstigatedBy,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

// Utility functions
/*
	NearPool
	NearCloud
	HasSoak
	NearFire
	HasBurner
	SpawnFire
	SpawnPool
	SpawnCloud
	SpawnSoak
	SpawnBurner
	GetNodeIndex
*/
function int GetNodeIndex (Emitter Other)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
	{
		if (GasNodes[i] == None)
		{
			GasNodes.Remove(i,1);
			i--;
			continue;
		}
		if (GasNodes[i] == Other)
			return i;
	}
	return -1;
}

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
	GasNodes[GasNodes.length] = Spawn(class'RX22ASurfaceFire',InstigatedBy,,Loc, rotator(Norm));
	GroundFires[GroundFires.length] = RX22ASurfaceFire(GasNodes[GasNodes.length-1]);
	
	if (RX22ASurfaceFire(GasNodes[GasNodes.length-1]) != None)
	{
		RX22ASurfaceFire(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22ASurfaceFire(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}
function MakeNewPool (vector Loc, vector Norm, Pawn InstigatedBy, Actor HitActor)
{
	GasNodes[GasNodes.length] = Spawn(class'RX22AGasPatch',InstigatedBy,,Loc, rotator(Norm));
	if (GasNodes[GasNodes.length-1] != None && RX22AGasPatch(GasNodes[GasNodes.length-1]) != None)
	{
		RX22AGasPatch(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22AGasPatch(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}
function MakeNewCloud (vector Loc, Pawn InstigatedBy)
{
	GasNodes[GasNodes.length] = Spawn(class'RX22AGasCloud',InstigatedBy,,Loc);
	RX22AGasCloud(GasNodes[GasNodes.length-1]).GasControl = self;
}
function MakeNewSoaker (Actor Other, Pawn InstigatedBy)
{
	GasNodes[GasNodes.length] = Spawn(class'RX22AGasSoak',InstigatedBy,,Other.Location, Other.Rotation);
	RX22AGasSoak(GasNodes[GasNodes.length-1]).GasControl = self;
	RX22AGasSoak(GasNodes[GasNodes.length-1]).SetBase(Other);
}
function MakeNewBurner (Actor Other, int Fuel, Pawn InstigatedBy)
{
	local RX22AActorFire PF;

	PF = Spawn(class'RX22AActorFire',InstigatedBy,,Other.Location, Other.Rotation);
	PF.SetFuel(Fuel);
	PF.Initialize(Other);

	GasNodes[GasNodes.length] = PF;
	PF.GasControl = self;
}

function bool NearFire(vector Loc, out BW_FuelPatch Other)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
		if (GasNodes[i] != None && VSize(GasNodes[i].location - loc) < GasNodes[i].Extent /*128*/)
		{
			Other = GasNodes[i];
			return true;
		}
	return false;
}

function bool NearPool(vector Loc, out BW_FuelPatch Other)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
		if (GasNodes[i] != None && VSize(GasNodes[i].location - loc) < GasNodes[i].Extent /*51*/)
		{
			Other = GasNodes[i];
			return true;
		}
	return false;
}

function bool NearCloud(vector Loc, out BW_FuelPatch Other)
{
	local int i;
	for (i=0;i<GasNodes.length;i++)
		if (GasNodes[i] != None && VSize(GasNodes[i].location - loc) < GasNodes[i].Extent /*121*/)
		{
			Other = GasNodes[i];
			return true;
		}
	return false;
}

defaultproperties
{
     RemoteRole=ROLE_SimulatedProxy
     bNetNotify=True
}
