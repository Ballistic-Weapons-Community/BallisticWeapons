class SawnOffWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryShotEffectParams
		TraceRange=(Min=500.000000,Max=2500.000000)
		TraceCount=20
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		Damage=20
		HeadMult=2.15
		LimbMult=0.6
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1500,Y=1000)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireShotParams
		FireInterval=0.300000
		AmmoPerFire=2
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryShotEffectParams'
	End Object

	// Slug
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=2
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=100.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=1024,Y=1024)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireSlugParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimarySlugEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryShotEffectParams
		TraceRange=(Min=500.000000,Max=2500.000000)
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		Damage=20
		HeadMult=2.15
		LimbMult=0.6
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1000,Y=1000)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.400000)	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireShotParams
		FireInterval=0.100000
		AmmoPerFire=1
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryShotEffectParams'
	End Object

	// Slug
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=2048.000000
		Chaos=100.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=1024,Y=1024)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireSlugParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondarySlugEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		DeclineTime=0.900000
		DeclineDelay=0.400000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.900000
		ADSMultiplier=0.900000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=13,Scale=0f)
		//SightOffset=(X=-40.000000,Y=11.150000,Z=29.000000)
		//ViewOffset=(X=-15,Y=5,Z=-30)
		SightingTime=0.22
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=10
		SightMoveSpeedFactor=0.9
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireShotParams'
		FireParams(1)=FireParams'RealisticPrimaryFireSlugParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireShotParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireSlugParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}