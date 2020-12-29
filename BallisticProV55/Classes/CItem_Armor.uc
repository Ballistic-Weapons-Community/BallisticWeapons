//=============================================================================
// CItem_Armor.
//
// Gives extra armor
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CItem_Armor extends ConflictItem;

// Add some armor
static function bool Applyitem(Pawn Other)
{
	Other.AddShieldStrength(25);
	return true;
}
// Reset player armor to default
static function ResetPlayer(Pawn Other)
{
	Other.ShieldStrength = Other.default.ShieldStrength;
}

defaultproperties
{
     ItemName="Armor"
     ItemAmount="+25"
     Description="Extra Armor.|Provides 25 additional starting armor."
     Icon=Texture'BW_Core_WeaponTex.ui.Icon_Armor'
}
