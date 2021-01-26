class SRXWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0100
		YRandFactor=0.0100
		MaxRecoil=3072.000000
		DeclineTime=0.30000
	End Object

	Begin Object Class=RecoilParams Name=ArenaExplosiveRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0300
		YRandFactor=0.0300
		MaxRecoil=8192.000000
		DeclineTime=1.20000
		DeclineDelay=0.600000
	End Object

	Begin Object Class=RecoilParams Name=ArenaAcidRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0200
		YRandFactor=0.0200
		DeclineTime=0.60000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=16,Max=192)
		ChaosDeclineTime=0.75
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=20
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaAcidRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}