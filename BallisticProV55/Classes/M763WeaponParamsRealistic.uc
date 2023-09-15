class M763WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//12ga Shot
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=4800.000000,Max=4800.000000)
		WaterTraceRange=4800.0
		DecayRange=(Min=1200.0,Max=4800.0)
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		TraceCount=8
		Damage=18.0
		HeadMult=2.25
		LimbMult=0.666
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrationEnergy=7.000000
		PenetrateForce=24
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
		Recoil=920.000000
		Chaos=0.120000
		Inaccuracy=(X=300,Y=300)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.360000
		FireAnim="Fire"
		AimedFireAnim="Fire"
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.500000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//12ga Slug
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_Slug
		TraceRange=(Min=7000.000000,Max=7000.000000)
		WaterTraceRange=1200.0
		DecayRange=(Min=1200.0,Max=7000.0)
		RangeAtten=0.15
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		TraceCount=1
		Damage=150.0
		HeadMult=2.25
		LimbMult=0.666
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire2',Volume=1.600000)
		Recoil=1400.000000
		Chaos=0.120000
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Slug
		FireInterval=0.360000
		FireAnim="Fire"
		AimedFireAnim="Fire"
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.500000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_Slug'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Gas Slug
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Slug
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
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Slug
		TargetState="GasSlug"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Slug'
	End Object
	
	//Gas Spray
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams_Spray
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

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Spray
		TargetState="GasSpray"
		FireInterval=0.750000
		FireAnim="FireCombined"
		FireEndAnim=
		AimedFireAnim="FireCombinedSight"
		FireAnimRate=1.100000	
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams_Spray'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.100000)))
		YawFactor=0.100000
		XRandFactor=0.280000
		YRandFactor=0.280000
		MaxRecoil=2560.000000
		DeclineTime=0.800000
		DeclineDelay=0.190000
		ViewBindFactor=0.800000
		ADSViewBindFactor=0.800000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3072,Yaw=-3072)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		LayoutName="12ga Shot"
		Weight=30
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=8
		bMagPlusOne=True
		InitialWeaponMode=0
		WeaponModes(0)=(ModeName="Single Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=true)
		WeaponName="M763-CS 12ga Combat Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Spray'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Slug
		LayoutName="12ga Slug"
		Weight=10
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=8
		bMagPlusOne=True
		InitialWeaponMode=0
		WeaponModes(0)=(ModeName="Single Fire",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=true)
		WeaponName="M763-CS 12ga Combat Shotgun (Slug)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Slug'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Spray'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Slug'
	
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