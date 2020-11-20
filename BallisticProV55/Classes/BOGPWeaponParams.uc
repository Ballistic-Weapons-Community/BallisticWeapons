class BOGPWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.6
        YawFactor=0.000000
        XRandFactor=0.250000
        YRandFactor=0.250000
        DeclineTime=1.000000
        DeclineDelay=0.800000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=16,Max=378)
        JumpChaos=0.750000
        ChaosDeclineTime=1.000000
    End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.75
        MagAmmo=1
        SightingTime=0.200000
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}