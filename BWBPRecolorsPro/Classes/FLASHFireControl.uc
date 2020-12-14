//=============================================================================
// AT40 STREAK fire control
//
// Handles STREAK fires. Fixed multihits, control works T10 style.
//
// by Azarael based on code by DarkCarnivour
//=============================================================================
class FLASHFireControl extends Actor;

var() float								DamageRadius;			// Radius in which to immolate players
var   Vector							GroundFireSpots[25];	// Vectors sent to client to tell it where to spawn fires
var() class<BCImpactManager>			ImpactManager;	// Impact manager to spawn on final hit
var array<FLASHGroundFire>				Fires;
var() int								Damage;
var() class<DamageType>					DamageType;
var() Controller						InstigatorController;

var int UniqueID;

const BURNINTERVAL=0.3f;

replication
{
	unreliable if (Role == ROLE_Authority)
		GroundFireSpots;
}

function Reset()
{
	Destroy();
}

simulated function PostNetBeginPlay()
{
	if (Role < ROLE_Authority)
		Initialize();
	else 
		SetTimer(BURNINTERVAL, true);
}

simulated function Initialize()
{
    local int i;
	local vector Start, End, HitLoc, HitNorm;
	local Actor T;
	local Actor A;
	local FLASHGroundFire GF;
	
	if (Instigator != None)
		InstigatorController = Instigator.Controller;

	// Spawn effects, sounds, etc
/*    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(Location, vect(0,0,1), 0, Level.GetLocalPlayerController());
		else
			ImpactManager.static.StartSpawn(Location, vect(0,0,1), 0, Instigator);
	}*/
	// Immolate nearby players
	foreach VisibleCollidingActors( class 'Actor', A, DamageRadius+100, Location )
	{
		if (xPawn(A)!=None)
		{
			IgniteActor(A);
		}
		else if (Role == ROLE_Authority && A.bCanBeDamaged)
		{
			class'BallisticDamageType'.static.Hurt(A, (1.0-(VSize(A.Location - Location)/DamageRadius))*20.0, Instigator, A.Location, Normal(A.Location - Location)*500, class'DT_M202Immolation');
		}

	}
	if (level.NetMode == NM_Client)
		return;

	// Spawn all the fires to set up an area of destruction
	Start = Location+vect(0,0,8);
	for(i=0;i<20;i++)
	{
		End = Start + VRand()*DamageRadius*0.7;
		T = Trace(HitLoc, HitNorm, End, Start,, vect(6,6,6));
		if (T==None) HitLoc=End;
		GF = Spawn(class'FLASHGroundFire',self,,HitLoc, rot(0,0,0));
		if (GF!=None)
		{
			GF.Velocity = HitLoc - Location;
			GF.Instigator = Instigator;
		    if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
				GF.InstigatorController = Instigator.Controller;
			GF.FireControl = self;
			Fires[Fires.Length] = GF;
			// Tell client where to spawn them
			GroundFireSpots[i] = HitLoc;
		}
	}
}

simulated function PostNetReceive()
{
	local int i;
	local FLASHGroundFire F;
	if (level.NetMode != NM_Client)
		return;
	for (i=0;i<ArrayCount(GroundFireSpots);i++)
	{
		if (GroundFireSpots[i] != vect(0,0,0))
		{
			F = Spawn(class'FLASHGroundFire',self,,GroundFireSpots[i], rot(0,0,0));
			if (F != None)
			{
				F.Velocity = GroundFireSpots[i] - Location;
				GroundFireSpots[i] = vect(0,0,0);
				Fires[Fires.Length] = F;
			}
		}
	}
}

simulated function IgniteActor(Actor A)
{
	local FLASHActorBurner PF;

	PF = Spawn(class'FLASHActorBurner',self, ,A.Location);
	PF.Instigator = Instigator;

    if ( Role == ROLE_Authority && Instigator != None && Instigator.Controller != None )
		PF.InstigatorController = Instigator.Controller;
	PF.Initialize(A);
}

//Only the control of the first found fire in the Actor's touching array will be permitted to hurt.
function Timer()
{
	local int i,j,k,m;
	local array<Actor> Served;
	local Actor Vic;
	local bool bDamage;
	
	for(i=0;i<Fires.length;i++)
		for(j=0;j<Fires[i].Touching.length;j++)
		{
			if (Fires[i].Touching[j] == None || Pawn(Fires[i].Touching[j]) == None)
				continue;
				
			for(k=0;k<Served.length;k++)
				if (Served[k] == Fires[i].Touching[j])
					break;
					
			if (k >= Served.length)	
			{
				bDamage = True;
				Vic = Fires[i].Touching[j];
				for(m=0; m<Vic.Touching.Length;m++)
				{
					if (FLASHGroundFire(Vic.Touching[m]) == None)
						continue;
					if (FLASHGroundFire(Vic.Touching[m]).FireControl != self)
					{
						bDamage=False;
						Served[Served.length] = Fires[i].Touching[j];
					}
					
					break;
				}
				
				if (bDamage)
				{
					if ( Instigator == None || Instigator.Controller == None )
						Fires[i].Touching[j].SetDelayedDamageInstigatorController( InstigatorController );
						
					class'BallisticDamageType'.static.GenericHurt(Fires[i].Touching[j], Damage, Instigator, Fires[i].Touching[j].Location, vect(0,0,0), DamageType);
					Served[Served.length] = Fires[i].Touching[j];	
				}
			}
		}
}

simulated function Destroyed()
{
	local int i;
	for(i=0;i<Fires.length;i++)
		if (Fires[i] != None)
			Fires[i].Kill();
	super.Destroyed();
}

defaultproperties
{
     DamageRadius=256.000000
     ImpactManager=Class'BWBPRecolorsPro.IM_FlareExplode'
     Damage=25
     DamageType=Class'BWBPRecolorsPro.DT_M202Burned'
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
     SoundRadius=192.000000
     bNetNotify=True
}
