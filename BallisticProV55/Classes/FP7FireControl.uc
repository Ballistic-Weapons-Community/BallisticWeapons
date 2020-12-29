//=============================================================================
// FP7FireControl.
//
// This is spawned when a fire grenade explodes. It lights up players, plays
// sounds and effects and spawns all other sub fire stuff...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7FireControl extends Actor;

const MAX_FIRE_SPOTS = 40;

struct HitPawnInfo
{
	var Pawn HitPawn;
	var float HitTime;
};

var 	int				Ident;
var() float			DamageRadius;			// Radius in which to immolate players
var	bool			bHeld;					// This fire was detonated in hand. Use held messages
var	Vector		GroundFireSpots[MAX_FIRE_SPOTS];	// Vectors sent to client to tell it where to spawn fires
var() class<BCImpactManager>	ImpactManager;	// Impact manager to spawn on final hit
var	array<HitPawnInfo>	HitPawnData;
var	float			Damage, BaseDamage;
var   float			RepulsionForceMag;
var array<FP7GroundFire>	Fires;
var	bool 			bClientFiresSpawned;

replication
{
	reliable if (Role == ROLE_Authority)
		GroundFireSpots;
}

function Reset()
{
	Destroy();
}

//Prevents multiple hits when fire patches overlap
function TryDamage (Pawn Victim, float Interval, class<DamageType> DamageType)
{	
	local int Index;
	local Vector XYVel;

	Index = FindIndex(Victim);

	if (HitPawnData[Index].HitTime + Interval < Level.TimeSeconds || HitPawnData[Index].HitTime == 0 )
	{
		HitPawnData[Index].HitTime = Level.TimeSeconds;
		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Victim.Location, vect(0,0,0), DamageType);
		if ( /*Instigator != Victim &&*/ Victim.Controller != None && Victim.Controller.SameTeamAs(Instigator.Controller))
		{
			//bog down allies attempting to crawl through this fp7's fire
			XYVel = -Victim.Velocity;
			XYVel.Z = 0;
			Victim.AddVelocity(XYVel + RepulsionForceMag * Normal(Victim.Location - Location) + vect(0,0,20));
		}
	}
}

//Stumbled across some useful code
function int FindIndex (Pawn Sought)
{	
	local int i;
	
	for(i=0; i < HitPawnData.Length && Sought != HitPawnData[i].HitPawn; i++);

	if (i == HitPawnData.Length)
	{
		HitPawnData.Length = i + 1;
		HitPawnData[i].HitPawn = Sought;
	}
	
	return i;
}

//===========================================================================
// NotifyPutOut
//
// Called from a weapon which hit one of our fires.
// Accepts the location and radius of the attack which removed the fire.
//===========================================================================
function NotifyPutOut(vector DouseLoc, float DouseRad)
{
	local int i;
	
	for (i=0; i < Fires.Length; i++)
	{
		if (Fires[i] == None)
			continue; //required for updating GroundFireLocs
			
		if (VSize(Fires[i].Location - DouseLoc) <= DouseRad)
		{
			if (Level.NetMode == NM_DedicatedServer)
				Fires[i].Destroy();
			else Fires[i].Kill();
			//Notify client that it must destroy fires
			GroundFireSpots[i] = vect(0,0,0);
		}
	}
}

simulated function PostNetBeginPlay()
{
	if (Role < ROLE_Authority)
		Initialize();
}

simulated function Initialize()
{
    local int i;
	local vector Start, End, HitLoc, HitNorm;
	local Actor T, A;
	local FP7GroundFire GF;

	// Spawn effects, sounds, etc
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(Location, vect(0,0,1), 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(Location, vect(0,0,1), 0, Instigator);
	}
	// Immolate nearby players
	foreach VisibleCollidingActors( class 'Actor', A, DamageRadius, Location )
	{
		if (xPawn(A)!=None)
			IgniteActor(A);
		class'BallisticDamageType'.static.Hurt(A, (1.0-(VSize(A.Location - Location)/DamageRadius)) * BaseDamage, Instigator, A.Location, Normal(A.Location - Location)*500, class'DTFP7Immolation');
	}
	if (level.NetMode == NM_Client)
		return;

	// Spawn all the fires to set up an area of destruction
	Start = Location+vect(0,0,8);
	for(i=0;i<MAX_FIRE_SPOTS;i++)
	{
		End = VRand();
		End.Z = Abs(End.Z);
		End = Start + End *DamageRadius * 0.7;
		T = Trace(HitLoc, HitNorm, End, Start,, vect(6,6,6));
		if (T==None) 
			HitLoc=End;

		GF = Spawn(class'FP7GroundFire',self,,HitLoc, rot(0,0,0));
		if (GF!=None)
		{
			GF.Velocity = HitLoc - Location;
			GF.Instigator = Instigator;
		    if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
				GF.InstigatorController = Instigator.Controller;
				GF.FireControl = self;
			// Tell client where to spawn them
			GroundFireSpots[i] = HitLoc;
			if (bHeld)
				GF.DamageType = class'DTFP7held';
		}
	}
}


simulated function PostNetReceive()
{
	local int i;
	local FP7GroundFire F;
	
	if (level.NetMode != NM_Client)
		return;

	if (!bClientFiresSpawned)
	{
		for (i=0;i<ArrayCount(GroundFireSpots);i++)
		{
			if (GroundFireSpots[i] != vect(0,0,0))
			{
				F = Spawn(class'FP7GroundFire',self,,GroundFireSpots[i], rot(0,0,0));
				if (F != None)
					F.Velocity = GroundFireSpots[i] - Location;
			}
		}
		bClientFiresSpawned=True;
	}
	
	else
	{
		for(i=0; i < Fires.Length; i++)
		{
			if (Fires[i] != None && GroundFireSpots[i] == vect(0,0,0))
				Fires[i].Kill();
		}
	}
}

simulated function GainedChild(Actor A)
{
	if (FP7GroundFire(A) == None)
		return;
	Fires[Fires.Length] = FP7GroundFire(A);
}
//===========================================================================
// LostChild removes dead fires from the list.
//===========================================================================
simulated function LostChild(Actor A)
{
	local int i;
	
	if (FP7GroundFire(A) == None)
		return;
	for (i=0; i < Fires.Length && Fires[i] != A; i++);
	
	if (i < Fires.Length)
		Fires.Remove(i, 1);
}

simulated function IgniteActor(Actor A)
{
	local FP7ActorBurner PF;

	PF = Spawn(class'FP7ActorBurner',self, ,A.Location);
	PF.Instigator = Instigator;

    if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
		PF.InstigatorController = Instigator.Controller;
	if (bHeld)
		PF.DamageType = class'DTFP7held';
	PF.Initialize(A);
}

defaultproperties
{
     DamageRadius=256.000000
     ImpactManager=Class'BallisticProV55.IM_FireExplode'
     Damage=25.000000
     BaseDamage=40.000000
     RepulsionForceMag=250.000000
     LightType=LT_Flicker
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     bHidden=True
     bDynamicLight=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BW_Core_WeaponSound.FP7.FP7FireLoop'
     LifeSpan=10.000000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     bNetNotify=True
}
