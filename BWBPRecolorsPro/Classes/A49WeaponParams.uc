class A49WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.070000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.400000),(InVal=0.540000,OutVal=0.650000),(InVal=0.700000,OutVal=0.720000),(InVal=1.000000,OutVal=0.300000)))
		DeclineTime=0.5
		DeclineDelay=0.170000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=7500.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.050000
		PlayerJumpFactor=1.050000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=32
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}