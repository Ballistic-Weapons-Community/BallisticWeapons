//=============================================================================
// SMATIceCloudControl.
//
// An invisible actor responsible for handling a system of SMAT ice gas clouds.
// the ice clouds freeze players
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATIceCloudControl extends Actor;

var   array<SMATIceCloud>	Clouds;
var() int					Damage;
var() class<DamageType>		DamageType;
var   vector				CloudSpawnLoc, OldCloudSpawnLoc;
var   bool					bNoMore;

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
	local int i,j,k;
	local array<Actor> Served;
	
	for(i=0;i<Clouds.length;i++)
		for(j=0;j<Clouds[i].Touching.length;j++)
		{
			if (Clouds[i].Touching[j] == None || Pawn(Clouds[i].Touching[j]) == None)
				continue;
			for(k=0;k<Served.length;k++)
				if (Served[k] == Clouds[i].Touching[j])
					break;
			if (k >= Served.length)	{
				class'BallisticDamageType'.static.GenericHurt(Clouds[i].Touching[j], Clouds[i].Density*Damage, Instigator, Clouds[i].Touching[j].Location, vect(0,0,0), DamageType);
				if (Pawn(Clouds[i].Touching[j]) != None)
					class'BCSprintControl'.static.AddSlowTo(Pawn(Clouds[i].Touching[j]), 0.7, 0.1);
				Served[Served.length] = Clouds[i].Touching[j];	}
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
simulated function CloudDie(SMATIceCloud C)
{
	local int i;

	for(i=0;i<Clouds.length;i++)
		if (Clouds[i] == C)	{
			Clouds.Remove(i,1);
			break;			}
}

simulated function SpawnCloud(vector V)
{
	local SMATIceCloud C;
	local Actor Underneath;
	local Vector dump, trash;

	Underneath = Trace (dump, trash, V - vect(0,0,1536), V, false);
	
	if (Mover(Underneath) != None)
		return;
		
	if (Owner != None)
		C = Spawn(class'SMATIceCloud',self,,V, Rotator(Owner.Velocity));
	else if (Clouds.length>0 && Clouds[Clouds.length-1] != None)
		C = Spawn(class'SMATIceCloud',self,,V, Rotator(V - Clouds[Clouds.length-1].Location));
	else if (Instigator != None)
		C = Spawn(class'SMATIceCloud',self,,V, Rotator(V - Instigator.Location));
	else
		C = Spawn(class'SMATIceCloud',self,,V);
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
     Damage=1
     DamageType=Class'BWBP_SKC_Pro.DTSMAT_Freeze'
     bHidden=True
     bAlwaysRelevant=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=12.000000
     bNetNotify=True
}
