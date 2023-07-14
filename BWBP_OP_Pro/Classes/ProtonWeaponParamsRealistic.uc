class ProtonWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ProtonRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=-0.045000),(InVal=0.300000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		DeclineTime=1.500000
		DeclineDelay=0.250000
		HipMultiplier=3.5
	End Object

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=2560)
		ADSMultiplier=0.000000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.20
		DisplaceDurationMult=1
		MagAmmo=100
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}