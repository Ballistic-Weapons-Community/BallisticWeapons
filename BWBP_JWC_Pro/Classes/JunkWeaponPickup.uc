//=============================================================================
// JunkWeaponPickup.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkWeaponPickup extends Pickup;

var() class<JunkObject>		JunkClass;
var   bool					bWasPickedUp;
var   int					JunkAmmo;
var   rotator				LandedRot;
var   Actor					FadeOutEffect;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		JunkClass;
	unreliable if (Role == ROLE_Authority && bNetDirty)
		LandedRot;
}

delegate OnItemRespawn (Pickup Pickup);

function inventory SpawnCopy( pawn Other )
{
	local inventory Copy;
	local Weapon W;

	bWasPickedUp=true;

    W = Weapon(Other.FindInventoryType(InventoryType));
    if (W == None)
    {
		Copy = spawn(InventoryType,Other,,,rot(0,0,0));
		Copy.GiveTo( Other, self );
		W = Weapon(Copy);
	}
	if (W != None)
	{
		if (JunkWeapon(W) != None)
			JunkWeapon(W).GiveJunk(JunkClass, JunkAmmo);
		return W;
	}
	return Copy;
}

function SetJunkClass(class<JunkObject> JC)
{
	JunkClass = JC;
	if (Role == ROLE_Authority)
		InitJunk();
}
simulated function InitJunk ()
{
	if (JunkClass == None || JunkClass.static.InitializePickup(self))
		return;
	PrePivot=JunkClass.default.PickupPrePivot;
	SetStaticMesh(JunkClass.default.PickupMesh);
	SetDrawScale(JunkClass.default.PickupDrawScale);
	CullDistance = JunkClass.default.CullDistance;
//	JunkClass.static.InitializePickup(self);
	AddToNavigation();
}

event Destroyed()
{
	if (FadeOutEffect != None)
		FadeOutEffect.Destroy();
	RemoveFromNavigation();
	super.Destroyed();
}

simulated function PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (Role < ROLE_Authority)
		InitJunk ();
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
}
function StartSleeping()
{
	if (bDropped)
        Destroy();
    else
    {
		if (bWasPickedUp)
			RemoveFromNavigation();
	    GotoState('Sleeping');
	}
}

function RespawnEffect()
{
	if (!bDropped && bWasPickedUp)
		OnItemRespawn(self);
	super.RespawnEffect();
}

/* FIXME!!!
AIAssessJunk() = (TotalMeleeRating,TotalRangedRating,JuknObjectOfClass)
PickupRating()
*/

function float BotDesireability( pawn Bot )
{
	local JunkWeapon JW;
	local float desire;
	local JunkObject JO;

	desire = MaxDesireability;
	JW = JunkWeapon(Bot.FindInventoryType(InventoryType));
	if ( JW != None )
	{
		JO = JW.FindJunkOfClass(JunkClass);
		if (JO != None)
		{
			if (JO.Ammo >= JO.MaxAmmo)
				return -1;
			else
				return desire -= desire * (JO.Ammo / JO.MaxAmmo);
		}
		else if (JW.Junk != None)
			desire *= (JunkClass.default.MeleeRating+JunkClass.default.RangeRating) / (JW.Junk.MeleeRating+JW.Junk.RangeRating);
		else
			desire *= 2;
	}
	else if (Bot.Weapon == None)
		desire *= 2;
	return desire;
}

event Landed(Vector HitNormal)
{
	local Rotator R, Dir;
	local Vector X, Y, Z;

	Dir = Rotator(HitNormal)-rot(16384,0,0);

	R.Pitch = JunkClass.default.SpawnPivot.Pitch;
	R.Roll  = JunkClass.default.SpawnPivot.Roll;
	R.Yaw = Rotation.Yaw;
	GetAxes (R,X,Y,Z);
	SetRotation(OrthoRotation (X>>Dir, Y>>Dir, Z>>Dir));

	LandedRot = Rotation;

    GotoState('Pickup','Begin');
}

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	if (JunkClass != None && JunkClass.default.SelectSound.Sound != None)
		class'bUtil'.static.PlayFullSound(self,JunkClass.default.SelectSound);
}

static function string GetLocalString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2
	)
{
	if (switch == 1)
		return Default.PickupMessage;
	else
		 return"";
}

simulated function PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (LandedRot != rot(0,0,0))	{
		SetRotation(LandedRot);
	}
}

state FallingPickup
{
	function BeginState()
	{
	    SetTimer(12, false);
	}
}

//FIXME!!!
simulated event ClientTrigger()
{
	bHidden=true;
	if (EffectIsRelevant(Location, false))
		FadeOutEffect = Spawn(class'BCPickupFadeEffect',self,,Location,Rotation);
}

State FadeOut
{
	function BeginState()
	{
		SetPhysics(PHYS_None);
		LifeSpan = 4.0;
		bClientTrigger = !bClientTrigger;
		if (level.NetMode != NM_DedicatedServer)
			ClientTrigger();
	}
}

defaultproperties
{
     JunkClass=Class'BWBP_JWC_Pro.JO_PipeCorner'
     MaxDesireability=0.750000
     InventoryType=Class'BWBP_JWC_Pro.JunkWeapon'
     RespawnTime=15.000000
     PickupMessage="You picked a piece of Junk"
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerLD'
     CullDistance=2000.000000
     bOrientOnSlope=False
     bNetInitialRotation=True
     Texture=Texture'Engine.S_Weapon'
     DrawScale=0.700000
     TransientSoundVolume=1.000000
     TransientSoundRadius=64.000000
     CollisionRadius=28.000000
     CollisionHeight=6.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
