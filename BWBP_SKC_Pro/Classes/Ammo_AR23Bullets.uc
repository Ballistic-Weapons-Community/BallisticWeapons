//=============================================================================
// Ammo_RS8Bullets.
//
// 10mm pistol ammo. Used by the RS8
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_AR23Bullets extends BallisticAmmo;

var Ammo_AR23Grenades Grenades;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_AR23Clip') )
	{
		if (Grenades==None)
		{
			Grenades = Ammo_AR23Grenades(Pawn(Owner).FindInventoryType(class'Ammo_AR23Grenades'));
			if (Grenades == None)
			{
				Grenades = spawn(class'Ammo_AR23Grenades',Owner,,,rot(0,0,0));
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
     MaxAmmo=90
     InitialAmount=36
     IconFlashMaterial=Shader'BWBP_SKC_Tex.LK05.AmmoIcon_LK05Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_AR23Clip'
     IconMaterial=Texture'BWBP_SKC_Tex.LK05.AmmoIcon_LK05'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName=".50 Bullets"
}
