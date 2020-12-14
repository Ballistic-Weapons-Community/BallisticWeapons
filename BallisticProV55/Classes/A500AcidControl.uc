//=============================================================================
// A500AcidControl.
//
// This is spawned when an A500 acid blob explodes. It damages players, and plays
// sounds and effects...
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class A500AcidControl extends Actor;

var float BaseSpreadRadius;

struct AcidPoolStruct
{
	var vector PoolLoc;
	var byte bStuck;
};

struct HitPawnInfo
{
	var Pawn HitPawn;
	var float HitTime;
};

var int			Ident;
var() float		DamageRadius;			// Radius in which to corrode players
var   AcidPoolStruct	AcidSpots[10];			// Info sent to client to tell it where to spawn pools
var array<HitPawnInfo>	HitPawnData;

replication
{
	reliable if (Role == ROLE_Authority)
		AcidSpots;
}

function Reset()
{
	Destroy();
}

//Prevents multiple hits when goo patches overlap
function TryDamage (Pawn Victim, float Interval, float Damage, class<DamageType> DamageType)
{	
	local int Index;

	Index = FindIndex(Victim);

	if (HitPawnData[Index].HitTime + Interval < Level.TimeSeconds || HitPawnData[Index].HitTime == 0 )
	{
		HitPawnData[Index].HitTime = Level.TimeSeconds;
		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Victim.Location, vect(0,0,0), DamageType);
	}
}

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

simulated function Initialize(vector HitNormal, int Load)
{
    local int i, Count, SpreadRadius;
	local vector Start, End, HitLoc, HitNorm;
	local Actor T;
	local A500GroundAcid GF;
	local Projector P;

	if (level.NetMode == NM_Client)
		return;

	SpreadRadius = BaseSpreadRadius * (Load ** 0.4f);
	Count = 2 * (Load ** 1.35f);

	// Spawn all the pools to set up an area of destruction
	Start = Location+(HitNormal*8);

	for(i = 0; i < Count; i++)
	{
		if(i > 0)
		{
			End = VRand();
			End.Z = Abs(End.Z);
			End = Start + End * SpreadRadius;
			T = Trace(HitLoc, HitNorm, End, Start,, vect(6,6,6));
			if (T==None) 
				HitLoc=End;

			GF = Spawn(class'A500GroundAcid',self,,HitLoc, rotator(HitNorm));
		}
		else
			GF = Spawn(class'A500GroundAcid',self,,Location, rot(0,0,0));

		if (GF!=None)
		{
			GF.Instigator = Instigator;
			if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
				GF.InstigatorController = Instigator.Controller;
				GF.AcidControl = self;
				GF.Timer();

			if(level.NetMode != NM_DedicatedServer && GF.bStuck && T != None && T.bWorldGeometry)
			{
				P = Spawn(Class'AD_A500BlastSplat', Self,, HitLoc, Rotator(-HitNorm));
				if (BallisticDecal(P) != None && BallisticDecal(P).bWaitForInit)
					BallisticDecal(P).InitDecal();
			}
		}
	}
}

defaultproperties
{
     BaseSpreadRadius=128.000000
     DamageRadius=384.000000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=54
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     bHidden=True
     bDynamicLight=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=10.000000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=192.000000
}
