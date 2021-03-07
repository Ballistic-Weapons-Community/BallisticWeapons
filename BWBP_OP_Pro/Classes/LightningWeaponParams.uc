class LightningWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.500000
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.300000
		DeclineDelay=1.000000
		DeclineTime=0.800000
		CrouchMultiplier=0.6
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=192,Max=1024)
		ADSMultiplier=0.35
		AimAdjustTime=0.750000
		ChaosSpeedThreshold=600.000000
		ChaosDeclineTime=0.750000
		SprintOffset=(Pitch=-8192,Yaw=-12288)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.950000
		PlayerJumpFactor=0.950000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.450000
		DisplaceDurationMult=1.25
		MagAmmo=8
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}