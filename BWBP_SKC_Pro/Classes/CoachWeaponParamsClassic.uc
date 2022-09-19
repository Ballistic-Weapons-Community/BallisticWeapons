class CoachWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.400000
		Damage=30
		TraceCount=10
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachShot'
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-FireDouble',Volume=1.200000)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=800,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		AmmoPerFire=2
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=2
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=125
		DamageType=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=2
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimarySlugEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.400000
		Damage=30
		TraceCount=10
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachShot'
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=800,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireInterval=0.150000
		AmmoPerFire=1
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		MaxHits=14
		Damage=125
		DamageType=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=5.100000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=1
		MaxHoldTime=0.0
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondarySlugEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=9192.000000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.850000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=768)
		CrouchMultiplier=0.850000
		ADSMultiplier=0.650000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=2
		ViewOffset=(X=-20.000000,Y=20.000000,Z=-40.000000)
		SightOffset=(X=-40.000000,Y=12.000000,Z=40.000000)
		SightPivot=(Pitch=256)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireSlugParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireSlugParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}