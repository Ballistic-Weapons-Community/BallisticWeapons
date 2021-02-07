class XRS10WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		HipMultiplier=1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.220000),(InVal=0.400000,OutVal=0.400000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		MaxRecoil=4096.000000
		DeclineTime=0.5
		DeclineDelay=0.1
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.450000
		ADSMultiplier=2
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.5
		PlayerSpeedFactor=1.050000
		MagAmmo=30
		SightingTime=0.200000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}