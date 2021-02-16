class M75WeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.18),(InVal=0.40000,OutVal=0.350000),(InVal=0.50000,OutVal=0.420000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.55),(InVal=0.800000,OutVal=0.60000),(InVal=1.000000,OutVal=0.7)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-8000,Yaw=-10000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		JumpChaos=0.800000
		AimSpread=(Min=64,Max=1536)
		ChaosDeclineTime=0.800000
		ADSMultiplier=0.5
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.850000
		SightMoveSpeedFactor=0.8
        SightingTime=0.6
        MagAmmo=5
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}