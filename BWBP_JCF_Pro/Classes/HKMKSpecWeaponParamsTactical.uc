class HKMKSpecWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.5
		Damage=28 // .45
		HeadMult=3.5
		LimbMult=0.75
		PenetrationEnergy=16
		DamageType=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMKSpecPistolHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMKSpecPistol'
		PenetrateForce=135
		bPenetrate=True
		Inaccuracy=(X=128,Y=128)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=256.000000
		Chaos=0.250000
		BotRefireRate=0.750000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.MK23.MkFire_1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.210000
		FireEndAnim=
		AimedFireAnim='SightFire'
		FireAnimRate=1.8	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000)
        DecayRange=(Min=525,Max=1838)
        RangeAtten=0.2
        TraceCount=10
		Damage=8
		HeadMult=1.75
        LimbMult=0.85
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_JCF_Pro.DTHKMKSpecPistolAlt'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTHKMKSpecPistolHeadAlt'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTHKMKSpecPistolAlt'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireAlt"
		AimedFireAnim='FireAlt'
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.05
		DeclineDelay=0.200000
		DeclineTime=0.500000
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
    	AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ChaosDeclineTime=0.400000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		DisplaceDurationMult=0.33
		SightMoveSpeedFactor=0.6
		SightingTime=0.20
		MagAmmo=8
        InventorySize=4
		bDualBlocked=True
		SightPivot=(Pitch=-70)
		SightOffset=(X=0.000000,Y=-4.300000,Z=11.600000)
		//ViewOffset=(X=-2.000000,Y=7.000000,Z=-11.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}