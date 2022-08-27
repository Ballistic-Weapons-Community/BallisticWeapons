//=============================================================================
// Supercharger_ChargeControl.
//
// Passive control actor used to list and control interactions between electric
// zaps and supercharged areas
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_ChargeControl extends Info;

var  array<struct SingeVictim {var Pawn Vic; var int Burns; var float NextReduceTime;}> SingeVictims;

struct FlameHit				// Info about a shot fired
{
	var Pawn			Instigator;
	var vector			HitLoc;	// Where it hits
	var vector			HitNorm;// Normal for hit
	var float			HitTime;// When it will hit
	var actor			HitActor;
	var int				TriggerType;// Triggering Gun. 1, XM-88 2, AK-91
};
var   array<FlameHit>		FlameHits;		// Shots fired, used to time impacts

struct SingeSpot			// Info for a spot/area that was hit with fire
{
	var vector	Loc;			// The spot
	var int		Hits;			// How many hits so far
	var RX22ASurfaceFire Fire;	// The fire actor if there is one
};
var   array<SingeSpot> SingeSpots;		// Places that have been flamed


// Purpose: Cause sprayed flame interaction
// Actions: Spawn a projectile and register the delayed hit
// Sources: Flamer primary fire with traced hit info
// Trigger: triggerWeaponType used to track damage types. 1 for supercharger, 2 for AK-91
simulated function FireShot(vector Start, Vector End, float Dist, bool bHit, vector HitNorm, Pawn InstigatedBy, actor HitActor, int triggerWeaponType)
{
	local Supercharger_ZapProjectile Proj1;
	local AK91_ZapProjectile Proj2;
	local int i;

	if (triggerWeaponType == 1)
	{
		Proj1 = Spawn (class'Supercharger_ZapProjectile',InstigatedBy,, Start, Rotator(End-Start));
		if (Proj1 != None)
		{
			Proj1.Instigator = InstigatedBy;
			Proj1.ChargeControl = self;
			Proj1.InitFlame(End);
		}
	}
	else if (triggerWeaponType == 2)
	{
		Proj2 = Spawn (class'AK91_ZapProjectile',InstigatedBy,, Start, Rotator(End-Start));
		if (Proj2 != None)
		{
			Proj2.Instigator = InstigatedBy;
			Proj2.ChargeControl = self;
			Proj2.InitFlame(End);
		}
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
		FlameHits[i].TriggerType = triggerWeaponType;
	}
}

// Purpose: Facilitate and limit conditions for igniting players, track gun type
// Actions: Increment singe count for the specified enemy, possibly start an ActorBurner
// Sources: Flame projectiles and radius damagers or fires that can ignite a player
function FireSinge(Pawn P, Pawn InstigatedBy, int triggerType, optional int numZaps)
{
	local int i;

		for (i=0;i<SingeVictims.length;i++)
			if (SingeVictims[i].Vic == P)
			{
				SingeVictims[i].NextReduceTime = level.TimeSeconds + 2.0;
				if (numZaps == 0)
					SingeVictims[i].Burns++;
				else
					SingeVictims[i].Burns += numZaps;
				if (SingeVictims[i].Burns == 25)
					MakeNewExploder(P, InstigatedBy, triggerType);
				if (SingeVictims[i].Burns == 15)
					MakeNewBurner(P, InstigatedBy, triggerType);
				return;
			}
		SingeVictims.length = i+1;
		SingeVictims[i].NextReduceTime = level.TimeSeconds + 2.0;
		SingeVictims[i].Vic = P;
		SingeVictims[i].Burns = 1;
}

// Purpose: Facilitate and limit conditions for causing wall fires, flame wall hit interaction
// Actions: Radius damage/singe, increment singe count for hit location, start wall fire, addfuel to existing fire
// Sources: Flame firemode hit detection or preordered hits
simulated function DoFlameHit(FlameHit Hit)
{
	local int i;
	local int LocalTriggerType;
	
	LocalTriggerType = Hit.TriggerType;

	if (LocalTriggerType == 1)
		BurnRadius(2, 128, class'DT_SuperchargeZapped', 0, Hit.HitLoc, Hit.Instigator, LocalTriggerType);
	else if (LocalTriggerType == 2)
		BurnRadius(2, 128, class'DT_AK91Zapped', 0, Hit.HitLoc, Hit.Instigator, LocalTriggerType);

		for(i=0;i<SingeSpots.length;i++)
			if (VSize(SingeSpots[i].Loc-Hit.HitLoc) < 128)
			{
				SingeSpots[i].Hits++;
				if (SingeSpots[i].Hits > 20)
				{
					class'IM_XMBurst'.static.StartSpawn(Hit.HitLoc + Hit.HitNorm * 32, Hit.HitNorm, 0, self);
					if (Hit.TriggerType == 1)
						BurnRadius(50, 300, class'DT_Supercharge', 500, Hit.HitLoc, Hit.Instigator, LocalTriggerType);
					if (Hit.TriggerType == 2)
						BurnRadius(50, 300, class'DT_AK91Supercharge', 500, Hit.HitLoc, Hit.Instigator, LocalTriggerType);
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
			class'IM_LS14Impacted'.static.StartSpawn(Hit.HitLoc, Hit.HitNorm, 0, self);
		}

}


// Internal functions

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

simulated function BurnRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Pawn InstigatedBy, int TriggerType, Optional actor Victim)
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
				FireSinge(Pawn(Victims), InstigatedBy, TriggerType);
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
function MakeNewBurner (Actor Other, Pawn InstigatedBy, int triggerType)
{
	local Supercharger_ActorFire PF1;
	local AK91_ActorFire PF2;

	if (triggerType == 1)
	{
		PF1 = Spawn(class'Supercharger_ActorFire',InstigatedBy,,Other.Location, Other.Rotation);
		PF1.SetFuel(5);
		PF1.Initialize(Other);
	}
	else if (triggerType == 2)
	{
		PF2 = Spawn(class'AK91_ActorFire',InstigatedBy,,Other.Location, Other.Rotation);
		PF2.SetFuel(5);
		PF2.Initialize(Other);
	}

}

function MakeNewExploder (Actor Other, Pawn InstigatedBy, int triggerType)
{

	local Supercharger_Detonator Proj1;
	local AK91_Detonator Proj2;

	if (triggerType == 1)
	{
		Proj1 = Spawn (class'Supercharger_Detonator',InstigatedBy,,Other.Location, Other.Rotation);
		if (Proj1 != None)
		{
			Proj1.Instigator = InstigatedBy;
			Proj1.ChargeControl = self;
		}
	}
	else if (triggerType == 2)
	{
		Proj2 = Spawn (class'AK91_Detonator',InstigatedBy,,Other.Location, Other.Rotation);
		if (Proj2 != None)
		{
			Proj2.Instigator = InstigatedBy;
			Proj2.ChargeControl = self;
		}
	}
}


defaultproperties
{
     RemoteRole=ROLE_SimulatedProxy
     bNetNotify=True
}
