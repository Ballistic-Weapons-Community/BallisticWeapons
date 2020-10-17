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
     Begin Object Class=RecoilParams Name=DummyRecoilParams
          PitchFactor=0.000000
          YawFactor=0.000000
     End Object
     RecoilParamsList(0)=RecoilParams'DummyRecoilParams'
}
