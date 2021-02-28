class WrenchShieldGeneratorB extends WrenchDeployable;

var WrenchShield 	ShieldActor;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	ShieldActor=Spawn(class'WrenchShield', self,,Location + vect(0,0,56));
}

function Timer()
{
	GoToState('Destroying');
}

simulated function Destroyed()
{
	if (ShieldActor != None)
		ShieldActor.Destroy();

	Super.Destroyed();
}

auto state Working
{	
	function BeginState()
	{
		SetTimer(12, false);
	}
	
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,	Vector momentum, class<DamageType> damageType)
	{
		if (!DamageType.default.bLocationalHit)
			return;
		Super.TakeDamage(Damage,instigatedBy,hitlocation, momentum, damageType);
	}
	
		
	function Timer()
	{
		GoToState('Destroying');
	}
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (ShieldActor != None)
			ShieldActor.Destroy();

		if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
		{
			if (!bWarpOut)
				Spawn( EffectWhenDestroyed, Owner,, Location );
			else
			{
				Spawn(class'WrenchWarpEndEmitter', Owner,, Location);
				PlaySound(Sound'BWBP_OP_Sounds.Wrench.Teleport', ,1);
			}
		}
		
		Sleep(0.5);
		Destroy();
}

defaultproperties
{
     TeamSkinIndex=0
     TeamSkins(0)=Texture'DespTech.T4-2'
     TeamSkins(1)=Texture'BWBP_OP_Tex.Wrench.ShieldGenerator_BLU'
     StaticMesh=StaticMesh'BWBP_OP_Static.Wrench.ShieldGenCore'
     DrawScale3D=(X=1.500000,Y=1.500000)
     CollisionRadius=48.000000
     CollisionHeight=32.000000
     bUseCylinderCollision=True
}
