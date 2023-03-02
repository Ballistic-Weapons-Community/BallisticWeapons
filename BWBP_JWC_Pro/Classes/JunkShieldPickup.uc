//=============================================================================
// JunkShieldPickup.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkShieldPickup extends Pickup;

var   bool					bWasPickedUp;
var() rotator				SpawnPivot;			// Rotational orientation of pickups (to make it look right lying on the ground)
var() vector				SpawnOffset;		// Offset of pickup (use to move closer/further from ground, forward/back and left/right)
var() int					Health;				// FIXME
var   Actor					FadeOutEffect;
var   rotator				LandedRot;

replication
{
	unreliable if (Role == ROLE_Authority && bNetDirty)
		LandedRot;
}

delegate OnItemRespawn (Pickup Pickup);

auto state Pickup
{
	function bool ValidTouch( actor Other )
	{
		if (!super.ValidTouch(Other))
			return false;
		if (Pawn(Other) != None && Pawn(Other).FindInventoryType(class'JunkShield') != None)
			return false;
		return true;
	}
}
state FallingPickup
{
	function bool ValidTouch( actor Other )
	{
		if (!super.ValidTouch(Other))
			return false;
		if (Pawn(Other) != None && Pawn(Other).FindInventoryType(class'JunkShield') != None)
			return false;
		return true;
	}
}

simulated function PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (LandedRot != rot(0,0,0))	{
		SetRotation(LandedRot);
	}
}

simulated event ClientTrigger()
{
	bHidden=true;
	if (EffectIsRelevant(Location, false))
		FadeOutEffect = Spawn(class'BCPickupFadeEffect',self,,Location,Rotation);
}

State FadeOut
{
	function bool ValidTouch( actor Other )
	{
		if (!super.ValidTouch(Other))
			return false;
		if (Pawn(Other) != None && Pawn(Other).FindInventoryType(class'JunkShield') != None)
			return false;
		return true;
	}
	function BeginState()
	{
		SetPhysics(PHYS_None);
		LifeSpan = 4.0;
		bClientTrigger = !bClientTrigger;
		if (level.NetMode != NM_DedicatedServer)
			ClientTrigger();
	}
}

function inventory SpawnCopy( pawn Other )
{
	local Inventory Copy;

	bWasPickedUp=true;

    Copy = Other.FindInventoryType(InventoryType);
    if (Copy == None)
    {
		Copy = spawn(InventoryType,Other,,,rot(0,0,0));
		Copy.GiveTo( Other, self );
	}
	return Copy;
}

event Destroyed()
{
	if (FadeOutEffect != None)
		FadeOutEffect.Destroy();
	RemoveFromNavigation();
	super.Destroyed();
}

function InitDroppedPickupFor(Inventory Inv)
{
	SetPhysics(PHYS_Falling);
	GotoState('FallingPickup');
//	Inventory = Inv;
	bAlwaysRelevant = false;
	bOnlyReplicateHidden = false;
	bUpdateSimulatedPosition = true;
    bDropped = true;
    LifeSpan = 16;
	bIgnoreEncroachers = false; // handles case of dropping stuff on lifts etc
	NetUpdateFrequency = 8;
	if (JunkShield(Inv) != None)
		Health = JunkShield(Inv).Health;
}
function RespawnEffect()
{
	if (!bDropped && bWasPickedUp)
		OnItemRespawn(self);
	super.RespawnEffect();
}

event Landed(Vector HitNormal)
{
	local Rotator R, Dir;
	local Vector X, Y, Z;

	Dir = Rotator(HitNormal)-rot(16384,0,0);

	R.Pitch = SpawnPivot.Pitch;
	R.Roll  = SpawnPivot.Roll;
	R.Yaw = Rotation.Yaw;
	GetAxes (R,X,Y,Z);
	SetRotation(OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir));

	LandedRot = Rotation;

    GotoState('Pickup','Begin');
}

function float BotDesireability( pawn Bot )
{
	local JunkShield JS;

	JS = JunkShield(Bot.FindInventoryType(class'JunkShield'));
	if ( JS != None )
	{
		if (JS.class == InventoryType)
		{
			if (Health > 0)
				return (1-JS.Health/Health)*MaxDesireability;
			else
				return (1-JS.Health/JS.default.Health)*MaxDesireability;
		}
		else if (class<JunkShield>(InventoryType) != None && JS.Rating < class<JunkShield>(InventoryType).default.Rating)
			return MaxDesireability*0.5;
		return -1;
	}
	return MaxDesireability;
}

defaultproperties
{
     MaxDesireability=0.750000
     InventoryType=Class'BWBP_JWC_Pro.JunkShield'
     bPredictRespawns=True
     RespawnTime=15.000000
     PickupMessage="You picked a Junk Shield"
     DrawType=DT_StaticMesh
     CullDistance=2000.000000
     bOrientOnSlope=False
     bNetInitialRotation=True
     Texture=Texture'Engine.S_Weapon'
     DrawScale=0.280000
     AmbientGlow=12
     TransientSoundVolume=1.000000
     TransientSoundRadius=64.000000
     CollisionRadius=28.000000
     CollisionHeight=6.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
