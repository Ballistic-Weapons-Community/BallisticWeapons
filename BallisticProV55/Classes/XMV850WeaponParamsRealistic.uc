class XMV850WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1600.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=45.0
		HeadMult=2.266666
		LimbMult=0.666666
		DamageType=Class'BallisticProV55.DTXMV850MG'
		DamageTypeHead=Class'BallisticProV55.DTXMV850MGHead'
		DamageTypeArm=Class'BallisticProV55.DTXMV850MG'
		PenetrationEnergy=18.000000
		PenetrateForce=65
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		Chaos=-0.010000
		Inaccuracy=(X=9,Y=9)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.050000
		BurstFireRateFactor=1.00	
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
		FireInterval=1.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.05000,OutVal=-0.200000),(InVal=0.20000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.350000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.500000),(InVal=0.8500000,OutVal=0.650000),(InVal=1.000000,OutVal=0.700000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.050000),(InVal=0.475000,OutVal=0.250000),(InVal=0.575000,OutVal=0.500000),(InVal=0.675000,OutVal=0.400000),(InVal=0.825000,OutVal=0.500000),(InVal=1.000000,OutVal=0.350000)))
		PitchFactor=0.450000
		YawFactor=0.450000
		XRandFactor=0.1250000
		YRandFactor=0.12500000
		MaxRecoil=4800.000000
		DeclineTime=0.800000
		DeclineDelay=0.250000
		ViewBindFactor=0.750000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=1536,Max=3584)
		AimAdjustTime=0.600000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.900000
		ViewBindFactor=0.100000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-3000,Yaw=-7000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.500000
		AimDamageThreshold=375.000000
		ChaosDeclineTime=1.650000
		ChaosSpeedThreshold=350
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.700000
		PlayerJumpFactor=0.750000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		SightingTime=0.4
		MagAmmo=900
		ViewOffset=(X=7.000000,Y=6.000000,Z=-18.000000)
		SightOffset=(X=8.000000,Z=28.000000)
		SightPivot=(Pitch=700,Roll=2048)
		WeaponModes(0)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="2400 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(ModeName="3600 RPM",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=0.800000
		CockAnimRate=1.000000
		WeaponName="XMV-858 5.56mm Minigun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}