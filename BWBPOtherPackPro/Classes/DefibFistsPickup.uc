//=============================================================================
// BrawlingPickup- FIXME
//=============================================================================
class DefibFistsPickup extends BallisticWeaponPickup
	placeable;

var() int HealingAmount;
var() bool bSuperHeal;
var() float AdrenalineAmount;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.LCestus');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.RCestus');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.Graph');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.LCestus');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.RCestus');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.DefibFists.Graph');
}

simulated static function UpdateHUD(HUD H)
{
	H.LastPickupTime = H.Level.TimeSeconds;
	H.LastHealthPickupTime = H.LastPickupTime;
	H.LastWeaponPickupTime = H.LastPickupTime;
}

static function string GetLocalString(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2
	)
{
	return Default.PickupMessage$Default.HealingAmount;
}

function int GetHealMax(Pawn P)
{
	if (bSuperHeal)
		return P.SuperHealthMax;

	return P.HealthMax;
}

auto state Pickup
{

	function BeginState()
	{
		if (!bDropped && class<BallisticWeapon>(InventoryType) != None)
			MagAmmo = class<BallisticWeapon>(InventoryType).default.MagAmmo;
		Super.BeginState();
	}

	function Touch( actor Other )
	{
		local Pawn P;
		local xPawn x;
		x = xPawn(Other);

		if ( ValidTouch(Other) )
		{
			P = Pawn(Other);
            if ( P.GiveHealth(HealingAmount, GetHealMax(P)) || (bSuperHeal && !Level.Game.bTeamGame) )
            {
				AnnouncePickup(P);
                SetRespawn();
            }
		}
	}
	function bool ValidTouch( actor Other )
	{
		// make sure its a live player
		if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
			return false;

		// make sure not touching through wall
		if ( !FastTrace(Other.Location, Location) )
			return false;

		// make sure game will let player pick me up
		if( Level.Game.PickupQuery(Pawn(Other), self) )
		{
			LastPickedUpBy = Pawn(Other);
			TriggerEvent(Event, self, Pawn(Other));
			return true;
		}
		return false;
	}

}

defaultproperties
{
     HealingAmount=50
     bSuperHeal=True
     AdrenalineAmount=100.000000
     PickupDrawScale=5.000000
     InventoryType=Class'BWBPOtherPackPro.DefibFists'
     RespawnTime=70.000000
     PickupMessage="You got the Combat Defibrillators."
     Physics=PHYS_None
     DrawScale=5.000000
     TransientSoundVolume=0.600000
     TransientSoundRadius=128.000000
     CollisionRadius=16.000000
     CollisionHeight=28.000000
     Mass=10.000000
}
