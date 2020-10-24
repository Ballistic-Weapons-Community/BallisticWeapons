//=============================================================================
// A42WeaponParams
//=============================================================================
class A42WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=0.05000),(InVal=0.400000,OutVal=0.0800000),(InVal=0.600000,OutVal=0.0200000),(InVal=0.700000,OutVal=0.1),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.550000,OutVal=0.550000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.0)))
        XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.5
        DeclineDelay=0.200000
        ViewBindFactor=0.5
        HipMultiplier=1.5
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=64,Max=128)
        ChaosDeclineTime=0.450000
        ADSMultiplier=2 
    End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=18
        InventorySize=6
        SightingTime=0.200000
        PlayerSpeedFactor=1.100000
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}