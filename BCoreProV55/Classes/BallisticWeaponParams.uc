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
//      + WeaponParams - defines gameplay characteristics, indexed by weapon layout
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

var array<WeaponParams>                  Layouts; //Gun variants, attachment setups, alternate designs
var array<WeaponCamos>                  Camos; //Gun skins

static simulated final function Initialize(BallisticWeapon BW)
{
    SetWeaponParams(BW);
    SetFireParams(BW);
    SetRecoilParams(BW);
    SetAimParams(BW);

    OnInitialize(BW);
}

static simulated final function SetWeaponParams(BallisticWeapon BW)
{
    BW.WeaponParams = default.Layouts[BW.LayoutIndex];
    BW.OnWeaponParamsChanged();
}

static simulated final function SetFireParams(BallisticWeapon BW)
{
    if (default.Layouts[BW.LayoutIndex].FireParams.Length > 0)
    {
        BW.BFireMode[0].Params = default.Layouts[BW.LayoutIndex].FireParams
        [
            Min
            (
                BW.CurrentWeaponMode, 
                default.Layouts[BW.LayoutIndex].FireParams.Length - 1
            )
        ];

        BW.BFireMode[0].OnFireParamsChanged(BW.AmmoIndex);
    }

/*    else 
    {
        Log("BallisticWeaponParams: Could not initialize " $ BW.ItemName $ "'s primary fire; no fire params configured");
    }
*/

    if (default.Layouts[BW.LayoutIndex].AltFireParams.Length > 0)
    {
        BW.BFireMode[1].Params = default.Layouts[BW.LayoutIndex].AltFireParams
        [
            Min
            (
                BW.CurrentWeaponMode, 
                default.Layouts[BW.LayoutIndex].AltFireParams.Length - 1
            )
        ];
        BW.BFireMode[1].OnFireParamsChanged(BW.AmmoIndex);
    }

/*
    else 
    {
        Log("BallisticWeaponParams: Could not initialize " $ BW.ItemName $ "'s alternate fire; no fire params configured");
    }
*/
}

static simulated final function SetRecoilParams(BallisticWeapon BW)
{
    BW.RcComponent.Params = default.Layouts[BW.LayoutIndex].RecoilParams[BW.GetRecoilParamsIndex()];
	BW.RcComponent.Recalculate();
}

static simulated final function SetAimParams(BallisticWeapon BW)
{
    BW.AimComponent.Params = default.Layouts[BW.LayoutIndex].AimParams[BW.GetAimParamsIndex()];
    BW.AimComponent.DisplaceDurationMult = default.Layouts[BW.LayoutIndex].DisplaceDurationMult;
	BW.AimComponent.Recalculate();
}

static simulated final function SetProjectileParams(BallisticWeapon BW, BallisticProjectile proj)
{
	if (!proj.bApplyParams)
		return;

    if (proj.ModeIndex == 0)
    {
        if (default.Layouts[BW.LayoutIndex].FireParams.Length > 0)
        {
            proj.ApplyParams
            (
                ProjectileEffectParams
                (
                    default.Layouts[BW.LayoutIndex].FireParams
                    [
                        Min
                        (
                            BW.CurrentWeaponMode, 
                            default.Layouts[BW.LayoutIndex].FireParams.Length - 1
                        )
                    ].FireEffectParams[BW.AmmoIndex]
                )
            );
        }
    }
    
    else if (default.Layouts[BW.LayoutIndex].AltFireParams.Length > 0)
    {
        proj.ApplyParams
        (
            ProjectileEffectParams
            (
                default.Layouts[BW.LayoutIndex].AltFireParams
                [
                    Min
                    (
                        BW.CurrentWeaponMode, 
                        default.Layouts[BW.LayoutIndex].AltFireParams.Length - 1
                    )
                ].FireEffectParams[BW.AmmoIndex]
            )
        );
    }
}

static simulated final function OverrideFireParams(BallisticWeapon BW, int newIndex)
{
    if (default.Layouts[BW.LayoutIndex].FireParams.Length > 0)
    {
        BW.BFireMode[0].Params = default.Layouts[BW.LayoutIndex].FireParams
        [
            Min
            (
                newIndex, 
                default.Layouts[BW.LayoutIndex].FireParams.Length - 1
            )
        ];

        BW.BFireMode[0].OnFireParamsChanged(BW.AmmoIndex);
    }


    if (default.Layouts[BW.LayoutIndex].AltFireParams.Length > 0)
    {
        BW.BFireMode[1].Params = default.Layouts[BW.LayoutIndex].AltFireParams
        [
            Min
            (
                newIndex, 
                default.Layouts[BW.LayoutIndex].AltFireParams.Length - 1
            )
        ];
        BW.BFireMode[1].OnFireParamsChanged(BW.AmmoIndex);
    }
}

static simulated final function OverrideProjectileParams(BallisticWeapon BW, BallisticProjectile proj, int newIndex)
{
    if (proj.ModeIndex == 0)
    {
        if (default.Layouts[BW.LayoutIndex].FireParams.Length > 0)
        {
            proj.ApplyParams
            (
                ProjectileEffectParams
                (
                    default.Layouts[BW.LayoutIndex].FireParams
                    [
                        Min
                        (
                            newIndex, 
                            default.Layouts[BW.LayoutIndex].FireParams.Length - 1
                        )
                    ].FireEffectParams[BW.AmmoIndex]
                )
            );
        }
    }
    
    else if (default.Layouts[BW.LayoutIndex].AltFireParams.Length > 0)
    {
        proj.ApplyParams
        (
            ProjectileEffectParams
            (
                default.Layouts[BW.LayoutIndex].AltFireParams
                [
                    Min
                    (
                        newIndex, 
                        default.Layouts[BW.LayoutIndex].AltFireParams.Length - 1
                    )
                ].FireEffectParams[BW.AmmoIndex]
            )
        );
    }
}

// Subclass function for overriding
static simulated function OnInitialize(BallisticWeapon BW);