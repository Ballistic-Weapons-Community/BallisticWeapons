class MRT6WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=1500.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=24
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		LimbMult=0.24
		DamageType=Class'BallisticProV55.DTMRT6Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Fire')
		Recoil=4096.000000
		Chaos=0.800000
		PushbackForce=1200.000000
		Inaccuracy=(X=3000,Y=1500)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		bCockAfterFire=True	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1200.000000,Max=1500.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		HeadMult=1.5
		LimbMult=0.25
		DamageType=Class'BallisticProV55.DTMRT6Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6SingleFire')
		Recoil=2048.000000
		Chaos=0.500000
		PushbackForce=600.000000
		Inaccuracy=(X=1500,Y=1000)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnim="FireRight"	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=0.700000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		JumpChaos=1.000000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
        InventorySize=4
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		//ViewOffset=(X=12.000000,Y=8.000000,Z=-8.500000)
		SightOffset=(X=-30.000000,Z=11.000000)
		SightPivot=(Pitch=768)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}