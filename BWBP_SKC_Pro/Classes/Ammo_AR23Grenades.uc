//=============================================================================
// Ammo_M46Grenades.
//
// Ammo for the M46 Proximity Grenade launcher
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_AR23Grenades extends BallisticAmmo;

var AR23HeavyRifle		DaM46;
var Ammo_AR23Bullets Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_AR23Clip') )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_AR23Bullets(Pawn(Owner).FindInventoryType(class'Ammo_AR23Bullets'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_AR23Bullets',Owner,,,rot(0,0,0));
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
	else if (Super.HandlePickupQuery(Item))
	{
		if (DaM46 != None)
			DaM46.GrenadePickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=4
     InitialAmount=2
     IconFlashMaterial=Shader'BWBP_SKC_Tex.LK05.AmmoIcon_LK05Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_AR23Clip'
     IconMaterial=Texture'BWBP_SKC_Tex.LK05.AmmoIcon_LK05'
     IconCoords=(X2=64,Y2=64)
     ItemName="AR23 Shotgun Grenades"
}
