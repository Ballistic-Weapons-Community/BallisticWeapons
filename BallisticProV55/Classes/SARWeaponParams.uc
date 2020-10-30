class SARWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.35
		CrouchMultiplier=0.75
		DeclineDelay=0.14
	End Object

	Begin Object Class=RecoilParams Name=ArenaBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.45
		CrouchMultiplier=1
		DeclineDelay=0.14
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.300000
		AimSpread=(Min=12,Max=768)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=15000.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=32
        InventorySize=12
        SightingTime=0.250000
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}