class WrenchAmmoCrate extends WrenchDeployable;

var WrenchDispenserTrigger 		DT;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	DT=Spawn(class'WrenchDispenserTrigger', self,,Location + vect(0,0,16));
}

simulated function Destroyed()
{
	if (DT != None)
		DT.Destroy();

	Super.Destroyed();
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (DT != None)
			DT.Destroy();

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
	StaticMesh=StaticMesh'BWBP_OP_Static.Wrench.AmmoCrate'
    CollisionHeight=32.000000
}
