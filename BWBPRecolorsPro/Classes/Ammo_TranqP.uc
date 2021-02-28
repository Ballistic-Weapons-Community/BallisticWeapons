//=============================================================================
// Ammo_TranqP.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_TranqP extends BallisticAmmo;

var Ammo_MedDarts MedDarts;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_TranqP') )
	{
		if (MedDarts==None)
		{
			MedDarts = Ammo_MedDarts(Pawn(Owner).FindInventoryType(class'Ammo_MedDarts'));
			if (MedDarts == None)
			{
				MedDarts = spawn(class'Ammo_MedDarts',Owner,,,rot(0,0,0));
				MedDarts.GiveTo( Pawn(Owner), Item );
			}
		}
		if (MedDarts!=None)
		{
			if (MedDarts.AmmoAmount < MedDarts.MaxAmmo)
			{
				MedDarts.AddAmmo(1);
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
     MaxAmmo=100
     InitialAmount=50
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPRecolorsPro.AP_TranqP'
     IconMaterial=Texture'BWBP_SKC_Tex.M30A2.AmmoIcon_M30A2'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="Toxic Darts"
}
