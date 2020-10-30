class MK781WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.050000
		DeclineDelay=0.600000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3000,Yaw=-4096)
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.30000
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}