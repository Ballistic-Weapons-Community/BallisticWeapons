//=============================================================================
// BallisticWeaponParams.
//
// Class which holds all parameter information for a BallisticWeapon 
// and its fire modes. BWs call into this class on creation, and the class 
// initializes any variables of the Weapon, the RecoilComponent, 
// the AimComponent and both fire modes according to the current game style.
//=============================================================================
// Notes:
//
// Compositional chain will be as follows:
//  + WeaponLayout [int Index] - defines mesh, texture set etc
//      + WeaponParams  [int GameStyle] - defines gameplay characteristics, selected based on game style
//          + RecoilParams    [int CurrentWeaponMode] - defines weapon recoil parameters, selected based on weapon mode
//          + AimParams       [int CurrentWeaponMode] - defines weapon aim params, selected based on weapon mode
//          + [Alt]FireParams [int CurrentWeaponMode] - defines weapon fire params, two arrays depending on weapon mode requested
//              + FireEffectParams [int AmmoIndex] - defines fire effects, selected based on weapon's current ammo type
//=============================================================================
// by Azarael 2020
//=============================================================================
class BallisticWeaponParams extends Object;

var WeaponParams                  Params[2];

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