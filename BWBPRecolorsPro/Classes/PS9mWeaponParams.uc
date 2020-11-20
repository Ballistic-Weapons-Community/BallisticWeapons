class PS9mWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.000000),(InVal=0.50000,OutVal=0.120000),,(InVal=0.7000,OutVal=-0.010000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.4500000,OutVal=0.40000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.450000
		AimSpread=(Min=16,Max=192)
	End Object

    Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=10
		InventorySize=5
        SightingTime=0.200000
        PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Params(0)=WeaponParams'ArenaParams'
}