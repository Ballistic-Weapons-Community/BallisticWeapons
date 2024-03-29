class MRDRWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=900.000000,Max=4800.000000) //9mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.10000
		Damage=30.0
		HeadMult=2.6
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		PenetrationEnergy=11.000000
		PenetrateForce=15
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire',Pitch=1.250000,Volume=1.100000)
		Recoil=720.000000
		Chaos=0.000000
		Inaccuracy=(X=10,Y=10)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.066666
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35
		HeadMult=2.428571
		LimbMult=0.714285
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88SpikeHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee1"
		FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.200000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.300000
		XRandFactor=0.600000
		YRandFactor=0.600000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.100000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=1280)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		ViewBindFactor=0.0500000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
        InventorySize=4
		WeaponPrice=1100
		SightMoveSpeedFactor=0.500000
		SightingTime=0.160000
		MagAmmo=60
		bMagPlusOne=True
		SightOffset=(X=20.000000,Y=3.000000,Z=2.800000)
		SightPivot=(Pitch=-2300,Roll=800,Yaw=0)
		bAdjustHands=true
		RootAdjust=(Pitch=2000,Yaw=50)
		WristAdjust=(Yaw=0)
		//RootAdjust=(Pitch=1000,Yaw=-50)
		//WristAdjust=(Yaw=-2500)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=4.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=0.850000
		//CockAnimRate=1.200000
		WeaponName="MR-DR88 9mm Wrist Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}