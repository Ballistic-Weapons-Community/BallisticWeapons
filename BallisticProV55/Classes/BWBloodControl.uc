//=============================================================================
// BWBloodControl.
//
// A BloodControl is attached to a corpse and will control several horrific,
// gore related effects. It will spawn drag marks for sliding corpses, impacts
// for corpses hitting surfaces, high impacts for big impacts and pools for
// stationary corpses. When in water, only the blood emitter will spawn.
//
// BloodSets hold all the settings for each different type of blood.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BWBloodControl extends Actor
	config(BallisticProV55);

var   xPawn				Corpse;				// The stiff itself. (or perhaps limp in this case)
var   vector			LastDragLocation;	// Place where last drag was spawned
var   float				LastImpactTime;		// Time of last impact
var   BallisticDecal	BloodPool;			// The expanding pool of blood
var   Emitter			WaterBlood;			// Emitter used for water blood
var() float				MinDragDistance;	// Minimum distance the stiff must move to spawn a drag decal
var() float				LowImpactVelocity;	// Impact Velocity, above which, a low impact decal will be spawned
var() float				HighImpactVelocity;	// Impact Velocity, above which, a high impact decal will be spawned instead
var() float				MaxPoolVelocity;	// Velocity, below which, pools may form. Above this, pools stop and dont spawn
var() class<BallisticBloodSet> BloodSet;	// The blood set that will be used for this corpse.
var   class<DamageType>	DamageType;			// Damagetype that killed the pawn
var   bool				bInitialized;		// Pools can now spawned. Used to prevent pools spawning right at the beginning

var() globalconfig bool		bUseBloodDrags;				// Config setting to toggle blood drag marks
var() globalconfig bool		bUseBloodImpacts;			// Toggles body impact blood
var() globalconfig bool		bUseBloodPools;				// Toggles blood pools unded dead bodies

replication
{
	reliable if (Role == ROLE_Authority)
		DamageType;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (class'GameInfo'.static.UseLowGore())
		Destroy();
	else
		SetTimer(0.05, false);
}
simulated function FindCorpse()
{
	local xPawn P;

	foreach DynamicActors(class'xPawn', P)
	{
		if (P.Health < 1 && P.Tag != 'BloodyCorpse')
		{
			P.Tag = 'BloodyCorpse';
			Corpse = P;
		}
	}

}
simulated function Initialize(class<DamageType> DT)
{
	DamageType = DT;

	if(!DT.default.bCausesBlood)
		Destroy();
}
simulated function class<BallisticBloodSet> GetBloodSet(Pawn Victim)
{
	return class'BWBloodSetHunter'.static.GetBloodSetFor(Victim);

/*	if (xPawn(Victim)!=None && class<xAlienGibGroup>(xPawn(Victim).GibGroupClass) != None)
		return class'BloodSetGreen';
	else if (xPawn(Victim)!=None && class<xBotGibGroup>(xPawn(Victim).GibGroupClass) != None)
		return class'BloodSetPurple';
	else
		return class'BloodSetDefault';
*/
}
simulated function Timer()
{
	if (Owner != None && xPawn(Owner) != None)
		Corpse = xPawn(Owner);
	else
		FindCorpse();
	BloodSet = GetBloodSet(Corpse);
//	BloodSet = class'BM_BloodBullet'.static.GetBloodSet(Corpse);
//	SetTimer(0.05, false);
	if (level.DetailMode < DM_SuperHigh)
		MinDragDistance *= 1.5;
   	bInitialized=true;
}
simulated function Destroyed()
{
	if (WaterBlood != None)
		WaterBlood.Kill();
	if (BloodPool != None)
		BloodPool.StopExpanding ();
	super.Destroyed();
}

// Spawns drag marks, checks for impacts and spawns impact splatters and checks on pools and water clouds
simulated function Tick(float DT)
{
	local Actor T;
	local Vector HitLoc, HitNorm;
	local Rotator R;

	if (!bInitialized)
		return;
	else if (Corpse==None || Corpse.bDeRes)
	{
		Destroy();
		return;
	}
	// Blood clouds in water
	if (bUseBloodPools && Corpse.PhysicsVolume.bWaterVolume)
	{
		if (BloodPool != None)	{	BloodPool.StopExpanding ();	BloodPool = None;	}
		if (WaterBlood == None)
		{
			WaterBlood = Spawn(BloodSet.default.WaterBloodClass,Corpse,, Corpse.Location, Corpse.Rotation);
			WaterBlood.SetBase(Corpse);
		}
		return;
	}
	if (WaterBlood != None)
	{
		WaterBlood.Kill();
		WaterBlood = None;
	}
	// Spawn drag marks
	if (bUseBloodDrags && VSize(Corpse.Location - LastDragLocation) > MinDragDistance && (!FastTrace(Corpse.Location - vect(0,0,30), Corpse.Location)))
	{
		if (BloodPool != None)
		{
			BloodPool.StopExpanding ();
			BloodPool = None;
		}
		LastDragLocation = Corpse.Location;
		if (level.DetailMode > DM_Low)
		{
			R = Rotator(Corpse.Velocity);
			R.Pitch = -16384;
			Spawn(BloodSet.default.DragDecal,Corpse,,Corpse.Location, R);
		}
	}
	// Spawn Impact Marks
	if (bUseBloodImpacts && level.TimeSeconds - LastImpactTime > 1.0 && VSize(Corpse.Velocity) > LowImpactVelocity)
	{
		T = Trace(HitLoc, HitNorm, Corpse.Location + Corpse.Velocity * DT, Corpse.Location, false);
		if (T != None && T.bWorldGeometry)
		{
			LastImpactTime = level.TimeSeconds;
			if (VSize(Corpse.Velocity) > HighImpactVelocity)
				Spawn(BloodSet.default.HighImpactDecal ,Corpse, , HitLoc, Rotator(-HitNorm));
			else
				Spawn(BloodSet.default.LowImpactDecal,Corpse, , HitLoc, Rotator(-HitNorm));
		}
	}
	// Spawn blood pools
	else if (bUseBloodPools && BloodPool == None && VSize(Corpse.Velocity) < MaxPoolVelocity && bInitialized)
		BloodPool = Spawn(BloodSet.default.BloodPool,,, Corpse.Location, Rotator(vect(0,0,-1)));
}

defaultproperties
{
     MinDragDistance=50.000000
     LowImpactVelocity=500.000000
     HighImpactVelocity=1000.000000
     MaxPoolVelocity=50.000000
     bUseBloodDrags=True
     bUseBloodImpacts=True
     bUseBloodPools=True
     bHidden=True
     bNetTemporary=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
}
