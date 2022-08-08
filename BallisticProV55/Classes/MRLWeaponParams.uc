class MRLWeaponParams extends BallisticWeaponParams;

defaultproperties
{
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.000000
		YRandFactor=0.000000
 	End Object
	 
	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.25
		SprintOffSet=(Pitch=-7000,Yaw=-3000)
		OffsetAdjustTime=0.600000
		AimSpread=(Min=128,Max=2048)
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=500.000000
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(X=12.000000,Y=9.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-512,Roll=1024)
		PlayerSpeedFactor=0.8
		PlayerJumpFactor=0.8
        DisplaceDurationMult=1.4
		SightingTime=0.65
		MagAmmo=36
        InventorySize=35
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}