class E23WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.040000),(InVal=0.200000,OutVal=0.12000),(InVal=0.350000,OutVal=0.170000),(InVal=0.600000,OutVal=0.220000),(InVal=0.800000,OutVal=0.320000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.380000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.240000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=64,Max=256)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.250000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightingTime=0.550000	 
        MagAmmo=100        
        InventorySize=12
        SightMoveSpeedFactor=0.8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}