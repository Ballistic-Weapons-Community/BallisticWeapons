//=============================================================================
// Ammo_545mmSTANAG.
//
// 5.45mm bullet ammo. Shorter length round used in STANAG mags.
// Used by the MARS-3
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_545mmSTANAG extends BallisticAmmo;

var Ammo_F2000Grenades Grenades;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_STANAGShockwave') )
	{
		if (Grenades==None)
		{
			Grenades = Ammo_F2000Grenades(Pawn(Owner).FindInventoryType(class'Ammo_F2000Grenades'));
			if (Grenades == None)
			{
				Grenades = spawn(class'Ammo_F2000Grenades',Owner,,,rot(0,0,0));
				Grenades.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Grenades!=None)
		{
			if (Grenades.AmmoAmount < Grenades.MaxAmmo)
			{
				Grenades.AddAmmo(2);
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
     InitialAmount=90
     IconFlashMaterial=Shader'BWBP_SKC_Tex.M4A1.AmmoIcon_556Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_STANAGShockwave'
     IconMaterial=Texture'BWBP_SKC_Tex.M4A1.AmmoIcon_556'
     IconCoords=(X2=64,Y2=64)
     ItemName="5.45mm STN Ammo"
}
