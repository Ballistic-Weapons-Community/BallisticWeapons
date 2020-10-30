class XOXOWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaFastRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineTime=1.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=RecoilParams Name=ArenaBombRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.200000,OutVal=0.045000),(InVal=0.300000,OutVal=0.150000),(InVal=0.600000,OutVal=0.210000),(InVal=0.700000,OutVal=0.150000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.070000),(InVal=0.200000,OutVal=0.200000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.8
		YRandFactor=1.5
		DeclineDelay=0.8
		DeclineTime=1.500000
	End Object

	Begin Object Class=AimParams Name=ArenaFastAimParams
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	Begin Object Class=AimParams Name=ArenaBombAimParams
		AimSpread=(Min=128,Max=1024)
		SprintOffset=(Pitch=-1024,Yaw=-1024)
		ChaosDeclineTime=1.250000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.30000
		DisplaceDurationMult=1
		MagAmmo=70
		RecoilParams(0)=RecoilParams'ArenaFastRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaBombRecoilParams'
		AimParams(0)=AimParams'ArenaFastAimParams'
		AimParams(1)=AimParams'ArenaBombAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}