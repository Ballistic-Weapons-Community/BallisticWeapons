class M806WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000)  //.45
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=47.0
		HeadMult=2.276595
		LimbMult=0.617021
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=30
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000) //Custom Sound
		Recoil=800.000000
		Chaos=0.080000
		Inaccuracy=(X=15,Y=15)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.210000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=2.750000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.550000
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1536.000000
		DeclineTime=0.400000
		DeclineDelay=0.1250000
		ViewBindFactor=0.30000
		ADSViewBindFactor=0.30000
		HipMultiplier=1.000000
		CrouchMultiplier=0.820000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=750.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.13
		MagAmmo=12
		bMagPlusOne=True
		ViewOffset=(X=4.000000,Y=6.000000,Z=-6.000000)
		SightOffset=(X=-5.000000,Y=-1.315,Z=12.600000)
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.400000
		WeaponName="M806 .45 Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}