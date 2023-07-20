class RS8X3WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Semi
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTRS8X3PistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=2048.000000
		Chaos=0.015000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParamsBurst
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTRS8X3PistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTRS8X3Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=256.000000
		Chaos=0.200000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsBurst
		FireInterval=0.070000
		BurstFireRateFactor=1.00
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParamsBurst'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
			SpreadMode=FSM_Rectangle
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=RealisticSecondaryFireParams
			FireInterval=0.700000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParamsBurst
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=48,Max=8192)
		AimAdjustTime=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=11200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=14
		SightOffset=(X=-15.000000,Y=-0.900000,Z=13.200000)
		SightPivot=(Pitch=768,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticRecoilParamsBurst'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}