class M575WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.500000
		XCurve=(Points=(,(InVal=0.070000,OutVal=-0.050000),(InVal=0.100000,OutVal=-0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=-0.100000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.450000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=12288.000000
		DeclineTime=1.500000
		DeclineDelay=0.150000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=384,Max=3072)
		ADSMultiplier=0.700000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		ChaosDeclineTime=1.600000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.85
		PlayerJumpFactor=0.85
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.550000
		DisplaceDurationMult=1.25
		MagAmmo=100
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}