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

defaultproperties
{
     AIRating=-99.000000
     CurrentRating=-99.000000
     bCanThrow=False
     Description="item gun."
     InventoryGroup=231
     ItemName="NullGun"
}
