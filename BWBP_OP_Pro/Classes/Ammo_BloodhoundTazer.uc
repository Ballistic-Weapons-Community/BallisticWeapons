class Ammo_BloodhoundTazer extends BallisticAmmo;

var Ammo_BloodhoundDarts Bullets;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_leMat') )// Item.class == class'AP_leMat' )
	{
		if (Bullets==None)
		{
			Bullets = Ammo_BloodhoundDarts(Pawn(Owner).FindInventoryType(class'Ammo_BloodhoundDarts'));
			if (Bullets == None)
			{
				Bullets = spawn(class'Ammo_BloodhoundDarts',Owner,,,rot(0,0,0));
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
     MaxAmmo=10
     InitialAmount=3
     IconFlashMaterial=Shader'BWBP_OP_Tex.Bloodhound.AmmoIcon_BloodhoundFlash'
     PickupClass=Class'BWBP_OP_Pro.AP_BloodhoundDrum'
     IconMaterial=Texture'BWBP_OP_Tex.Bloodhound.AmmoIcon_Bloodhound'
     IconCoords=(X2=64,Y2=64)
     ItemName="Bloodhound Tazers"
}
