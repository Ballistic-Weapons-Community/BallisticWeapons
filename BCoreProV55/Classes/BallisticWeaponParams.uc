//=============================================================================
// BallisticWeaponParams.
//
// Class which holds all parameter information for a BallisticWeapon. BWs call
// into this class on creation, and the class initializes any variables of the 
// Weapon, the RecoilComponent and the AimComponent according to the current 
// game style.
//
// by Azarael 2020
//=============================================================================
class BallisticWeaponParams extends Object;

var WeaponParams            Params[2];

static simulated final function Initialize(BallisticWeapon BW)
{
    SetWeaponParams(BW);
    SetRecoilParams(BW);
    SetAimParams(BW);

    OnInitialize(BW);
}

static simulated final function SetWeaponParams(BallisticWeapon BW)
{
    BW.WeaponParams = default.Params[0];
    BW.OnWeaponParamsChanged();
}

static simulated final function SetRecoilParams(BallisticWeapon BW)
{
    BW.RcComponent.Params = default.Params[0].RecoilParams[BW.GetRecoilParamsIndex()];
	BW.RcComponent.Recalculate();
}

static simulated final function SetAimParams(BallisticWeapon BW)
{
    BW.AimComponent.Params = default.Params[0].AimParams[BW.GetAimParamsIndex()];
    BW.AimComponent.DisplaceDurationMult = default.Params[0].default.DisplaceDurationMult;
	BW.AimComponent.Recalculate();
}

// Subclass function for overriding
static simulated function OnInitialize(BallisticWeapon BW);