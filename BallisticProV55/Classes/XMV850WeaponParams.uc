class XMV850WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		CrouchMultiplier=0.75
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.22),(InVal=0.3,OutVal=0.28),(InVal=0.4,OutVal=0.4),(InVal=0.5,OutVal=0.3),(InVal=0.6,OutVal=0.1),(InVal=0.7,OutVal=0.25),(InVal=0.8,OutVal=0.4),(InVal=1,OutVal=0.600000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=-0.170000),(InVal=0.350000,OutVal=-0.400000),(InVal=0.500000,OutVal=-0.700000),(InVal=1.000000,OutVal=-1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=32768.000000
		DeclineTime=2.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.500000
		AimSpread=(Min=256,Max=1024)
		ChaosSpeedThreshold=350.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		MagAmmo=300
		SightingTime=0.6
		SightMoveSpeedFactor=0.9
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}