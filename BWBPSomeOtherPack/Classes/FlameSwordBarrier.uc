class FlameSwordBarrier extends BallisticShield;

var class<Actor> EffectWhenDestroyed;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	PlaySound(Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Ignite', ,1);
	
	if (Level.NetMode != NM_DedicatedServer)
		Spawn(EffectWhenDestroyed, Owner,, Location );
}

function Timer()
{
	GoToState('Destroying');
}

auto state Working
{
	function BeginState()
	{
		SetTimer(3, false);
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
	 bUnlit=True
     bNetInitialRotation=True
     NetUpdateFrequency=10.000000
     DrawScale3D=(X=4.50000,Y=4.5000,Z=4.50000)
     bShouldBaseAtStartup=True
     CollisionRadius=48.000000
     CollisionHeight=128.000000
     bFixedRotationDir=True
}
