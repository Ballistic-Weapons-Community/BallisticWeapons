class HVCMk9WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.200000
		YRandFactor=0.200000
		DeclineTime=1.000000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-500,Yaw=-1024)
		AimAdjustTime=0.400000
		AimSpread=(Min=2,Max=2)
		ChaosSpeedThreshold=600.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        InventorySize=35
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}