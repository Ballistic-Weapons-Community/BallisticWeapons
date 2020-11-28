//=============================================================================
// A73WeaponParams
//=============================================================================
class A73WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.5
		DeclineDelay=0.170000
 	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.300000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.600000
		AimSpread=(Min=16,Max=768)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.350000
		ChaosDeclineDelay=0.300000
		ChaosSpeedThreshold=15000.000000
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=32
	    RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}