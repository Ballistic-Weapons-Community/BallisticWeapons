class FM13WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_Flame
		TraceRange=(Min=2572.000000,Max=2572.000000)
		RangeAtten=0.150000
		TraceCount=7
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		MuzzleFlashClass=Class'BWBP_OP_Pro.FM13FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
		Recoil=1792.000000
		Chaos=1.000000
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=450,Y=450)
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Flame
		FireInterval=0.750000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.000000	
		TargetState="FireFromFireControl"
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_Flame'
	End Object	
	
	//8ga shot
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=1500,Max=3750) // 30-75m
		RangeAtten=0.2
		TraceCount=14
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Shotgun'
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter_C'
		SpreadMode=FSM_Scatter
		Recoil=1836.000000
		PushbackForce=1200.000000
		Chaos=0.400000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=600,Y=600)
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-FireStrong',Volume=3.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.250000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=0.650000	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.FM13Grenade'
		Speed=3500.000000
		Damage=30
		DamageRadius=64.000000
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.750000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.400000
		YRandFactor=0.200000
		MaxRecoil=1892
		DeclineTime=0.350000
		DeclineDelay=0.250000
		CrouchMultiplier=1
		ClimbTime=0.075
		HipMultiplier=1.25
		MaxMoveMultiplier=2
		EscapeMultiplier=1.4
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Flame
		//Layout core
		LayoutName="Dragon's Breath"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
        SightingTime=0.350000
		//Stats
		ViewOffset=(X=0.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		MagAmmo=5
        InventorySize=6
		WeaponName="FM-13 Dragon's Breath Shotgun"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Flame'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="8 Gauge Shot"
		LayoutTags="8Gauge"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
        SightingTime=0.350000
		//Stats
		ViewOffset=(X=0.000000,Y=13.000000,Z=-23.000000)
		SightOffset=(X=-5.000000,Y=-0.100000,Z=27.000000)
		SightPivot=(Pitch=128)
		MagAmmo=4
        InventorySize=6
		WeaponName="FM-13 Heavy Shotgun"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Flame'
	Layouts(1)=WeaponParams'TacticalParams'


}