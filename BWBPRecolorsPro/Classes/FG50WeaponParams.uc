class FG50WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.15,OutVal=0.075),(InVal=0.400000,OutVal=0.130000),(InVal=0.550000,OutVal=0.15000),(InVal=0.700000,OutVal=0.21000),(InVal=1.000000,OutVal=0.225000)))
		YCurve=(Points=(,(InVal=0.20000,OutVal=0.250000),(InVal=0.400000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.050000
		MaxRecoil=16384
		DeclineTime=1.500000
	End Object

	Begin Object Class=AimParams Name=ArenaStandardAimParams
		ADSMultiplier=0.7
		AimSpread=(Min=128,Max=1536)
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=350
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	Begin Object Class=AimParams Name=ArenaControlledAimParams
		AimAdjustTime=1
		ADSMultiplier=0.4
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.850000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.60000		
		DisplaceDurationMult=1.25
		MagAmmo=40
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaStandardAimParams'
		AimParams(1)=AimParams'ArenaControlledAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}