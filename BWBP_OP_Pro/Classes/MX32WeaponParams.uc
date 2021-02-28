class MX32WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.200000
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		CrouchMultiplier=0.750000
		AimSpread=(Min=64,Max=768)
		AimAdjustTime=0.550000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		JumpOffset=(Pitch=-4000,Yaw=1500)
		ChaosDeclineTime=0.800000
		ChaosDeclineDelay=0.600000
		ChaosSpeedThreshold=7000.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=0.870000
        PlayerJumpFactor=0.870000
        SightMoveSpeedFactor=0.75
		MagAmmo=50
		SightingTime=0.55
		DisplaceDurationMult=1.4
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}