//=============================================================================
// Ammo_MedDarts.
//
// Ammo for the PS9m dart attachment
//
// by Logan "BlackEagle" Richert. SARGE TOOOOOOOOOOO
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MedDarts extends BallisticAmmo;

var Ammo_TranqP Darts;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_TranqP') )
	{
		if (Darts==None)
		{
			Darts = Ammo_TranqP(Pawn(Owner).FindInventoryType(class'Ammo_TranqP'));
			if (Darts == None)
			{
				Darts = spawn(class'Ammo_TranqP',Owner,,,rot(0,0,0));
				Darts.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Darts!=None)
		{
			if (Darts.AmmoAmount < Darts.MaxAmmo)
			{
				Darts.AddAmmo(Ammo(item).AmmoAmount);
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
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=10
     InitialAmount=1
     IconFlashMaterial=Shader'BW_Core_WeaponTex.OA-SMG.AmmoIcon_OASMGFlash'
     PickupClass=Class'BallisticProV55.AP_XMK5Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.OA-SMG.AmmoIcon_OASMG'
     IconCoords=(X2=64,Y2=64)
     ItemName="PS-9m Med Darts"
}
