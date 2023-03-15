class T9CNWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.181818
		LimbMult=0.606060
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=300.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.130000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000) //9mm JHP
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.181818
		LimbMult=0.606060
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=450.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.054000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.500000
		YawFactor=0.000000
		XRandFactor=0.3500000
		YRandFactor=0.350000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.120000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//Burst
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.180000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
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
		ADSMultiplier=0.700000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=800.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=6
		WeaponPrice=1200
		SightMoveSpeedFactor=0.500000
		SightingTime=0.130000
		MagAmmo=18
		bMagPlusOne=True
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		InitialWeaponMode=1
		WeaponName="T9CN 9mm Police Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}