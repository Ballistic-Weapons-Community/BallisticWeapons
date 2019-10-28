class WrenchTeleporter extends WrenchDeployable;

#exec OBJ LOAD File=X_SG_Special.usx

var WrenchTeleporterTrigger		WTN;

function PostBeginPlay()
{
	local Teleporter T;
	local GameObjective GO;
	
	Super.PostBeginPlay();
	
	foreach RadiusActors(class'Teleporter', T, 256)
	{
		Destroy();
		return;
	}
	
	foreach RadiusActors(class'GameObjective', GO, 512)
	{
		Destroy();
		return;
	}

	WTN=Spawn(class'WrenchTeleporterTrigger', self,,Location + vect(0,0,64), Rotation + rot(0,32768,0));
	WTN.Team = Team;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if (Level.NetMode != NM_DedicatedServer && Level.GetLocalPlayerController().PlayerReplicationInfo.Team != None && Level.GetLocalPlayerController().PlayerReplicationInfo.Team.TeamIndex != Team)
		Skins[0] = FinalBlend'XEffectMat.InvisOverlayFB';
}

function Initialize(WrenchWarpDevice Master)
{
	local byte myIndex;
	
	if (Master == None || (Master.Teleporters[0] != None && Master.Teleporters[1] != None) )
	{
		GoToState('Destroying');
		return;
	}
	
	if (Master.Teleporters[0] == None)
		myIndex = 0;
	else myIndex = 1;
	
	Master.Teleporters[myIndex] = Self;
	
	if (Master.Teleporters[myIndex^1] != None)
	{
		Master.Teleporters[myIndex^1].WTN.OtherWarp = WTN;
		WTN.OtherWarp = Master.Teleporters[myIndex^1].WTN;
	}
}

simulated function Destroyed()
{
	if (WTN != None)
		WTN.Destroy();

	Super.Destroyed();
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (WTN != None)
			WTN.Destroy();

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
     TeamSkinIndex=0
     TeamSkins(0)=Texture'BWBPOtherPackTex.Wrench.Teleport_RED'
     TeamSkins(1)=Texture'BWBPOtherPackTex.Wrench.Teleport_BLU'
     Health=125
     StaticMesh=StaticMesh'X_SG_Special.Mech.sg_Mech_smallteleport'
     DrawScale=0.500000
     PrePivot=(Z=5.000000)
     CollisionHeight=1.000000
}
