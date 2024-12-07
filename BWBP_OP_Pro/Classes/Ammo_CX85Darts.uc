//=============================================================================
// Ammo_CX85Darts.
//
// Ammo for the CX85 Dart cannon
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CX85Darts extends BallisticAmmo;

var Ammo_556mm Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_CX85Mag') )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_556mm(Pawn(Owner).FindInventoryType(class'Ammo_556mm'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_556mm',Owner,,,rot(0,0,0));
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
	else
		return super.HandlePickupQuery(Item);
}

defaultproperties
{
     MaxAmmo=48
     InitialAmount=24
     IconFlashMaterial=Shader'BWBP_OP_Tex.CX85.CX85-AmmoIconFlash'
     PickupClass=Class'BWBP_OP_Pro.AP_CX85Mag'
     IconMaterial=Texture'BWBP_OP_Tex.CX85.CX85-AmmoIcon'
     IconCoords=(X2=64,Y2=64)
     ItemName="CX85 Tracking Darts"
}
