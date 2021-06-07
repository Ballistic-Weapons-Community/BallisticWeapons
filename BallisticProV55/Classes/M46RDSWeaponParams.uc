class M46RDSWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.080000,OutVal=0.050000),(InVal=0.110000,OutVal=0.080000),(InVal=0.150000,OutVal=0.14000),(InVal=0.300000,OutVal=0.2300000),(InVal=0.450000,OutVal=0.2500000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.380000),(InVal=1.000000,OutVal=0.25)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineDelay=0.1700000
		DeclineTime=0.65
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.550000
		AimSpread=(Min=24,Max=256)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=500.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        SightPivot=(Pitch=600,Roll=-1024)
		SightOffset=(Y=-1.000000,Z=12.500000)
		SightingTime=0.35
        MagAmmo=24
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}