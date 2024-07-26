//=============================================================================
// Ammo_MARSGrenades.
//
// Ammo for the MARS Shockwave GL
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MARSGrenades extends BallisticAmmo;

var MARSAssaultRifle		DaF2K;
var Ammo_556mm Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_MARSMagazine') )
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
	else if (Super.HandlePickupQuery(Item))
	{
		if (DaF2K != None)
			DaF2k.GrenadePickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=3
     InitialAmount=2
     IconFlashMaterial=Shader'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAARFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_STANAGShockwave'
     IconMaterial=Texture'BW_Core_WeaponTex.OA-AR.AmmoIcon_OAAR'
     IconCoords=(X2=64,Y2=64)
     ItemName="MARS-3 Shockwave Grenades"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.51f
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.51f
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=TacticalParams
		KillInitialAmmoMult=0.0f
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
