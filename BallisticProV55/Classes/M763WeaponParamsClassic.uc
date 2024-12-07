class M763WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		LimbMult=0.24
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=700,Y=450)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		FireAnim="FireClassic"
		AimedFireAnim="FireClassic"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Slug
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Slug
		TraceRange=(Min=6000.000000,Max=6000.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=110.0
		HeadMult=1.7
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire2',Volume=1.600000)
		Recoil=768.000000 //x1.5
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Slug
		FireInterval=0.800000
		FireAnim="FireClassic"
		AimedFireAnim="FireClassic"
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Slug'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================
	
	//Gas Slug
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Slug
		ProjectileClass=Class'BallisticProV55.M763GasSlug'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=3600.000000
		MaxSpeed=1000000.000000
		AccelSpeed=1200.000000
		Damage=100.000000
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
		Recoil=450.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Slug
		TargetState="GasSlug"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Slug'
	End Object
	
	//Gas Spray
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams_Spray
		TraceRange=(Min=768.000000,Max=768.000000)
		RangeAtten=0.250000
		Damage=35
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrateForce=100
		bPenetrate=True
		FlashScaleFactor=2.000000
		Recoil=1280.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Spray
		TargetState="GasSpray"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams_Spray'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Buckshot"
		Weight=30
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Spray'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Slug
		LayoutName="Slug"
		LayoutTags="slug"
		Weight=5
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		//SightPivot=(Pitch=128)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Slug'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Slug'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Slug'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M763_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_OD
		Index=1
		CamoName="Olive Drab"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M763-KShotgunShiney",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M763-KSmallShiney",Index=2,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_Wood
		Index=2
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781_LargeShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781_SmallShine",Index=2,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M763_Trusty
		Index=3
		CamoName="Ol' Trusty"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781-OldTrusty",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M763Camos.M781Small",Index=2,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'M763_Gray'
	Camos(1)=WeaponCamo'M763_OD'
	Camos(2)=WeaponCamo'M763_Wood'
	Camos(3)=WeaponCamo'M763_Trusty'
}