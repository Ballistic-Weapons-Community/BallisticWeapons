class X82WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		XRandFactor=0.600000
		YRandFactor=0.300000
		DeclineTime=1.500000
		MaxRecoil=8192
		HipMultiplier=2.5
		CrouchMultiplier=0.7
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=512,Max=3072)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.1
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.85
		PlayerJumpFactor=0.85
        DisplaceDurationMult=1.4
		InventorySize=12
		SightMoveSpeedFactor=0.7
		SightingTime=0.750000		
		MagAmmo=5
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}