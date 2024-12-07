class Ammo_BloodhoundDarts extends BallisticAmmo;

var Ammo_BloodhoundTazer Tazers;

function bool HandlePickupQuery( pickup Item )
{
	if ( Item.IsA('AP_leMat') )// Item.class == class'AP_leMat' )
	{
		if (Tazers==None)
		{
			Tazers = Ammo_BloodhoundTazer(Pawn(Owner).FindInventoryType(class'Ammo_BloodhoundTazer'));
			if (Tazers == None)
			{
				Tazers = spawn(class'Ammo_BloodhoundTazer',Owner,,,rot(0,0,0));
				Tazers.GiveTo( Pawn(Owner), Item );
			}
		}
		if (Tazers!=None)
		{
			if (Tazers.AmmoAmount < Tazers.MaxAmmo)
			{
				Tazers.AddAmmo(5);
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
     InitialAmount=45
     IconFlashMaterial=Shader'BWBP_OP_Tex.Bloodhound.AmmoIcon_BloodhoundFlash'
     PickupClass=Class'BWBP_OP_Pro.AP_BloodhoundDrum'
     IconMaterial=Texture'BWBP_OP_Tex.Bloodhound.AmmoIcon_Bloodhound'
     IconCoords=(X2=64,Y2=64)
     ItemName="Bloodhound Darts"
}
