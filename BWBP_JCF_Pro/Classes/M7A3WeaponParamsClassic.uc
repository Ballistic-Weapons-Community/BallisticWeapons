class M7A3WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//7.62mm
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=35.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=60.000000
		PenetrateForce=450
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M7A3.M7A3-HFire4',Volume=1.4,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.040000
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//5.7mm
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_57mm
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=21.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=60.000000
		PenetrateForce=450
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_JCF_Pro.M7A3FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.M7A3.M7A3-Fire',Volume=1.4,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=80.000000
		Chaos=0.040000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_57mm
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_57mm'
	End Object
	
	//5.7mm Suppressed
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_57mmSupp
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=21.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM7A3RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM7A3Rifle'
		PenetrationEnergy=60.000000
		PenetrateForce=450
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.300000 //
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.P90.P90SilFire',Radius=64.000000,bAtten=True,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=70.000000 //
		Chaos=0.080000 //
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_57mmSupp
		FireInterval=0.090000 //lil slower
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_57mmSupp'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.M7A3TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="DartFireSingle"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	//7.62
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.10000),(InVal=0.150000,OutVal=0.20000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3840.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//5.7
	Begin Object Class=RecoilParams Name=ClassicRecoilParams_57mm
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=-0.500000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.04000),(InVal=0.150000,OutVal=0.10000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=4800.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		AimAdjustTime=0.3500000
		CrouchMultiplier=0.900000
		ADSMultiplier=0.700000
		ViewBindFactor=0.50000
		SprintChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout Core
		LayoutName="Holosight"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=20
		ViewOffset=(X=8,Y=4,Z=-8)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout Core
		LayoutName="Short Scope"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=1f)
		ScopeViewTex=Texture'BWBP_SKC_Tex.MG36.G36ScopeViewDot'
		//ADS
		SightOffset=(X=0.000000,Y=-0.45000,Z=11.300000)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MaxZoom=3
		ZoomType=ZT_Fixed
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=20
		ViewOffset=(X=8,Y=4,Z=-8)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_57mm
		//Layout Core
		LayoutName="5.7mm M7B2"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=50
		ViewOffset=(X=8,Y=4,Z=-8)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_57mm'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_57mm'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_57mmSupp
		//Layout Core
		LayoutName="5.7mm M7B2 Supp"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=14,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=16,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",AugmentOffset=(x=-5,y=0,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightOffset=(X=-3.000000,Y=-0.440000,Z=10.70000)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		ZoomType=ZT_Irons
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=50
		ViewOffset=(X=8,Y=4,Z=-8)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_57mm'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_57mmSupp'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Scope'
	Layouts(2)=WeaponParams'ClassicParams_57mm'
	Layouts(3)=WeaponParams'ClassicParams_57mmSupp'
}
