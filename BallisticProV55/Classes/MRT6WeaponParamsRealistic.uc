class MRT6WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=500.000000,Max=2500.000000)
		WaterTraceRange=5000.0
		TraceCount=20
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMRT6Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Fire')
		Recoil=4096.000000
		Chaos=0.800000
		Inaccuracy=(X=1600,Y=1200)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnimRate=0.600000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=500.000000,Max=2500.000000)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTMRT6Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6SingleFire')
		Recoil=2048.000000
		Chaos=0.500000
		Inaccuracy=(X=1200,Y=1200)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnim="FireRight"
		FireAnimRate=1.000000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.350000
		YRandFactor=0.350000
		DeclineTime=0.800000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.900000
		ADSMultiplier=0.900000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		JumpOffSet=(Pitch=2048,Yaw=-512)
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
        InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.225000
		MagAmmo=6
		ViewOffset=(X=9.000000,Y=5.000000,Z=-8.500000)
		SightOffset=(X=-20.000000,Z=7.200000)
		SightPivot=(Pitch=64)
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		WeaponName="MRT6 12ga Shotgun Sidearm"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}