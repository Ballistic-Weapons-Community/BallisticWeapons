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
    local class<BallisticAmmo> ammo, sec_ammo;
	local int ammo_count;
	local float add;
	
	if(Pawn(Owner).Role == ROLE_Authority)
	{
		heldWeapon = BallisticWeapon(Pawn(Owner).Weapon);
		
		if(heldWeapon == None || heldWeapon.bWT_Super)
			return;
		
		ammo_count = heldWeapon.AmmoAmount(0);

        ammo = class<BallisticAmmo>(heldWeapon.GetAmmoClass(0));
        sec_ammo = class<BallisticAmmo>(heldWeapon.GetAmmoClass(1));
		
		if(ammo != None && !ammo.default.bNoPackResupply && ammo.default.InitialAmount > 4)
        {
            add = Max(heldWeapon.GetAmmoClass(0).default.InitialAmount * 0.1, 1);
            heldWeapon.AddAmmo(add, 0);
        }
		
		if(sec_ammo == None || ammo == sec_ammo)
			return;
		
		ammo_count = heldWeapon.AmmoAmount(1);
		
		if(!sec_ammo.default.bNoPackResupply && sec_ammo.default.InitialAmount > 4)
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
