//=============================================================================
// T10CloudControl.
//
// An invisible actor responsible for handling a system of T10 gas clouds. It
// does the damage using the could to find victims and unsures that players
// only get damaged once per cycle even if they are touching multiple clouds.
// Handles the spawning of new clouds when the grenade has moved enough.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ChaffCloudControl extends Actor;

var   array<ChaffCloud>		Clouds;
var() int					Damage;
var() class<DamageType>		DamageType;
var   vector				CloudSpawnLoc, OldCloudSpawnLoc;
var   bool					bNoMore;
var	  Controller			InstigatorController;
var	  float					ChaffRadius;

replication
{
	reliable if (Role == ROLE_Authority)
		CloudSpawnLoc;
}

function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.15, true);
	ServerSpawnCloud();
}

function ServeCustomers()
{
  	local M46Mine ThingA;
  	local M50Camera ThingB;
  	local FP9Bomb ThingC;
  	local G5Rocket ThingD;
  	local G51Mine_Sensor ThingE;
  	local LonghornGrenade ThingF;
  	local MARSMine_Sensor ThingG;
  	local MGLGrenadeRemote ThingH;
  	local PUMAProjectile ThingI;
  	local PUMAProjectileImpact ThingJ;
	
	foreach RadiusActors( class 'M46Mine', ThingA, ChaffRadius, Location )
   	{
    	ThingA.Explode(ThingA.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'M50Camera', ThingB, ChaffRadius, Location )
   	{
    	ThingB.TakeDamage(50, Instigator, Location, vect(0,0,0), DamageType);
   	}
	foreach RadiusActors( class 'FP9Bomb', ThingC, ChaffRadius, Location )
   	{
    	ThingC.Explode(ThingC.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'G5Rocket', ThingD, ChaffRadius, Location )
   	{
    	ThingD.Explode(ThingD.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'G51Mine_Sensor', ThingE, ChaffRadius, Location )
   	{
    	ThingE.Explode(ThingE.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'LonghornGrenade', ThingF, ChaffRadius, Location )
   	{
    	ThingF.Explode(ThingF.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'MARSMine_Sensor', ThingG, ChaffRadius, Location )
   	{
    	ThingG.Explode(ThingG.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'MGLGrenadeRemote', ThingH, ChaffRadius, Location )
   	{
    	ThingH.Explode(ThingH.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'PUMAProjectile', ThingI, ChaffRadius, Location )
   	{
    	ThingI.Explode(ThingI.Location, vect(0,0,0));
   	}
	foreach RadiusActors( class 'PUMAProjectileImpact', ThingJ, ChaffRadius, Location )
   	{
    	ThingJ.Explode(ThingJ.Location, vect(0,0,0));
   	}
}

simulated function Tick(float DT)
{
	local int i;
	if (Clouds.length > 0 && Clouds[Clouds.length-1] != None && Clouds[Clouds.length-1].Density < 4.0)
	{
		Clouds[Clouds.length-1].Density = FMin(1.5, Clouds[Clouds.length-1].Density + DT);
		Clouds[Clouds.length-1].Emitters[0].InitialParticlesPerSecond = Clouds[Clouds.length-1].Density * 0.7;
	}
	if (LifeSpan < 3 && !bNoMore)
	{
		bNoMore = true;
		for(i=0;i<Clouds.length;i++)
			if (Clouds[i] != None)
				Clouds[i].Kill();
	}
}

function Timer()
{
	CloudTravel();
	ServeCustomers();
}

function CloudTravel()
{
	if (Owner != None && (Clouds.length < 1 || Clouds[Clouds.length-1]==None || VSize(Clouds[Clouds.length-1].Location - Owner.Location) > 192))
	{
		if (Clouds.length > 0 && Clouds[Clouds.length-1] != None)
			Clouds[Clouds.length-1].Terminate(3.0);
		if (!bNoMore)
			ServerSpawnCloud();
	}
}
simulated function CloudDie(ChaffCloud C)
{
	local int i;

	for(i=0;i<Clouds.length;i++)
		if (Clouds[i] == C)	{
			Clouds.Remove(i,1);
			break;			}
}

simulated function SpawnCloud(vector V)
{
	local ChaffCloud C;
	local Actor Underneath;
	local Vector dump, trash;
	
	Underneath = Trace (dump, trash, V - vect(0,0,1536), V, false);
	
	if (Mover(Underneath) != None)
		return;
	
	if (Owner != None)
		C = Spawn(class'ChaffCloud',self,,V, Rotator(Owner.Velocity));
	else if (Clouds.length>0 && Clouds[Clouds.length-1] != None)
		C = Spawn(class'ChaffCloud',self,,V, Rotator(V - Clouds[Clouds.length-1].Location));
	else if (Instigator != None)
		C = Spawn(class'ChaffCloud',self,,V, Rotator(V - Instigator.Location));
	else
		C = Spawn(class'ChaffCloud',self,,V);
	if (C != None)
	{
		Clouds[Clouds.length] = C;
		C.Instigator = Instigator;
	}
}

function ServerSpawnCloud ()
{
	local Vector HitLoc,HitNorm;
	local Actor T;

	T = Trace(HitLoc, HitNorm, Owner.Location + vect(0,0,32), Owner.Location, false);
	if (T == None)	HitLoc = Owner.Location + vect(0,0,32);

	CloudSpawnLoc = HitLoc;
	SpawnCloud(HitLoc);
}

simulated function Destroyed()
{
	local int i;
	for(i=0;i<Clouds.length;i++)
		if (Clouds[i] != None)
			Clouds[i].Kill();
	super.Destroyed();
}

simulated event PostNetReceive()
{
	if (CloudSpawnLoc != OldCloudSpawnLoc)	
	{	
		OldCloudSpawnLoc = CloudSpawnLoc;
		SpawnCloud(CloudSpawnLoc);
	}
}

defaultproperties
{
	 ChaffRadius=300
     Damage=0
     DamageType=Class'BWBP_SKC_Pro.DTChaffGrenadeRadius'
     bHidden=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=6.000000
     bNetNotify=True
}
