class X82WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=X83RecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.600000
		YRandFactor=0.300000
		DeclineTime=1.500000
		MaxRecoil=8192
		HipMultiplier=3
		CrouchMultiplier=0.7
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=2048)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.15
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.85
		PlayerJumpFactor=0.85
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.750000		
		DisplaceDurationMult=1.25
		MagAmmo=5
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}