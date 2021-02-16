class XMK5WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.15,OutVal=0.08),(InVal=0.3,OutVal=0.18),(InVal=0.4,OutVal=0.22),(InVal=0.6,OutVal=0.27),(InVal=0.8,OutVal=0.28),(InVal=1.0,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.250000),(InVal=0.30000,OutVal=0.350000),(InVal=0.450000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.125000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		AimDamageThreshold=190.000000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=7500.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.000000
		MagAmmo=32
		SightingTime=0.250000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}