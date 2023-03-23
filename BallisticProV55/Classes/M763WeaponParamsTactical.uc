class M763WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1312,Max=3938)
		RangeAtten=0.15
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=13
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=768.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=200,Y=200)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.85
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		bCockAfterFire=True
		FireAnimRate=0.9	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=768.000000,Max=768.000000)
		RangeAtten=0.25
		Damage=35
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrateForce=100
		bPenetrate=True
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.5
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="GasSpray"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.5
		DeclineDelay=0.75
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=16,Max=128)
		AimAdjustTime=0.7
        ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=5.000000,Z=12.900000)
		SightPivot=(Pitch=128)
		ViewOffset=(Y=12.000000,Z=-12.000000)
		MagAmmo=6
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}