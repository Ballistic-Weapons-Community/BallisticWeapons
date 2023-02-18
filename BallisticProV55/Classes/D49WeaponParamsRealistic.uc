class D49WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=6000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=87.0
		HeadMult=2.356321
		LimbMult=0.586206
		DamageType=Class'BallisticProV55.DTD49Revolver'
		DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
		PenetrationEnergy=14.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-FireSingle',Pitch=1.100000,Volume=1.100000)
		Recoil=1280.000000
		Chaos=0.120000
		Inaccuracy=(X=6,Y=6)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireSingle"
		FireEndAnim=
		FireAnimRate=1.800000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=1200.000000,Max=6000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=87.0
		HeadMult=2.3f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTD49Revolver'
		DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
		PenetrationEnergy=14.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Fire',Volume=1.300000)
		Recoil=1920.000000
		Chaos=0.200000
		Inaccuracy=(X=6,Y=6)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.750000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3072.000000
		DeclineTime=0.700000
		DeclineDelay=0.200000
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
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=675.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=6
		WeaponPrice=1800
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15
		MagAmmo=6
		ViewOffset=(X=4.000000,Y=10.500000,Z=-13.000000)
		ViewPivot=(Pitch=512)
		SightOffset=(X=-20.000000,Y=-3.500000,Z=23.9500000)
		SightPivot=(Pitch=-175,Roll=-500)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=2000)
		WristAdjust=(Yaw=-2500,Pitch=-0000)
		ReloadAnimRate=1.700000
		CockAnimRate=1.000000
		WeaponName="D49 .44 Magnum Revolver"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}