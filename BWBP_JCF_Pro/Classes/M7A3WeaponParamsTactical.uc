class M7A3WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//7.62mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=55 // 7.62 NATO
        HeadMult=3
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
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-HFire4',Volume=1.4,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=750.000000
		Chaos=0.1
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.13
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//5.7mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_57mm
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
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.M7A3.M7A3-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=96.000000
		Chaos=0
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_57mm
		FireInterval=0.08
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_57mm'
	End Object
	
	//5.7mm Supp
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_57mmSupp
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
		Inaccuracy=(X=28,Y=28) //
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.300000 //
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.P90.P90SilFire',Radius=64.000000,bAtten=True,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=80.000000 //
		Chaos=0
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_57mmSupp
		FireInterval=0.09 //
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_57mmSupp'
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

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.2
		ADSViewBindFactor=1.0
		EscapeMultiplier=1.0
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
		AimSpread=(Min=256,Max=1024) //better control than SRS
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		ADSViewBindFactor=1
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
		//Layout Core
		LayoutName="Holosight"
		WeaponPrice=2500
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		ZoomType=ZT_Irons
		//ADS
		SightOffset=(X=-3.00,Y=-0.44,Z=10.70)
		SightingTime=0.32
		SightMoveSpeedFactor=0.45
		//Function
		MagAmmo=20
        InventorySize=6
		ViewOffset=(X=6.00,Y=3.00,Z=-8.00)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout Core
		LayoutName="3X Scope"
		WeaponPrice=3000
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.00,Y=-0.44,Z=10.70)
		SightingTime=0.4
		SightMoveSpeedFactor=0.35
		MaxZoom=3
		ZoomType=ZT_Fixed
		//Function
		MagAmmo=20
        InventorySize=6
		ViewOffset=(X=6.00,Y=3.00,Z=-8.00)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
		AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_57mm
		//Layout Core
		LayoutName="5.7mm M7B2"
		WeaponPrice=2500
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.00,Y=-0.44,Z=10.70)
		SightingTime=0.32
		SightMoveSpeedFactor=0.45
		ZoomType=ZT_Irons
		//Function
		MagAmmo=50
        InventorySize=6
		ViewOffset=(X=6.00,Y=3.00,Z=-8.00)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_57mm'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_57mmSupp
		//Layout Core
		LayoutName="5.7mm M7B2 Supp"
		WeaponPrice=2500
		Weight=30
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",AugmentOffset=(x=-5,y=0,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.00,Y=-0.44,Z=10.70)
		SightingTime=0.32
		SightMoveSpeedFactor=0.45
		ZoomType=ZT_Irons
		//Function
		MagAmmo=50
        InventorySize=6
		ViewOffset=(X=6.00,Y=3.00,Z=-8.00)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_57mmSupp'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams'
	Layouts(1)=WeaponParams'TacticalParams_Scope'
	Layouts(2)=WeaponParams'TacticalParams_57mm'
	Layouts(3)=WeaponParams'TacticalParams_57mmSupp'
}