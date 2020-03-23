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

var	  int 							DmgScalar;
var   Pawn 							CollidingPawn;
var   int 							VictimIterator, Subtract;
var   Vector 						VertDisplacement;
var   array<Pawn> 					PawnList;

replication
{
	reliable if (Role == ROLE_Authority)
		PawnList;
}

simulated function PostNetBeginPlay()
{
	if (Role < ROLE_Authority)
		Initialize();
}

simulated function Initialize()
{
	local int i, ShortestDistIndex;
	local Pawn PVictim;
	local bool FoundInstigator;
	local float ShortestDistance;

	//Check for nearby pawns
	ForEach CollidingActors(class'Pawn', PVictim, ConductRadius)
	{
		if (i>MaxConductors)	//Any extra pawns beyond this causes problems? Needs looking into
			return;		
		
		if (PVictim == Instigator)
			FoundInstigator = True;
		
		//Gather all nearby pawns. If "valid", will add to list of pawns to affect
		else if (ValidTarget(PVictim))
		{
			PawnList[i] = PVictim;
			i++;
		}
	}
	//If instigator in ConductRadius, find the shortest distance between all pawns and instigator - insert instigator into array between pawn(s) with least distance
	
	ShortestDistance = ConductRadius;
	if (FoundInstigator)
	{
		for(i=0; i<PawnList.Length; i++)
		{
			if(VSize(Instigator.Location - PawnList[i].Location) < ShortestDistance)
			{
				ShortestDistance = VSize(Instigator.Location - PawnList[i].Location);
				ShortestDistIndex = i;
			}
		}
		
		PawnList.Insert(ShortestDistIndex, 1);
		PawnList[ShortestDistIndex] = Instigator;
	}
	
	//Starts electrocuting pawns
	CycleElectrocutionWithDelay();
}

simulated function bool ValidTarget(Pawn Other)
{
	local byte Team, InTeam;
	Team = Instigator.Controller.GetTeamNum();
	InTeam = Other.Controller.GetTeamNum();
	
	//true check
	
	/*if(Other != None && Other.bProjTarget && Other.Controller != None && Level.TimeSeconds - Other.SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime && (InTeam == 255 || InTeam != Team))
		return true;*/
	
	//test check - works on uncontrolled pawns
	
	if(Other != None && Other.bProjTarget && Level.TimeSeconds - Other.SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime && (InTeam == 255 || InTeam != Team))
		return true;
	
	return false;
}

simulated function CycleElectrocutionWithDelay()
{
	if (PawnList.Length == 0 || VictimIterator >= PawnList.Length)
		Destroy();
	
	SetTimer(ConductDelay, false);
}

simulated function Timer()
{
	local BCTraceEmitter Tracer;
	local TraceEmitter_LightningConduct MyTracer;
	local int NewDamage;
	local Vector ConnectionLine;
		
	ConnectionLine = PawnList[VictimIterator].Location - PawnList[VictimIterator - 1].Location;
	
	Tracer = Spawn(TracerClass, self, , PawnList[VictimIterator - 1].Location + VertDisplacement, Rotator(ConnectionLine));
	if (Tracer != None)
	{
		MyTracer = TraceEmitter_LightningConduct(Tracer);
		MyTracer.Initialize(VSize(ConnectionLine));
	}
	
	if (PawnList[VictimIterator-Subtract] == CollidingPawn)
	{
		Subtract = 0;
	}
	
	if (PawnList[VictimIterator-Subtract] != None)
	{
		NewDamage = FMax(1.0, Damage/VictimIterator);
		class'BallisticDamageType'.static.GenericHurt(PawnList[VictimIterator-Subtract], NewDamage, Instigator, PawnList[VictimIterator-Subtract].Location, vect(0,0,0), CDamageType);
	}

	VictimIterator++;
	CycleElectrocutionWithDelay();
}

defaultproperties
{
	 VictimIterator=1
	 Subtract=1
	 ConductDelay=0.060000
	 VertDisplacement=(Z=20.000000)
	 TracerClass=Class'BallisticJiffyPack.TraceEmitter_LightningConduct'
	 bHidden=True
	 CDamageType=Class'BallisticJiffyPack.DT_LightningConduct'
	 ConductRadius=1024.000000
	 MaxConductors=100
}
