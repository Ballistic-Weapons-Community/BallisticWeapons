class AH104PistolWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=6000.000000) //.60 armor piercing
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.350000
		Damage=100
		HeadMult=2.3f
		LimbMult=0.6f
		DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		PenetrationEnergy=24.000000
		PenetrateForce=70
		bPenetrate=True
		PDamageFactor=0.7
		WallPDamageFactor=0.5
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=1.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=7.100000)
		Recoil=4096.000000
		Chaos=0.200000
		Inaccuracy=(X=16,Y=16)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		PushbackForce=170.000000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		BurstFireRateFactor=1.00
		FireInterval=1.1
		PreFireAnimRate=0.800000	
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnim="FireBig"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.600000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.01
		Chaos=0.05
		Damage=14.000000
		HeadMult=1.0f
		LimbMult=1.0f
		//DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		//DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		//DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		Inaccuracy=(X=0,Y=0)
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.40000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3572.000000
		DeclineTime=0.900000
		DeclineDelay=0.100000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=706,Max=1452)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=575.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
        InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=7
		bMagPlusOne=True
		SightOffset=(X=-30.000000,Y=-0.700000,Z=22.600000)
		ViewOffset=(X=8,Y=8,Z=-18)
		WeaponName="AH104 .600 Handcannon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}