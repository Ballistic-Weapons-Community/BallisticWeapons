class MRT6WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.200000
        DeclineTime=0.700000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        JumpChaos=1.000000
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.05
		DisplaceDurationMult=0.33
		SightingTime=0.25
		MagAmmo=8
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}