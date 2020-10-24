//==================================================================
// Dummy weapons for use to grant effects via the killstreak system in Loadout.
// No support for use of these as standard weapons
//==================================================================
class DummyWeapon extends BallisticWeapon abstract HideDropDown;

static function bool ApplyEffect(Pawn Other, byte Level, optional bool bInitial)
{
	return true;
}

defaultproperties
{
     InventoryGroup=99
}
