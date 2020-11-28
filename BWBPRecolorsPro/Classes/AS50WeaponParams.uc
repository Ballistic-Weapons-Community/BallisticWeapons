class AS50WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=FSSG50RecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.15
		MinRandFactor=0.15
		DeclineTime=1.500000
		DeclineDelay=0.500000
		CrouchMultiplier=0.650000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		ADSMultiplier=0.15
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=350.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
        DisplaceDurationMult=1.25
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.650000		
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}