//=============================================================================
// Ammo_556mm.
//
// 5.56mm bullet ammo. Used by several of the ballistic weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CX85Bullets extends BallisticAmmo;

var Ammo_CX85Darts Darts;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_CX85Mag') )
	{
		if (Darts==None)
		{
			Darts = Ammo_CX85Darts(Pawn(Owner).FindInventoryType(class'Ammo_CX85Darts'));
			if (Darts == None)
			{
				Darts = spawn(class'Ammo_CX85Darts',Owner,,,rot(0,0,0));
				Darts.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Darts!=None)
		{
			if (Darts.AmmoAmount < Darts.MaxAmmo)
			{
				Darts.AddAmmo(6);
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
     MaxAmmo=200
     InitialAmount=100
     IconFlashMaterial=Shader'BWBPOtherPackTex3.CX85.CX85-AmmoIconFlash'
     PickupClass=Class'BWBPOtherPackPro.AP_CX85Mag'
     IconMaterial=Texture'BWBPOtherPackTex3.CX85.CX85-AmmoIcon'
     IconCoords=(X2=64,Y2=64)
     ItemName="CX85 Ammo"
}
