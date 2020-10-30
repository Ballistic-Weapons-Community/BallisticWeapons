class R9WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		CrouchMultiplier=0.750000
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.070000),(InVal=0.500000,OutVal=0.040000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.500000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.300000
		YRandFactor=0.200000
		MinRandFactor=0.500000
		DeclineDelay=0.350000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosSpeedThreshold=3000.000000
		AimSpread=(Min=64,Max=3072)
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.4
		MagAmmo=15
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}