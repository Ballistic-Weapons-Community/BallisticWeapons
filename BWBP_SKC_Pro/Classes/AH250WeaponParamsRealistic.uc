class AH250WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=80
		HeadMult=1.4375
		LimbMult=0.375
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		//FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Pitch=0.900000,Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Pitch=0.900000,Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=1.300000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Compensated
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.600000
		YRandFactor=0.900000
		YawFactor=0.200000
		MaxRecoil=7168.000000
		DeclineTime=1.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.000000)))
		YawFactor=0.400000
		XRandFactor=1
		YRandFactor=1
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object


	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=RealisticAimParams_Compensated
		AimSpread=(Min=668,Max=2900) //Comp
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000 //Comp
		ChaosSpeedThreshold=1400.000000
	End Object
    
	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=650,Max=2900)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.250000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1400.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=8
		SightOffset=(X=70.000000,Y=-7.350000,Z=45.400000)
		ViewOffset=(X=0.000000,Y=19.500000,Z=-30.000000)
		ZoomType=ZT_Fixed
		WeaponName="AH250 .44 Scoped Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Compensated'
		AimParams(0)=AimParams'RealisticAimParams_Compensated'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object

	Layouts(0)=WeaponParams'RealisticParams'
}