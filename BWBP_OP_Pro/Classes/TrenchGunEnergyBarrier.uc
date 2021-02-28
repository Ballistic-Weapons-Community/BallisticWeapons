class TrenchgunEnergyBarrier extends BallisticShield;

var class<Actor> EffectWhenDestroyed;

function Timer()
{
	GoToState('Destroying');
}

auto state Working
{
	function BeginState()
	{
		SetTimer(5, false);
	}
	
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,	Vector momentum, class<DamageType> damageType)
	{
	}

	function Bump( actor Other )
	{
	}

	function bool EncroachingOn(Actor Other)
	{
		if (Decoration(Other) != None)
			GoToState('Destroying');
		return false;
	}
	
	function Timer()
	{
		GoToState('Destroying');
	}
}

simulated function TornOff()
{
	if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
	{
		Spawn( EffectWhenDestroyed, Owner,, Location );
		//PlaySound(Sound'BWBP_OP_Sounds.Wrench.Teleport', ,1);
	}
		
	Destroy();
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
		{
			Spawn( EffectWhenDestroyed, Owner,, Location );
			PlaySound(Sound'BWBP_OP_Sounds.Wrench.Teleport', ,1);
		}
		
		Sleep(0.5);
		Destroy();
}

function bool BlocksShotAt(Actor Other)
{
	return true;
}

defaultproperties
{
     EffectWhenDestroyed=Class'BWBP_OP_Pro.WrenchWarpEndEmitter'
     StaticMesh=StaticMesh'BWBP_OP_Static.Wrench.EnergyWall'
     bStasis=False
     bNetInitialRotation=True
     NetUpdateFrequency=10.000000
     DrawScale3D=(X=3.000000,Y=3.000000,Z=3.000000)
     bShouldBaseAtStartup=True
     CollisionRadius=48.000000
     CollisionHeight=90.000000
     bFixedRotationDir=True
}
