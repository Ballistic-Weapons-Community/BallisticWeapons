//=============================================================================
// CItem_Ammo.
//
// Gives ammo for all equiped weapons
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CItem_Ammo extends ConflictItem;

// Increase AmmoBonus
static function bool AddAmmoBonus(Pawn Other, out float AmmoBonus)
{
	AmmoBonus += 0.5;
	return true;
}

defaultproperties
{
     ItemName="Ammo"
     ItemAmount="+50%"
     Description="Extra Ammo.|Provides 50% extra starting ammo for all selected weapons."
     Icon=Texture'BWEliminationTex.ui.Icon_Ammo'
     bBonusAmmo=True
}
