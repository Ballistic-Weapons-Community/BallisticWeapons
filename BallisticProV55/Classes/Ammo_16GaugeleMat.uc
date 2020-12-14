//=============================================================================
// Ammo_16GaugeleMat.
//
// 16 Gauge shotgun ammo. Used by Wilson DB revolver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_16GaugeleMat extends BallisticAmmo;

var Ammo_leMat Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_leMat') )// Item.class == class'AP_leMat' )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_leMat(Pawn(Owner).FindInventoryType(class'Ammo_leMat'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_leMat',Owner,,,rot(0,0,0));
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
		AddAmmo(5);
        item.SetRespawn();
		return true;
	}
	else
		return super.HandlePickupQuery(Item);
}

defaultproperties
{
     MaxAmmo=24
     InitialAmount=12
     IconFlashMaterial=Shader'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DBFlash'
     PickupClass=Class'BallisticProV55.AP_leMat'
     IconMaterial=Texture'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName="16 Gauge Shells"
}
