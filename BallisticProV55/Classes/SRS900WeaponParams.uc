class SRS900WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=1.00000
		DeclineDelay=0.400000
	End Object
	 
	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=16,Max=192)
		ChaosDeclineTime=0.75
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=20
		SightingTime=0.50000
		SightMoveSpeedFactor=0.8
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}