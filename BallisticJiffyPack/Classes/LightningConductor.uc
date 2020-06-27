//=============================================================================
// Lightning Conduction Impact. Handles conduction between pawns and generating effects
//[6:30 PM] Jiffy: Damage scaling will either be proportional to the square or cube of the number of pawns affected prior
//[6:30 PM] Jiffy: Oh, and there'll be a max number of conducting pawns
//[6:30 PM] Azarael: >proportional to cube of number of pawns affected prior
//[6:30 PM] Azarael: >it scales up cubically with pawns affected
//[6:30 PM] Azarael: H O L Y S H I T
//=============================================================================
class LightningConductor extends Actor;

var   int 							Damage;
var	  int							MaxConductors;
var   float 						ConductRadius;
var   float							ConductDelay;
var() class<BCTraceEmitter> 		TracerClass;
var() class<BallisticDamageType>	CDamageType;
var   float							ChargePower;
var   float							SquareCoefficient;

var	  int 							DmgScalar;
var   int 							CurrentTargetIndex;
var   Vector 						VertDisplacement;
var   array<Pawn> 					ShockTargets;

var		int							HitCounter, OldHitCounter;
var		vector						EffectStart, EffectEnd;
var		Pawn						EffectSource, EffectDest;

var 	float						SelfDmgScalar;

replication
{
	reliable if (Role == ROLE_Authority)
		HitCounter, EffectStart, EffectEnd, EffectSource, EffectDest; 
}

//============================================================
// PostNetReceive
//
// Updates replicated shock effect variables
//============================================================
function ReplicateShock(vector start, vector end, Pawn src, Pawn dest)
{
	EffectStart = start;
	EffectEnd = end;
	
	EffectSource = src;
	EffectDest = dest;

	HitCounter++;

	NetUpdateTime = Level.TimeSeconds - 1;
}

//============================================================
// PostNetReceive
//
// Processes replicated shock effect variables on client
//============================================================
simulated function PostNetReceive()
{
	if (HitCounter != OldHitCounter)
	{
		OldHitCounter = HitCounter;
		ClientDrawShock(EffectStart, EffectEnd, EffectSource, EffectDest);
	}

	Super.PostNetReceive();
}

//============================================================
// ClientDrawShock
//
// Draws shock effect on network client
//============================================================
simulated function ClientDrawShock(vector start, vector end, Pawn src, Pawn dest)
{
	// if we have valid Pawn references, use them to accurize the effect
	if (src != None)
		start = src.Location;
	if (dest != None)
		end = dest.Location;

	DrawShock(start, end);
}

//============================================================
// Initialize (server only)
//
// Builds target list and begins propagation
//============================================================
function Initialize(Pawn InitialTarget)
{
	local int i, ShortestDistIndex;
	local Pawn PVictim;
	local bool FoundInstigator;
	local float ShortestDistance;

	ShockTargets.Insert(ShockTargets.Length, 1);
	ShockTargets[ShockTargets.Length - 1] = InitialTarget;

	//Scale up max conductors, conduct radius, etc. according to ChargePower. Now uses default values, easier to balance
	ConductRadius = default.ConductRadius * (1 + (SquareCoefficient*ChargePower*ChargePower));
	MaxConductors = default.MaxConductors * (1 + ChargePower);

	//Check for nearby pawns
	ForEach CollidingActors(class'Pawn', PVictim, ConductRadius)
	{		
		if (PVictim == Instigator)
		{
			FoundInstigator = True;
			continue;
		}

		// first shock target is not obtained from CollidingActors
		// so we need to explicitly check it's not this one
		if (PVictim == InitialTarget)
			continue;
		
		//Gather all nearby pawns. If "valid", will add to list of pawns to affect
		if (ValidTarget(Instigator, PVictim, Level))
		{
			ShockTargets.Insert(ShockTargets.Length, 1);
			ShockTargets[ShockTargets.Length - 1] = PVictim;

			if (ShockTargets.Length == MaxConductors)
				break;	
		}
	}

	//If instigator in ConductRadius, find the shortest distance between all pawns and instigator - insert instigator into array after pawn with least distance
	ShortestDistance = ConductRadius;

	if (FoundInstigator)
	{
		for(i = 0; i < ShockTargets.Length; i++)
		{
			if(VSize(Instigator.Location - ShockTargets[i].Location) < ShortestDistance)
			{
				ShortestDistance = VSize(Instigator.Location - ShockTargets[i].Location);
				ShortestDistIndex = i;
			}
		}
		
		ShockTargets.Insert(ShortestDistIndex + 1, 1);
		ShockTargets[ShortestDistIndex + 1] = Instigator;
	}

	if (ShockTargets.Length == 1) // no targets found, no work to do
		Destroy();
	else
		StartElectrocution();
}

//============================================================
// ValidTarget
//
// Returns true if target is valid 
// for electroshock propagation
//============================================================
static function bool ValidTarget(Pawn Instigator, Pawn Target, LevelInfo Level)
{
	local byte Team, InTeam;

	// target should never be none because this function is only ever called from CollidingActors
	if (Target == None || !Target.bProjTarget)
		return false;

	// uncontrolled pawn is neutral - valid target
	if (Target.Controller == None)
		return true;

	Team = Instigator.Controller.GetTeamNum();
	InTeam = Target.Controller.GetTeamNum();

	return (Level.TimeSeconds - Target.SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime && (InTeam == 255 || InTeam != Team));
}

//============================================================
// StartElectrocution
//
// Invokes rolling timer and performs first tick
//============================================================
function StartElectrocution()
{
	SetTimer(ConductDelay, true);
	Propagate();
}

//============================================================
// DrawShock
//
// Spawns shock effects
//============================================================
simulated function DrawShock(Vector start, Vector end)
{
	local TraceEmitter_LightningConduct LightningTracer;

	start += VertDisplacement;
	end += VertDisplacement;

	LightningTracer = TraceEmitter_LightningConduct(Spawn(TracerClass, self, , start, Rotator(end - start)));

	if (LightningTracer != None)
		LightningTracer.Initialize(VSize(end - start));
}

//============================================================
// Timer
//
// Propagates effect to next target at intervals
//============================================================
function Timer()
{
	Propagate();  
}

//============================================================
// Propagate
//
// Spreads effect to next target, damaging them
// Kills the Actor if this fails or if the target list
// is exhausted
//============================================================
function Propagate()
{
	local Pawn src, dest;

	src = ShockTargets[CurrentTargetIndex - 1];
	dest = ShockTargets[CurrentTargetIndex];

	// pawns may be destroyed for some reason beyond our control
	// additionally, if no LOS between source and dest pawn, the chain fails
	// next timer tick will destroy us
	if (src == None || dest == None || !FastTrace(src.Location, dest.Location))
	{
		Kill();
		return;
	}
		
	DrawShock(src.Location, dest.Location);
	ReplicateShock(src.Location, dest.Location, src, dest);
	
	if (dest == Instigator)
		class'BallisticDamageType'.static.GenericHurt(dest, Max(1, (SelfDmgScalar * (Damage)/(CurrentTargetIndex^(1/(1+2*ChargePower))))), Instigator, dest.Location, vect(0,0,0), CDamageType);
		
	else class'BallisticDamageType'.static.GenericHurt(dest, Max(1, (Damage)/(CurrentTargetIndex^(1/(1+2*ChargePower)))), Instigator, dest.Location, vect(0,0,0), CDamageType);

	++CurrentTargetIndex;

	if (CurrentTargetIndex == ShockTargets.Length)
		Kill();
}

//============================================================
// Kill
//
// Removes the Actor
//============================================================
function Kill()
{
	ShockTargets.Remove(0, ShockTargets.Length);
	SetTimer(0.0, false);
	Destroy();
}

defaultproperties
{
	bHidden=True
	bNetNotify=True
	bAlwaysRelevant=True
	RemoteRole=ROLE_SimulatedProxy
	CurrentTargetIndex=1
	ConductDelay=0.060000
	VertDisplacement=(Z=20.000000)
	TracerClass=Class'BallisticJiffyPack.TraceEmitter_LightningConduct'
	CDamageType=Class'BallisticJiffyPack.DT_LightningConduct'
	SquareCoefficient=0.083333
	ConductRadius=768.000000
	MaxConductors=3
	SelfDmgScalar=0.600000
}