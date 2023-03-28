class HKMKSpecWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=40.0
		HeadMult=1.5
		LimbMult=0.55
		DamageType=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMKSpecPistolHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		PenetrationEnergy=24.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Typhon.Typhon-Fire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2048.000000
		Chaos=0.015000
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.25
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=6
		DamageType=Class'BWBP_JCF_Pro.DTHKMKSpecPistolAlt'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMKSpecPistolHeadAlt'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMKSpecPistolAlt'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireAlt"
		AimedFireAnim='FireAlt'
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.050000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=1024)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.400000
		SprintChaos=0.400000
		ChaosDeclineTime=0.300000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		bDualBlocked=True
		PlayerSpeedFactor=1.100000
		InventorySize=2
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		bNeedCock=True
		MagAmmo=12
		SightPivot=(Pitch=-70)
		ViewOffset=(X=3.000000,Y=9.000000,Z=-10.000000)
		SightOffset=(X=-5.000000,Y=-4.300000,Z=11.600000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}