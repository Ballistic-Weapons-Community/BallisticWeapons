class AM67WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1000.000000,Max=5000.000000) //.50
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=62.0
		HeadMult=2.129032
		LimbMult=0.629032
		DamageType=Class'BallisticProV55.DTAM67Pistol'
		DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
		PenetrationEnergy=12.000000
		PenetrateForce=40
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.900000
		FireSound=(sound=sound'BW_Core_WeaponSound.AM67.AM67-Fire',Pitch=1.100000,Volume=1.400000)
		Recoil=1024.000000
		Chaos=0.090000
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.270000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.750000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
			FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=4.000000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="SecFire"
			FireEndAnim=
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.40000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3072.000000
		DeclineTime=0.600000
		DeclineDelay=0.175000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1152)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		ViewOffset=(X=9.000000,Y=7.000000,Z=-7.000000)
		SightOffset=(X=-12.000000,Y=-1.1750000,Z=14.150000)
		SightPivot=(Pitch=-160,Roll=-465)
		bAdjustHands=true
		RootAdjust=(Yaw=-280,Pitch=2500)
		WristAdjust=(Yaw=-2500,Pitch=-000)
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		InitialWeaponMode=0
		WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponModes(1)=(bUnavailable=true)
		WeaponModes(2)=(bUnavailable=true)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}