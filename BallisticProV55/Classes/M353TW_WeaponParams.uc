class M353TW_WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=M353_TWRecoilParams
	 	HipMultiplier=1.000000
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.03000
		YRandFactor=0.03000
		MaxRecoil=12288.000000
		DeclineTime=0.500000
		DeclineDelay=0.150000
	End Object

	Begin Object Class=AimParams Name=M353_TWAimParams
		ADSMultiplier=0.300000
		AimAdjustTime=0.800000
		AimSpread=(Min=0,Max=0)
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		ViewBindFactor=1.000000
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=3000.000000
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=0.950000
        PlayerJumpFactor=0.950000
        SightMoveSpeedFactor=0.8
		MagAmmo=100
		SightingTime=0.55
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}