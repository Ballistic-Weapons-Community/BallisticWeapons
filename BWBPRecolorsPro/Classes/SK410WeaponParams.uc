class SK410WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.65
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=0.120000),(InVal=0.600000,OutVal=0.15000),(InVal=0.750000,OutVal=0.250000),(InVal=1.000000,OutVal=0.32)))
        YCurve=(Points=(,(InVal=0.500000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        YRandFactor=0.05
        XRandFactor=0.05
        DeclineTime=0.500000
        DeclineDelay=0.450000
    End Object

    Begin Object Class=AimParams Name=ArenaAimParams
        SprintOffset=(Pitch=-1000,Yaw=-2048)
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=1
		SightingTime=0.250000
		DisplaceDurationMult=0.75
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}