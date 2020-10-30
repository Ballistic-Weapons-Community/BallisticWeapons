class M50WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		CrouchMultiplier=0.750000
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineDelay=0.140000     
		DeclineTime=0.5
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.200000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=16,Max=728)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=5000.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        SightingTime=0.35
        MagAmmo=30
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}