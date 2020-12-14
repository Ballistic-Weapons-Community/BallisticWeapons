//=============================================================================
// Ammo_M46Grenades.
//
// Ammo for the M46 Proximity Grenade launcher
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_M46Grenades extends BallisticAmmo;

var M46AssaultRifle		DaM46;
var Ammo_M46Clip Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_M46Clip') )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_M46Clip(Pawn(Owner).FindInventoryType(class'Ammo_M46Clip'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_M46Clip',Owner,,,rot(0,0,0));
				Bullets.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Bullets!=None)
		{
			if (Bullets.AmmoAmount < Bullets.MaxAmmo)
			{
				Bullets.AddAmmo(Ammo(item).AmmoAmount);
				if (AmmoAmount<MaxAmmo)
				{
					item.AnnouncePickup(Pawn(Owner));
			        item.SetRespawn();
			    }
			}
		}
		if (AmmoAmount>=MaxAmmo)
			return true;
		item.AnnouncePickup(Pawn(Owner));
		AddAmmo(2);
        item.SetRespawn();
		return true;
	}
	else if (Super.HandlePickupQuery(Item))
	{
		if (DaM46 != None)
			DaM46.GrenadePickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=4
     InitialAmount=2
     IconFlashMaterial=Shader'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAARFlash'
     PickupClass=Class'BallisticProV55.AP_M46Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAAR'
     IconCoords=(X2=64,Y2=64)
     ItemName="M46 Proximity Grenades"
}
