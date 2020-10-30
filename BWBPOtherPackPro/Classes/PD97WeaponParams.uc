class PD97WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.150000
		JumpChaos=0.200000
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=6
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}