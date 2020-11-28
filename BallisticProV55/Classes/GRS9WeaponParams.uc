class GRS9WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.35
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.12),(InVal=0.300000,OutVal=0.150000),(InVal=0.4,OutVal=0.02),(InVal=0.550000,OutVal=-0.120000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.200000)))
        YCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.10000
        YRandFactor=0.10000
        DeclineTime=0.750000
        DeclineDelay=0.350000
        MaxRecoil=6144
        HipMultiplier=1.5
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=2
        SprintChaos=0.050000
        AimAdjustTime=0.350000
        ChaosDeclineTime=0.450000
    End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.050000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=15
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}