class AH104PistolWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		WaterTraceRange=3250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.350000
		Damage=100
		HeadMult=1.47
		DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=250
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=1.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=5.100000)
		Recoil=4096.000000
		Chaos=10.000000
		Inaccuracy=(X=3,Y=3)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		PushbackForce=170.000000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		BurstFireRateFactor=1.00
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnim="FireBig"
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
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
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.450000
		YRandFactor=0.450000
		MaxRecoil=5000.000000
		DeclineTime=1.000000
		DeclineDelay=0.050000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=40,Max=1024)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=1250.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
        InventorySize=8
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		SightOffset=(X=-30.000000,Y=-0.700000,Z=22.600000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}