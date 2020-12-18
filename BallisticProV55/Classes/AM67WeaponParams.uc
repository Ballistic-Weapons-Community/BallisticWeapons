class AM67WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.65
        XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
        DeclineDelay=0.6
        DeclineTime=1.0
        MaxRecoil=8192.000000
        XRandFactor=0.10000
        YRandFactor=0.10000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=16,Max=128)
        AimAdjustTime=0.450000
        ADSMultiplier=1
        JumpChaos=0.200000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=500.000000
    End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.75
        MagAmmo=8
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}