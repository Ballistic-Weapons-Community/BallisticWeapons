//=============================================================================
// BallisticAmmoPickup.
//
// Base ammo pickup for Ballistic ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAmmoPickup extends Ammo;

var   float					ChangeTime;			// Time when this pickup should change into another item
var   int					ReplacementsIndex;	// Index into Mutator Replacement list associated with this pickup

delegate OnItemChange (Pickup Pickup);
delegate OnItemPickedUp (Pickup Pickup);

simulated event Tick(float DT)
{
//	if (ChangeTime > 0 && ChangeTime < level.TimeSeconds)
	if (ChangeTime > 0 && level.TimeSeconds > ChangeTime && (IsInState('Sleeping') || /*!level.Game.bWeaponStay || */!PlayerCanSeeMe()))
		OnItemChange(self);

	super.Tick(DT);
}

function inventory SpawnCopy( Pawn Other )
{
	if (!bDropped)
		OnItemPickedUp(self);

	return Super.SpawnCopy(Other);
}

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

event PreBeginPlay()
{
	// Handle autodestruction if desired.
	if( !bGameRelevant && (Level.NetMode != NM_Client) && !Level.Game.BaseMutator.CheckRelevance(Self) )
		Destroy();
	else if ( (Level.DetailMode == DM_Low) && (CullDistance == Default.CullDistance) )
		CullDistance *= 0.8;
}

defaultproperties
{
     ReplacementsIndex=-1
     AmmoAmount=30
     MaxDesireability=0.320000
     InventoryType=Class'BCoreProV55.BallisticAmmo'
     PickupMessage="You picked up some Ballistic ammo"
     PickupForce="FlakAmmoPickup"
     DrawType=DT_StaticMesh
     AmbientGlow=0
     TransientSoundVolume=0.700000
     TransientSoundRadius=64.000000
     MessageClass=Class'BCoreProV55.BallisticPickupMessage'
}
