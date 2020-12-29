//=============================================================================
// Ammo_XMK5Clip.
//
// XMK5 ammo.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_XMK5Clip extends BallisticAmmo;

var Ammo_XMK5Darts Darts;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_XMK5Clip') )
	{
		if (Darts==None)
		{
			Darts = Ammo_XMK5Darts(Pawn(Owner).FindInventoryType(class'Ammo_XMK5Darts'));
			if (Darts == None)
			{
				Darts = spawn(class'Ammo_XMK5Darts',Owner,,,rot(0,0,0));
				Darts.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Darts!=None)
		{
			if (Darts.AmmoAmount < Darts.MaxAmmo)
			{
				Darts.AddAmmo(3);
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
		AddAmmo(Ammo(item).AmmoAmount);
        item.SetRespawn();
		return true;
	}
	else
		return super.HandlePickupQuery(Item);
}

defaultproperties
{
     MaxAmmo=192
     InitialAmount=96
     IconFlashMaterial=Shader'BW_Core_WeaponTex.OA-SMG.AmmoIcon_OASMGFlash'
     PickupClass=Class'BallisticProV55.AP_XMK5Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.OA-SMG.AmmoIcon_OASMG'
     IconCoords=(X2=64,Y2=64)
     ItemName="10mm XMk5 Rounds"
}
