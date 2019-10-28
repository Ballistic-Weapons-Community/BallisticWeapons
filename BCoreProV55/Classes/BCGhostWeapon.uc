//=============================================================================
// BCGhostWeapon.
//
// A GhostWeapon is an inventory item that remains after certain weapons that
// cannot exist without ammo, e.g. HandGrenades
// This is mainly use by the Ballistic Loadout system to bring back grenades
// after they ran out of ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BCGhostWeapon extends Inventory;

var() class<BallisticWeapon> MyWeaponClass;

function ReviveWeapon()
{
	local Weapon newWeapon;

    if(MyWeaponClass != None && Instigator.FindInventoryType(MyWeaponClass)==None)
    {
        newWeapon = Spawn(MyWeaponClass,,,Instigator.Location);
        if( newWeapon != None )
        {
            newWeapon.GiveTo(Instigator);
			newWeapon.ConsumeAmmo(0, 9999, true);
			newWeapon.ConsumeAmmo(1, 9999, true);
    		if (BallisticWeapon(newWeapon) != None)
				BallisticWeapon(newWeapon).MagAmmo=0;
        }
    }
	Pawn(Owner).DeleteInventory( Self );
    super(actor).Destroy();
}

defaultproperties
{
}
