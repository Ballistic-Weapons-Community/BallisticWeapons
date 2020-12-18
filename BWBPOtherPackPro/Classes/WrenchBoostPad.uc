class WrenchBoostPad extends WrenchDeployable;

var WrenchBoostTrigger 		BT;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	BT=Spawn(class'WrenchBoostTrigger', self,,Location + vect(0,0,16));
	BT.Team = Team;
}

simulated function Destroyed()
{
	if (BT != None)
		BT.Destroy();

	Super.Destroyed();
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (BT != None)
			BT.Destroy();

		if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
		{
			if (!bWarpOut)
				Spawn( EffectWhenDestroyed, Owner,, Location );
			else
			{
				Spawn(class'WrenchWarpEndEmitter', Owner,, Location);
				PlaySound(Sound'BWBPOtherPackSound.Wrench.Teleport', ,1);
			}
		}
		
		Sleep(0.5);
		Destroy();
}

defaultproperties
{
	Health=100
	TeamSkinIndex=2
	TeamSkins(0)=Shader'BWBPOtherPackTex.Wrench.BoostShaderRed'
	TeamSkins(1)=Shader'BWBPOtherPackTex.Wrench.BoostShaderBlue'
	StaticMesh=StaticMesh'BWBPOtherPackStatic.Wrench.BoostPad'
	DrawScale3D=(X=0.750000,Y=0.750000,Z=0.500000)
	CollisionHeight=4.000000
}
