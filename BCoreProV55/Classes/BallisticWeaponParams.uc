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
//
// Because of a flaw with objects passed as function arguments in this engine, 
// any assignment of a subobject to a property of another object must be done 
// through operator.() using an Actor as an intermediary
//
// for example, BW.AimComponent.Params = default.AimParams[0];
//=============================================================================
// by Azarael 2020
//=============================================================================
class BallisticWeaponParams extends Object;

var WeaponParams                  Params[2];

static simulated final function Initialize(BallisticWeapon BW)
{
    SetWeaponParams(BW);
    //SetFireParams(BW);
    SetRecoilParams(BW);
    SetAimParams(BW);

    OnInitialize(BW);
}

static simulated final function SetWeaponParams(BallisticWeapon BW)
{
    BW.WeaponParams = default.Params[BW.default.BCRepClass.default.GameStyle];
    BW.OnWeaponParamsChanged();
}

static simulated final function SetFireParams(BallisticWeapon BW)
{
    BW.BFireMode[0].Params = default.Params[BW.default.BCRepClass.default.GameStyle].FireParams[BW.CurrentWeaponMode];
    BW.BFireMode[0].OnFireParamsChanged(BW.AmmoType);

    BW.BFireMode[1].Params = default.Params[BW.default.BCRepClass.default.GameStyle].AltFireParams[BW.CurrentWeaponMode];
    BW.BFireMode[1].OnFireParamsChanged(BW.AmmoType);
}

static simulated final function SetRecoilParams(BallisticWeapon BW)
{
    BW.RcComponent.Params = default.Params[BW.default.BCRepClass.default.GameStyle].RecoilParams[BW.GetRecoilParamsIndex()];
	BW.RcComponent.Recalculate();
}

static simulated final function SetAimParams(BallisticWeapon BW)
{
    BW.AimComponent.Params = default.Params[BW.default.BCRepClass.default.GameStyle].AimParams[BW.GetAimParamsIndex()];
    BW.AimComponent.DisplaceDurationMult = default.Params[BW.default.BCRepClass.default.GameStyle].default.DisplaceDurationMult;
	BW.AimComponent.Recalculate();
}

// Subclass function for overriding
static simulated function OnInitialize(BallisticWeapon BW);