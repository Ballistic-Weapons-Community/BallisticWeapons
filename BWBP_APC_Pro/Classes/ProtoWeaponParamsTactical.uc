class ProtoWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=28 // 4.77mm?
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_APC_Pro.DTProto'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProto'
        PenetrationEnergy=16
		PenetrateForce=100
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90Fire2',Pitch=1.200000,Volume=0.950000)
		Recoil=480.000000
		Chaos=-1.0
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.050000 //real fast 1100rpm
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Photon Burst
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPhotonPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		RangeAtten=0.100000
		Damage=22
		DamageType=Class'BWBP_APC_Pro.DTProtoPhoton'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoPhotonHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProtoPhoton'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.200000
		Recoil=70.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.F2000-FireAlt1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPhotonPrimaryFireParams
		FireInterval=0.085000
		PreFireAnim=
		FireEndAnim=
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=InstantEffectParams'TacticalPhotonPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_APC_Pro.DTProtoPhoton'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoPhotonHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProtoPhoton'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		BurstFireRateFactor=1.00
	FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.250000,OutVal=0.300000),(InVal=0.400000,OutVal=-0.100000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.300000
		XRandFactor=0.240000
		YRandFactor=0.240000
		MaxRecoil=3200.000000
		DeclineTime=0.550000
		DeclineDelay=0.140000
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		ClimbTime=0.02
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0 //CYLO handling
		AimSpread=(Min=256,Max=1024)
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=50
		ViewOffset=(X=20.000000,Y=10.000000,Z=-18.000000)
		//SightOffset=(X=-10.00000,Z=10.450000)
		//SightPivot=(Pitch=16)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPhotonPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}