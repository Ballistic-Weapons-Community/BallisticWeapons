class SawnOffWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryShotEffectParams
		TraceRange=(Min=1200.000000,Max=1500.000000)
		RangeAtten=0.130000
		TraceCount=24
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSawnOff'
		Damage=20
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.500000
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=2500,Y=1800)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireShotParams
		FireInterval=0.150000
		AmmoPerFire=2
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryShotEffectParams'
	End Object

	Begin Object Class=ShotgunEffectParams Name=ClassicPrimarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=2
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSawnOff'
        HeadMult=1.5f
        LimbMult=0.8f
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

	Begin Object Class=FireParams Name=ClassicPrimaryFireSlugParams
		FireInterval=0.150000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimarySlugEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryShotEffectParams
		TraceRange=(Min=1200.000000,Max=1500.000000)
		RangeAtten=0.130000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSawnOff'
		Damage=20
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.500000
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1800,Y=1800)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.500000)	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireShotParams
		FireInterval=0.150000
		AmmoPerFire=1
		MaxHoldTime=0.0
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryShotEffectParams'
	End Object

	Begin Object Class=ShotgunEffectParams Name=ClassicSecondarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSawnOff'
        HeadMult=1.5f
        LimbMult=0.8f
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireSlugParams
		FireInterval=0.150000
		MaxHoldTime=0.0
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondarySlugEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=0.900000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=13,Scale=0f)
		SightOffset=(X=-40.000000,Y=11.150000,Z=29.000000)
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=10
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireShotParams'
		FireParams(1)=FireParams'ClassicPrimaryFireSlugParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireShotParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireSlugParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}