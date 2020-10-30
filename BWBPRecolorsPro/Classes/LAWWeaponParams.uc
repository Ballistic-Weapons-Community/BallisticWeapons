class LAWWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		YawFactor=0.000000
		DeclineTime=1.000000
		DeclineDelay=0.000000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=512,Max=1536)
		ADSMultiplier=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-7000)
		AimAdjustTime=0.750000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=1200.00000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=1
		InventorySize=35
		SightMoveSpeedFactor=0.8
		SightingTime=0.60000		
		DisplaceDurationMult=1.25
		MagAmmo=1
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}