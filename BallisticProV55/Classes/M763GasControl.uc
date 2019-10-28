//=============================================================================
// T10CloudControl.
//
// An invisible actor responsible for handling a system of T10 gas clouds. It
// does the damage using the could to find victims and ensures that players
// only get damaged once per cycle even if they are touching multiple clouds.
// Handles the spawning of new clouds when the grenade has moved enough.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M763GasControl extends Actor;

var   array<M763GasCollider>		Clouds;
var() int									Damage;
var() class<DamageType>			DamageType;

const MAXRANGE = 1280;
const INTERVAL = 6;

function PostBeginPlay()
{
	super.PostBeginPlay();
	SetTimer(0.15, true);
}

function SpawnColliders(vector StartLocation, vector HitLocation)
{
	local float 		MaxSpawnRange;
	local Vector 	SpawnLoc, Dir, AddPerCycle;

	Dir = Normal(HitLocation - StartLocation);
	MaxSpawnRange = VSize(HitLocation - StartLocation);
	
	AddPerCycle = Dir * 2 * class'M763GasCollider'.default.CollisionRadius;
	
	for(SpawnLoc = StartLocation + Dir * 1.2 * (class'M763GasCollider'.default.CollisionRadius + class'xPawn'.default.CollisionRadius);
		VSize(SpawnLoc - StartLocation) < MaxSpawnRange; 
		SpawnLoc += AddPerCycle)
			Clouds[Clouds.Length] = Spawn(class'M763GasCollider', self, , SpawnLoc);
}

function LostChild(Actor A)
{
	local int i;
	for (i=0; i<Clouds.Length && Clouds[i] != A; i++);
	
	if (i < Clouds.Length)
		Clouds.Remove(i, 1);
	if (Clouds.Length == 0 && Owner == None)
		Destroy();
}

function ServeCustomers()
{
	local int i,j,k;
	local array<Actor> Served;
	local Inv_Slowdown Slow;
		
	for(i=0;i<Clouds.length;i++)
		for(j=0;j<Clouds[i].Touching.length;j++)
		{
			if (Clouds[i].Touching[j] == None || Pawn(Clouds[i].Touching[j]) == None)
				continue;
			for(k=0;k<Served.length;k++)
				if (Served[k] == Clouds[i].Touching[j])
					break;
			if (k >= Served.length)	
			{
				class'BallisticDamageType'.static.GenericHurt(Clouds[i].Touching[j], Damage, Instigator, Clouds[i].Touching[j].Location, vect(0,0,0), DamageType);
				if (Pawn(Clouds[i].Touching[j]) != None)
				{
					Slow = Inv_Slowdown(Pawn(Clouds[i].Touching[j]).FindInventoryType(class'Inv_Slowdown'));
	
					if (Slow == None)
					{
						Pawn(Clouds[i].Touching[j]).CreateInventory("BallisticProV55.Inv_Slowdown");
						Slow = Inv_Slowdown(Pawn(Clouds[i].Touching[j]).FindInventoryType(class'Inv_Slowdown'));
						Slow.AddSlow(0.8, 0.4);
					}
	
					else Slow.AddSlow(0.8, 0.2);
				}
				Served[Served.length] = Clouds[i].Touching[j];	
			}
		}
}

function Timer()
{
	ServeCustomers();
}

simulated function Destroyed()
{
	local int i;
	for(i=0;i<Clouds.length;i++)
		if (Clouds[i] != None)
			Clouds[i].Destroy();
	super.Destroyed();
}

defaultproperties
{
     Damage=9
     DamageType=Class'BallisticProV55.DTM763Gas'
     bHidden=True
}
