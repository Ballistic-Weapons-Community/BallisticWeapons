class Fifty9WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		MaxRecoil=6144
		CrouchMultiplier=1
		HipMultiplier=1
		ViewBindFactor=0.6
		DeclineDelay=0.22
	End Object

	Begin Object Class=RecoilParams Name=ArenaAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000),(InVal=0.400000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.100000),(InVal=0.800000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		MaxRecoil=6144
		CrouchMultiplier=0.8
		HipMultiplier=1.75
		ViewBindFactor=0.2
		DeclineDelay=0.09
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.450000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.05 
		DisplaceDurationMult=0.5
        MagAmmo=25        
		InventorySize=12
		SightingTime=0.2
		RecoilParams(0)=RecoilParams'ArenaBurstRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaAutoRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}