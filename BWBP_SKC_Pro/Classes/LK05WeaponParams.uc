class LK05WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.4
		DeclineDelay=0.200000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=768)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=15000.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}