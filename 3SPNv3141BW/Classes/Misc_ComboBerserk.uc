class Misc_ComboBerserk extends ComboBerserk;

function StartEffect(xPawn P)
{
	Super.StartEffect(P);
	
	SetTimer(0.9, true);
	Timer();
}

function Timer()
{
	local BallisticWeapon heldWeapon;
	local int ammo;
	local float add;
	
	if(Pawn(Owner).Role == ROLE_Authority)
	{
		heldWeapon = BallisticWeapon(Pawn(Owner).Weapon);
		
		if(heldWeapon == None)
			return;
		
		ammo = heldWeapon.AmmoAmount(0);
		
		if(heldWeapon.GetAmmoClass(0) != None)
		{
			if(heldWeapon.GetAmmoClass(0).default.InitialAmount > 4)
			{
				add = Max(heldWeapon.GetAmmoClass(0).default.InitialAmount * 0.1, 1);
				heldWeapon.AddAmmo(add, 0);
			}
		}
		
		if(heldWeapon.GetAmmoClass(1) == None || heldWeapon.GetAmmoClass(0) == heldWeapon.GetAmmoClass(1))
			return;
		
		ammo = heldWeapon.AmmoAmount(1);
		
		if(heldWeapon.GetAmmoClass(1).default.InitialAmount > 4)
		{
			add = Max(heldWeapon.GetAmmoClass(1).default.InitialAmount * 0.1, 1);
			heldWeapon.AddAmmo(add, 1);
		}
	}
}

defaultproperties
{
     Duration=45.000000
}
