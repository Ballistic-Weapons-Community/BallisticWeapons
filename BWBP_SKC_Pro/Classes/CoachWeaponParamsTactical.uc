class CoachWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryShotEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=2100)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=15 // inflict maximum of 150 damage to a single target, before modifiers
		Damage=10
        HeadMult=1.5f
        LimbMult=0.85f
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=768.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5
		Inaccuracy=(X=220,Y=220)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireShotParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryShotEffectParams'
	End Object

	Begin Object Class=ShotgunEffectParams Name=TacticalPrimarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1500,Max=5500)
		RangeAtten=0.25
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=70
        HeadMult=2.25f
        LimbMult=0.67f
		PushbackForce=250.000000
		DamageType=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCoachSlug'
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=768.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
		Inaccuracy=(X=16,Y=0)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=2
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimarySlugEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
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

	Begin Object Class=AimParams Name=TacticalAimParams
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=0.700000
		ReloadAnimRate=1.200000
		SightOffset=(X=-40.000000,Y=12.000000,Z=40.000000)
		ViewOffset=(X=-10.000000,Y=20.000000,Z=-30.000000)
		InventorySize=4
		SightMoveSpeedFactor=0.5
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireShotParams'
		FireParams(1)=FireParams'TacticalPrimaryFireSlugParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}