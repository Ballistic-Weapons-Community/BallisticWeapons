//=============================================================================
// T10Cloud.
//
// A cloud of gas from the T10 grenade. The controller wil damage the actors this is touching
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M763GasCollider extends Actor
	placeable;

var   AvoidMarker		Fear;			// Da phear spauwt...

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (level.NetMode != NM_Client)
	{
		Fear = Spawn(class'BallisticAvoidMarker');
		Fear.SetCollisionSize(200, 200);
		if (Instigator != None)
		{
			BallisticAvoidMarker(Fear).OwnerController = Instigator.Controller;
			if (TeamGame(Level.Game) != None && TeamGame(Level.Game).FriendlyFireScale <= 0
				&& Instigator.PlayerReplicationInfo != None && Instigator.PlayerReplicationInfo.Team != None)
				Fear.TeamNum = Instigator.PlayerReplicationInfo.Team.TeamIndex;
		}
	    Fear.StartleBots();
	}
}

function Reset()
{
	Destroy();
}

function Destroyed()
{
	if (Fear!=None)
		Fear.Destroy();
	super.Destroyed();
}

function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Destroy();
}

defaultproperties
{
     bHidden=True
     LifeSpan=6.000000
     CollisionRadius=150.000000
     CollisionHeight=150.000000
     bCollideActors=True
     bUseCylinderCollision=True
}
