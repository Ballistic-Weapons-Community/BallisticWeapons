//=============================================================================
// BallisticArmorPickup
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticArmorPickup extends ArmorPickup;

var() int ArmorCharge; // Amount of armor this pickup should give

function AnnouncePickup( Pawn Receiver )
{
	Receiver.HandlePickup(self);
	PlaySound( PickupSound,SLOT_Interact,TransientSoundVolume, ,TransientSoundRadius );
}

function float BotDesireability( pawn Bot )
{
	local Inventory AlreadyHas;
	local Armor AlreadyHasArmor;
	local float desire;
	local bool bChecked;

	desire = MaxDesireability;

	if ( RespawnTime < 10 )
	{
		bChecked = true;
		AlreadyHas = Bot.FindInventoryType(InventoryType);
		if ( AlreadyHas != None )
		{
			if ( Inventory != None )
			{
				if( Inventory.Charge <= AlreadyHas.Charge )
					return -1;
			}
			else if ( InventoryType.Default.Charge <= AlreadyHas.Charge )
				return -1;
		}
	}

	if ( !bChecked )
		AlreadyHasArmor = Armor(Bot.FindInventoryType(InventoryType));
	if ( AlreadyHasArmor != None )
	{
		if (BallisticArmor(AlreadyHasArmor) != None)
		{
			if (BallisticArmor(AlreadyHasArmor).Charge >= BallisticArmor(AlreadyHasArmor).MaxCharge)
				return -1;
			else if (BallisticArmor(AlreadyHasArmor).Charge >= BallisticArmor(AlreadyHasArmor).MaxCharge / 2)
				desire *= 1.1 - (BallisticArmor(AlreadyHasArmor).Charge-BallisticArmor(AlreadyHasArmor).MaxCharge / 2) /
						  (BallisticArmor(AlreadyHasArmor).MaxCharge-BallisticArmor(AlreadyHasArmor).MaxCharge / 2);

				desire *= BallisticArmor(AlreadyHasArmor).MaxCharge / (BallisticArmor(AlreadyHasArmor).MaxCharge - BallisticArmor(AlreadyHasArmor).Charge) - 1;
		}
		desire *= (1 - AlreadyHasArmor.Charge * AlreadyHasArmor.ArmorAbsorption * 0.00003);
	}
	if ( Armor(Inventory) != None )
	{
		// pointing to specific, existing item
		desire *= (Inventory.Charge * 0.005);
		desire *= (Armor(Inventory).ArmorAbsorption * 0.01);
	}
	else
	{
		desire *= (InventoryType.default.Charge * 0.005);
		desire *= (class<Armor>(InventoryType).default.ArmorAbsorption * 0.01);
	}
	return desire;
}

defaultproperties
{
     ArmorCharge=100
}
