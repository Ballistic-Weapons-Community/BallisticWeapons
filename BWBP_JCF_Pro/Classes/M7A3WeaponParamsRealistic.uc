class M7A3WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//7.62mm
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=10000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=1500.0,Max=8500.0)
		RangeAtten=0.1
		Damage=60.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-HFire4',Volume=1.4,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=975.000000
		Chaos=0.100000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.13
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//5.7mm
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_57mm
		TraceRange=(Min=4000.000000Max=4000.000000)
		WaterTraceRange=750.0
		DecayRange=(Min=750.0,Max=3750.0)
		RangeAtten=0.1
		Damage=25.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.M7A3.M7A3-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.100000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_57mm
		AimedFireAnim="SightFire"
		FireInterval=0.08
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_57mm'
	End Object
	
	//5.7mm Supp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_57mmSupp
		TraceRange=(Min=4000.000000Max=4000.000000)
		WaterTraceRange=750.0
		DecayRange=(Min=750.0,Max=3750.0)
		RangeAtten=0.1
		Damage=25.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.300000 //
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.P90.P90SilFire',Radius=64.000000,bAtten=True,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=180.000000 //
		Chaos=0.120000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_57mmSupp
		AimedFireAnim="SightFire"
		FireInterval=0.09 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_57mmSupp'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.M7A3TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="DartFireSingle"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.200000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.450000)))
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=4000
		DeclineTime=0.700000
		DeclineDelay=0.20000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.200000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.450000)))
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=4000
		DeclineTime=0.700000
		DeclineDelay=0.20000
		ViewBindFactor=1.000000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=620,Max=1336)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout Core
		LayoutName="Holosight"
		WeaponPrice=2500
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-10.000000,Y=-0.45000,Z=10.720000)
		SightMoveSpeedFactor=0.5
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=7
		MagAmmo=20
		ViewOffset=(X=9.000000,Y=3.00000,Z=-8.000000)
		ReloadAnimRate=1.400000
		CockAnimRate=1.000000
		WeaponName="M7A3 7.62mm Bullpup Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Scope
		//Layout Core
		LayoutName="3X Scope"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=1f)
		ScopeViewTex=Texture'BWBP_SKC_Tex.MG36.G36ScopeViewDot'
		//ADS
		SightOffset=(X=0.000000,Y=-0.45000,Z=11.300000)
		SightMoveSpeedFactor=0.5
		SightingTime=0.3
		MaxZoom=3
		ZoomType=ZT_Fixed
		//Function
		InventorySize=7
		MagAmmo=20
		ViewOffset=(X=9.000000,Y=3.00000,Z=-8.000000)
		ReloadAnimRate=1.400000
		CockAnimRate=1.000000
		WeaponName="M7A3 7.62mm Bullpup Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_57mm
		//Layout Core
		LayoutName="5.7mm M7B2"
		WeaponPrice=2000
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-10.000000,Y=-0.45000,Z=10.720000)
		SightMoveSpeedFactor=0.5
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=7
		MagAmmo=50
		ViewOffset=(X=9.000000,Y=3.00000,Z=-8.000000)
		ReloadAnimRate=1.400000
		CockAnimRate=1.000000
		WeaponName="M7B2 5.7mm Bullpup Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_57mm'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_57mmSupp
		//Layout Core
		LayoutName="5.7mm M7B2 Supp"
		WeaponPrice=2300
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",AugmentOffset=(x=-5,y=0,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-10.000000,Y=-0.45000,Z=10.720000)
		SightMoveSpeedFactor=0.5
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=7
		MagAmmo=50
		ViewOffset=(X=9.000000,Y=3.00000,Z=-8.000000)
		ReloadAnimRate=1.400000
		CockAnimRate=1.000000
		WeaponName="M7B2 5.7mm Bullpup Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_57mmSupp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Scope'
	Layouts(2)=WeaponParams'RealisticParams_57mm'
	Layouts(3)=WeaponParams'RealisticParams_57mmSupp'


}