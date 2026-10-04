//=============================================================================
// NullGun.
//
// A special util sort of weapon used by AI when they are out of weapons. A
// situation that occurs in grenade arenas and the like. This is just supposed
// to give them a bit of guidance and stop the bot code from throwing up with a
// torrent of accessed nones!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class NullGun extends Weapon HideDropDown CacheExempt;

simulated function bool HasAmmo()
{
    return true;
}

// need to figure out modified rating based on enemy/tactical situation
simulated function float RateSelf()
{
	CurrentRating = -99;
	return CurrentRating;
}

function float GetAIRating()
{
	return AIRating;
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if (B.FindInventoryGoal(0.0005))
	{
		B.GoalString = "Find weapon";
		B.SetAttractionState();
	}
	return false;
}

// A bot with no weapon at all makes the stock bot code throw warnings every tick. When Leaving is its last weapon and
// about to go (last grenade thrown, last mine laid), hand it this placeholder, which sends it looking for a real one
static function GiveToUnarmedBot(Pawn P, Weapon Leaving)
{
	local Inventory Inv;
	local Weapon W;

	if (P == None || P.Role < ROLE_Authority || AIController(P.Controller) == None)
		return;
	for (Inv = P.Inventory; Inv != None; Inv = Inv.Inventory)
		if (Weapon(Inv) != None && Inv != Leaving)
			return;
	W = P.Spawn(class'NullGun', P,, P.Location);
	if (W != None)
		W.GiveTo(P);
}

// The stock PutDown asks the mesh for the put down animation, and this has no mesh
simulated function bool PutDown()
{
	if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
	{
		ClientState = WS_PutDown;
		SetTimer(PutDownTime, false);
	}
	return true;
}

defaultproperties
{
     FireModeClass(0)=Class'BCoreProV55.NullFire'
     FireModeClass(1)=Class'BCoreProV55.NullFire'
     AIRating=-99.000000
     CurrentRating=-99.000000
     bCanThrow=False
     Description="item gun."
     InventoryGroup=231
     ItemName="NullGun"
}
