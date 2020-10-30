class MGLWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=6144.000000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=192,Max=768)
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		ChaosDeclineTime=1.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=24
		SightMoveSpeedFactor=0.9
		SightingTime=0.40000		
		DisplaceDurationMult=1
		MagAmmo=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}