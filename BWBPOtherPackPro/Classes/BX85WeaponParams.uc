class BX85WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=4096.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.4
		JumpChaos=0.200000
		AimAdjustTime=0.450000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.400000
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}