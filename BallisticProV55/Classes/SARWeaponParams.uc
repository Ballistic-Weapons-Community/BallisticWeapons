class SARWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaAutoEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=20
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.022000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaAutoFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaAutoEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaBurstEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=20
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=128.000000
		Chaos=0.030000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaBurstFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaBurstEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.500000
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.35
		CrouchMultiplier=0.75
		DeclineDelay=0.14
	End Object

	Begin Object Class=RecoilParams Name=ArenaBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.45
		CrouchMultiplier=1
		DeclineDelay=0.14
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.300000
		AimSpread=(Min=12,Max=768)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=15000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=32
        InventorySize=12
        SightingTime=0.250000
        RecoilParams(0)=RecoilParams'ArenaAutoRecoilParams'
        RecoilParams(1)=RecoilParams'ArenaBurstRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
		FireParams(1)=FireParams'ArenaBurstFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}