//=============================================================================
// CItem_Health.
//
// Gives extra health
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CItem_Health extends ConflictItem;

// Add some health
static function bool Applyitem(Pawn Other)
{
	Other.GiveHealth(25, Other.SuperHealthMax);
	return true;
}
// Reset player health to default
static function ResetPlayer(Pawn Other)
{
	Other.Health = Other.default.Health;
}

defaultproperties
{
     ItemName="Health"
     ItemAmount="+25"
     Description="Extra Health.|Provides 25 bonus starting health."
     Icon=Texture'BW_Core_WeaponTex.ui.Icon_Health'
}
