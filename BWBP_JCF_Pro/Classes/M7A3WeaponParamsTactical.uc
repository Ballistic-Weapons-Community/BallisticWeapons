class M7A3WeaponParamsTactical extends BallisticWeaponParams;

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
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
        PenetrationEnergy=16
		PenetrateForce=100
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-HFire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=96.000000
		Chaos=0.10000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.M7A3TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="DartFireSingle"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.03
		DeclineDelay=0.120000     
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=256,Max=1024)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		LayoutName="Standard"
		MagAmmo=21
        InventorySize=5
		ViewOffset=(X=6.000000,Y=3.000000,Z=-8.000000)
		SightingTime=0.350000
		SightMoveSpeedFactor=0.6
		SightOffset=(X=-3.000000,Y=-0.30000,Z=11.280000)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=15,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=17,Scale=1f)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
}