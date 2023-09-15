class MK781WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//12ga Flechette
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		WaterTraceRange=5000.0
		RangeAtten=0.45
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-Fire',Volume=1.300000)
		Recoil=768.000000
		Inaccuracy=(X=256,Y=256)
		BotRefireRate=0.800000
		WarnTargetPct=0.400000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.325000
		FireAnimRate=1.150000
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object

	//12ga Flechette - Suppressed
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimarySilEffectParams
		TraceRange=(Min=3000.000000,Max=5000.000000)
		DecayRange=(Min=788,Max=2363) // 15-45m
		WaterTraceRange=5000.0
		RangeAtten=0.45
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=16.000000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Mk781.Mk781-FireSupp',Volume=1.45,Radius=256.000000,bAtten=True)
		Recoil=512.000000
		Inaccuracy=(X=128,Y=128)
		BotRefireRate=0.800000
		WarnTargetPct=0.400000		
	End Object

	Begin Object Class=FireParams Name=TacticalPrimarySilFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.32500
		FireAnimRate=1.150000
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimarySilEffectParams'
	End Object
	
	//12ga Sabot
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_Dart
		TraceRange=(Min=9000.000000,Max=9000.000000)
		WaterTraceRange=3400.0
		DecayRange=(Min=3500.0,Max=7000.0) //70-140m
		RangeAtten=0.45
		TracerClass=Class'BallisticProV55.TraceEmitter_AP'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		TraceCount=1
		Damage=105.0
		HeadMult=2.25
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-FireDart',Volume=1.500000)
		Recoil=2048.000000 //+1280
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Dart
		AimedFireAnim="SightFire"
		FireInterval=0.325000
		FireAnimRate=1.150000
		FireEndAnim=	
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_Dart'
	End Object
	
	//12ga Sabot - Suppressed
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_DartSil
		TraceRange=(Min=9000.000000,Max=9000.000000)
		WaterTraceRange=3400.0
		DecayRange=(Min=3500.0,Max=7000.0) //70-140m
		RangeAtten=0.45
		TracerClass=Class'BallisticProV55.TraceEmitter_AP'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		TraceCount=1
		Damage=105.0
		HeadMult=2.25
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Mk781.Mk781-FireSil',Volume=2.05,Radius=386.000000,bAtten=True)
		Recoil=1500.000000 //
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_DartSil
		AimedFireAnim="SightFire"
		FireInterval=0.325000
		FireAnimRate=1.150000
		FireEndAnim=	
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_DartSil'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Zaps
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=5
        HeadMult=1
        LimbMult=1
		DamageType=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
		Recoil=768.000000
		Inaccuracy=(X=150,Y=150)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.010000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		FireEndAnim=
        AimedFireAnim="SightFire"
		TargetState="ElektroShot"
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//Electrobolt
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryBoltEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MK781PulseProjectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=4200.000000
		MaxSpeed=4200.000000
		Damage=50
		DamageRadius=768.000000
		MomentumTransfer=70000.000000
		HeadMult=1
		LimbMult=1
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire')
		Recoil=768.000000
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryBoltFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		FireEndAnim=
        AimedFireAnim="SightFire"
        TargetState="ElektroSlug"
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryBoltEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.040000),(InVal=0.400000,OutVal=0.020000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=-0.0500),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.06
		DeclineDelay=0.30000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.25
		ADSViewBindFactor=1.0 //
		EscapeMultiplier=1.0 //
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.040000),(InVal=0.400000,OutVal=0.020000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=-0.0500),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.1 //
		MaxRecoil=8192.000000
		DeclineDelay=0.35000 //
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=TacticalAimParams		
		ADSViewBindFactor=0
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		ADSViewBindFactor=1
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		Weight=10
		LayoutName="Holo + LAM"
		LayoutTags="lam,no_suppressor"
		//Attachments
		SightOffset=(X=4.20,Y=0.01,Z=6.97)
		SightPivot=(Pitch=0,Yaw=0)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Suppressed"
		LayoutTags="start_suppressed"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=-5.00,Y=0.00,Z=2.65)
		SightPivot=(Pitch=-64,Yaw=10)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		FireParams(2)=FireParams'TacticalPrimaryFireParams'
		FireParams(3)=FireParams'TacticalPrimarySilFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(3)=FireParams'TacticalSecondaryBoltFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Dart
		//Layout core
		Weight=10
		LayoutName="Supp + 3X Scope Sabot"
		LayoutTags="no_alt, slug"
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_3XScope',BoneName="tip",Scale=0.15,AugmentOffset=(x=-28,y=0,z=-0.3),AugmentRot=(Pitch=0,Roll=16384,Yaw=32678))
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
        WeaponBoneScales(1)=(BoneName="ShellHolder",Slot=8,Scale=0f)
        WeaponBoneScales(2)=(BoneName="HShells",Slot=9,Scale=0f)
		//Zoom
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=3
		//ADS
		SightMoveSpeedFactor=0.350000
		SightingTime=0.450000
		SightOffset=(X=4.00,Y=0.00,Z=8.6)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
        AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Dart'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams_RDS'
    Layouts(1)=WeaponParams'TacticalParams'
    Layouts(2)=WeaponParams'TacticalParams_Dart'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M781_Gray
		Index=0
		CamoName="Gray"
		Weight=40
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Digital
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDigital",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoDesert",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Jungle
		Index=3
		CamoName="Jungle Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoJungle",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Winter
		Index=4
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoWinter",Index=1,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Wood
		Index=5
		CamoName="Ol' Trusty"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoWood",Index=1,AIndex=1,PIndex=2)
		Weight=7
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_RedTiger
		Index=6
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoTiger",Index=1,AIndex=1,PIndex=2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M781_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M1014Camos.M1014-MainCamoGold",Index=1,AIndex=1,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M781_Gray'
	Camos(1)=WeaponCamo'M781_Digital'
	Camos(2)=WeaponCamo'M781_Desert'
	Camos(3)=WeaponCamo'M781_Jungle'
	Camos(4)=WeaponCamo'M781_Winter'
	Camos(5)=WeaponCamo'M781_Wood'
	Camos(6)=WeaponCamo'M781_RedTiger'
	Camos(7)=WeaponCamo'M781_Gold'
}