class MACWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.600000
		YRandFactor=0.900000
		MinRandFactor=0.350000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=256,Max=2048)
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=3500.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.80000
		PlayerJumpFactor=0.80000
		SightMoveSpeedFactor=0.8
		SightingTime=0.450000
		MagAmmo=5
        InventorySize=35
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}