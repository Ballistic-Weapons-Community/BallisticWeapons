class FlameSwordBarrier extends BallisticShield;

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
		PlaySound(Sound'BallisticSounds2.RX22A.RX22A-FlyBy', ,1);
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
			PlaySound(Sound'BallisticSounds2.RX22A.RX22A-FlyBy', ,1);
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
     EffectWhenDestroyed=Class'BallisticProV55.IE_FireExplosion'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.FlameSword.FlameSword_Shield'
     bStasis=False
     bNetInitialRotation=True
     NetUpdateFrequency=10.000000
     DrawScale3D=(X=1.500000,Y=1.500000,Z=1.500000)
     bShouldBaseAtStartup=True
     CollisionRadius=48.000000
     CollisionHeight=90.000000
     bFixedRotationDir=True
}
