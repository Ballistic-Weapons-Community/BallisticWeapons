class LS14WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.1),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.20000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.560000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.000000
		DeclineDelay=0.2
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=384)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ChaosDeclineTime=1.0
		ChaosDeclineDelay=0.5
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.40000		
		DisplaceDurationMult=1
		MagAmmo=20
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}