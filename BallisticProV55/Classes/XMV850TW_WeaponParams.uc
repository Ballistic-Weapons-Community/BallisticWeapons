class XMV850TW_WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.03),(InVal=0.2,OutVal=-0.05),(InVal=0.3,OutVal=-0.07),(InVal=0.4,OutVal=0.0),(InVal=0.5,OutVal=0.1),(InVal=0.6,OutVal=0.18),(InVal=0.7,OutVal=0.05),(InVal=0.8,OutVal=0),(InVal=1,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.500000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.03000
		YRandFactor=0.03000
		ViewBindFactor=1.000000
		CrouchMultiplier=1.000000
		HipMultiplier=1.000000
		DeclineTime=1.100000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=1
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=1
		AimSpread=(Min=0,Max=0)
		ChaosSpeedThreshold=350.000000
		AimDamageThreshold=2000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		MagAmmo=300
		SightingTime=0.80000
		SightMoveSpeedFactor=0.9
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}