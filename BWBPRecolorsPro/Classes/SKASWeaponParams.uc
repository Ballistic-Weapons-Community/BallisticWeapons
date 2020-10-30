class SKASWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.45
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.050000
        YRandFactor=0.050000
        DeclineTime=1.500000
        DeclineDelay=0.450000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        SprintOffset=(Pitch=-1000,Yaw=-2048)
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=24
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}