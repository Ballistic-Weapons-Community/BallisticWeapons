//=============================================================================
// BallisticAmmo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAmmo extends KFAmmunition;

var bool bNoPackResupply;

static function int GetKillResupplyAmmo()
{
    if (default.InitialAmount > 0)
	    return default.InitialAmount/3;
        
    return default.MaxAmmo / 6;
}

function bool AddAmmo(int AmmoToAdd)
{
	if (Pawn(Owner) != None && Pawn(Owner).DrivenVehicle != None && BallisticTurret(Pawn(Owner).DrivenVehicle) != None &&
		!BallisticTurret(Pawn(Owner).DrivenVehicle).DriverGetAmmo(self, AmmoToAdd))
		return true;

	return super.AddAmmo(AmmoToAdd);
}

defaultproperties
{
     MaxAmmo=180
     InitialAmount=30
     PickupClass=Class'BCoreProV55.BallisticAmmoPickup'
     ItemName="Ballistic Ammo"
}
