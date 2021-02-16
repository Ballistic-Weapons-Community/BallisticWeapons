class MRS138WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.3,OutVal=0.2),(InVal=0.55,OutVal=0.1),(InVal=0.8,OutVal=0.25),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.2,OutVal=0.2),(InVal=0.4,OutVal=0.45),(InVal=0.75,OutVal=0.7),(InVal=1.000000,OutVal=1)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.650000
		DeclineTime=0.5
		HipMultiplier=1
    End Object
	
	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		ChaosSpeedThreshold=1200.000000
		ChaosDeclineTime=0.750000
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.3
		MagAmmo=6
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}