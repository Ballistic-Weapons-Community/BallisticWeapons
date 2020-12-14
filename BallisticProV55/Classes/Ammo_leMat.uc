//=============================================================================
// Ammo_leMat.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_leMat extends BallisticAmmo;

var Ammo_16GaugeleMat Shells;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_leMat') )// Item.class == class'AP_leMat' )
	{
		if (Shells==None)
		{
			Shells = Ammo_16GaugeleMat(Pawn(Owner).FindInventoryType(class'Ammo_16GaugeleMat'));
			if (Shells == None)
			{
				Shells = spawn(class'Ammo_16GaugeleMat',Owner,,,rot(0,0,0));
				Shells.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Shells!=None)
		{
			if (Shells.AmmoAmount < Shells.MaxAmmo)
			{
				Shells.AddAmmo(5);
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
     MaxAmmo=108
     InitialAmount=54
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DBFlash'
     PickupClass=Class'BallisticProV55.AP_leMat'
     IconMaterial=Texture'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName=".41 Wilson DB Bullets"
}
