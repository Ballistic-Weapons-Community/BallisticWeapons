class ARWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.150000),(InVal=0.500000,OutVal=0.250000),(InVal=0.750000,OutVal=0.30000),(InVal=1.000000,OutVal=0.350000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineDelay=0.4
		DeclineTime=1.0	
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=512)
		SprintOffset=(Pitch=-4096,Yaw=-4096)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.95000
		PlayerJumpFactor=0.95000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.550000
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}