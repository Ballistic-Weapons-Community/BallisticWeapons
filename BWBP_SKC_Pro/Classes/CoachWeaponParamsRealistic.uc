class CoachWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=500.000000,Max=2700.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		TraceCount=20
		Damage=20.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachShot'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-DoubleShot',Volume=1.200000)
		Recoil=1762.000000
		Chaos=-1.0
		Inaccuracy=(X=700,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		AmmoPerFire=2
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=2
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		MaxHits=14
		Damage=115
		DamageType=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=2
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimarySlugEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.500000,OutVal=0.800000),(InVal=0.850000,OutVal=-0.500000),(InVal=1.000000,OutVal=-0.300000)))
		YawFactor=0.250000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=1762.000000
		DeclineTime=0.400000
		DeclineDelay=0.165000
		ViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1400)
		CrouchMultiplier=0.850000
		ADSMultiplier=0.650000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		ChaosDeclineTime=1.100000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=2
		ViewOffset=(X=-20.000000,Y=20.000000,Z=-40.000000)
		SightOffset=(X=-40.000000,Y=12.000000,Z=40.000000)
		SightPivot=(Pitch=256)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}