class RS8WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.500000
		DeclineDelay=0.250000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.33
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
		MagAmmo=9
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}