class WrenchDispenserTrigger extends Trigger;

struct PlayerTouch
{
	var Pawn TouchedPawn;
	var float NextTouchTime;
};

var array<PlayerTouch> Touchers;

var byte					Uses, MaxUses;

event Touch(actor Other)
{
	local int i;
	local xPawn Toucher;
	local PlayerTouch NewToucher;
	local Inventory Inv;
	
	if (xPawn(Other) == None || xPawn(Other).Controller == None)
		return;
	
	Toucher = xPawn(Other);
	
	if (Touchers.Length > 0)
	{
		for (i = 0; i < Touchers.Length && Touchers[i].TouchedPawn != Toucher; i++);
		
		if (i < Touchers.Length)
		{
			if (Touchers[i].NextTouchTime > Level.TimeSeconds)
				return;
			Touchers[i].NextTouchTime = Level.TimeSeconds + 3;
		}
		
		else
		{
			NewToucher.TouchedPawn = Toucher;
			NewToucher.NextTouchTime = Level.TimeSeconds + 3;
			Touchers[Touchers.Length] = NewToucher;
		}
	}
	
	else
	{
		NewToucher.TouchedPawn = Toucher;
		NewToucher.NextTouchTime = Level.TimeSeconds + 3;
		Touchers[Touchers.Length] = NewToucher;
	}
	
	i = 0;
	
	for (Inv=Pawn(Other).Inventory; Inv != None && i < 1000; Inv = Inv.Inventory)
	{
		i++;
		if (Weapon(Inv) == None || (BallisticWeapon(Inv) != None && BallisticWeapon(Inv).bWT_Super) || WrenchWarpDevice(Inv) != None)
			continue;
		Weapon(Inv).FillToInitialAmmo();
	}
	
	Owner.PlaySound(Sound'BW_Core_WeaponSound.Ammo.AmmoPackPickup');
	
	if (PlayerController(Toucher.Controller) != None)
		PlayerController(Toucher.Controller).ReceiveLocalizedMessage(class'AmmoCrateLocalMessage');
		
	++Uses;
	
	if (Uses >= MaxUses)
	{
		WrenchAmmoCrate(Owner).bWarpOut=True;
		Owner.GoToState('Destroying');
	}
}

defaultproperties
{
     MaxUses=2
     CollisionRadius=64.000000
     CollisionHeight=32.000000
}
