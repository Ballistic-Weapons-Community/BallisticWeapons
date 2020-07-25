//=============================================================================
// Ammo_M46Clip.
//
// M46 ammo.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_M46Clip extends BallisticAmmo;

var Ammo_M46Grenades Grenades;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_M46Clip') )
	{
		if (Grenades==None)
		{
			Grenades = Ammo_M46Grenades(Pawn(Owner).FindInventoryType(class'Ammo_M46Grenades'));
			if (Grenades == None)
			{
				Grenades = spawn(class'Ammo_M46Grenades',Owner,,,rot(0,0,0));
				Grenades.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Grenades!=None)
		{
			if (Grenades.AmmoAmount < Grenades.MaxAmmo)
			{
				Grenades.AddAmmo(1);
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
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BallisticTextures_25.OA-AR.AmmoIcon_OAARFlash'
     PickupClass=Class'BallisticProV55.AP_M46Clip'
     IconMaterial=Texture'BallisticTextures_25.OA-AR.AmmoIcon_OAAR'
     IconCoords=(X2=64,Y2=64)
     ItemName=".310 M46 Rounds"
}
