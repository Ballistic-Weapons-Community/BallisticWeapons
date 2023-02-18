class AH250WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
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
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
			Recoil=2048.000000
			Chaos=-1.0
			Inaccuracy=(X=4,Y=4)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.550000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams_Compensated
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.600000
		YRandFactor=0.900000
		MaxRecoil=7168.000000
		DeclineTime=1.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.550000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		MaxRecoil=8192.000000
		DeclineTime=0.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=ClassicAimParams_Compensated //heavy pistol handling
		AimSpread=(Min=128,Max=2900) //comp
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		JumpChaos=0.300000 //comp
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000 //comp
		ChaosSpeedThreshold=950.000000
		//ChaosSpeedThreshold=1400.000000
	End Object
	
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=96,Max=2900)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		JumpChaos=0.250000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=950.000000
		//ChaosDeclineTime=0.500000
		//ChaosSpeedThreshold=1400.000000
	End Object
    
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=70.000000,Y=-7.350000,Z=45.400000)
		ViewOffset=(X=0.000000,Y=19.500000,Z=-30.000000)
		ZoomType=ZT_Fixed
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_Compensated'
		AimParams(0)=AimParams'ClassicAimParams_Compensated'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Layouts(0)=WeaponParams'ClassicParams'
}