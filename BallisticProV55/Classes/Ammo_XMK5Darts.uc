//=============================================================================
// Ammo_XMK5Darts.
//
// Ammo for the XMK5 Dart cannon
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_XMK5Darts extends BallisticAmmo;

var XMK5SubMachinegun		DaXMK5;
var Ammo_XMK5Clip Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_XMK5Clip') )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_XMK5Clip(Pawn(Owner).FindInventoryType(class'Ammo_XMK5Clip'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_XMK5Clip',Owner,,,rot(0,0,0));
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
		if (DaXMK5 != None)
			DaXMK5.DartPickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=18
     InitialAmount=3
     IconFlashMaterial=Shader'BallisticTextures_25.OA-SMG.AmmoIcon_OASMGFlash'
     PickupClass=Class'BallisticProV55.AP_XMK5Clip'
     IconMaterial=Texture'BallisticTextures_25.OA-SMG.AmmoIcon_OASMG'
     IconCoords=(X2=64,Y2=64)
     ItemName="XMk5 Stun Darts"
}
