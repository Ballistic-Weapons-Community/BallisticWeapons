class Mk781WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=6500.000000,Max=6500.000000)
        DecayRange=(Min=2200,Max=6500)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=2.25
		LimbMult=0.666
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=14.000000
		PenetrateForce=36
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-Fire',Volume=1.300000)
		Recoil=1024.000000
		Chaos=0.16
		Inaccuracy=(X=400,Y=400)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=2.000000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//Suppressed
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimarySuppressedEffectParams
		TraceRange=(Min=6500.000000,Max=6500.000000)
        DecayRange=(Min=2200,Max=6500)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=2.25
		LimbMult=0.666
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=14.000000
		PenetrateForce=36
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Mk781.Mk781-FireSupp',Volume=2.05,Radius=256.000000)
		Recoil=768.000000
		Chaos=0.16
		Inaccuracy=(X=250,Y=250)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimarySuppressedFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=2.000000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimarySuppressedEffectParams'
	End Object
	
	//12ga Sabot
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_Dart
		TraceRange=(Min=9000.000000,Max=9000.000000)
		WaterTraceRange=3400.0
		DecayRange=(Min=3400.0,Max=9000.0)
		RangeAtten=0.45
		TracerClass=Class'BallisticProV55.TraceEmitter_AP'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		TraceCount=1
		Damage=120.0
		HeadMult=2.25
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-FireDart',Volume=1.500000)
		Recoil=1400.000000
		Chaos=0.120000
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Dart
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=2.000000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_Dart'
	End Object
	
	//12ga Sabot - Suppressed
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_DartSupp
		TraceRange=(Min=9000.000000,Max=9000.000000)
		WaterTraceRange=3400.0
		DecayRange=(Min=3400.0,Max=9000.0)
		RangeAtten=0.45
		TracerClass=Class'BallisticProV55.TraceEmitter_AP'
		ImpactManager=Class'BallisticProV55.IM_BigBullet'
		TraceCount=1
		Damage=120.0
		HeadMult=2.25
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Mk781.Mk781-FireSil',Volume=2.300000,Radius=386.000000)
		Recoil=1024.000000
		Chaos=1.120000
		Inaccuracy=(X=32,Y=32)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_DartSupp
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=2.000000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_DartSupp'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=1.000000
		TraceCount=6
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=50
		HeadMult=1.5
		LimbMult=0.9
		DamageType=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_Mk781Electro'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=700,Y=750)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEndAnim=	
        TargetState="ElektroShot"
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Electrobolt
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryBoltEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MK781PulseProjectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=20000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		Damage=150.000000
		DamageRadius=350.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Autolaser.AutoLaser-Fire')
		Recoil=512.000000
		Chaos=0.15
		Inaccuracy=(X=32,Y=32)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryBoltFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
        TargetState="ElektroSlug"
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryBoltEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.100000)))
		YawFactor=0.120000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=3260.000000
		DeclineTime=0.850000
		DeclineDelay=0.150000
		ViewBindFactor=0.750000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1250)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.700000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Suppressed"
		LayoutTags="start_suppressed"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=-5.00,Y=0.00,Z=2.65)
		SightPivot=(Pitch=-64,Yaw=10)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=9
		bMagPlusOne=False //Animation actually accounts for this, magAmmo is +1 instead
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="X-007 Loaded",bUnavailable=True)
		InitialWeaponMode=1
		//ReloadAnimRate=1.200000
		//CockAnimRate=1.000000
		WeaponName="Mk 781 12ga Flechette Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		FireParams(3)=FireParams'RealisticPrimarySuppressedFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(2)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(3)=FireParams'RealisticSecondaryBoltFireParams'
	End Object

	Begin Object Class=WeaponParams Name=RealisticParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holo + LAM"
		LayoutTags="lam,no_suppressor"
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_LAM',BoneName="tip",Scale=0.06,AugmentOffset=(x=-12,y=0,z=-1.1),AugmentRot=(Pitch=0,Roll=32768,Yaw=0))
		WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=3)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=4)
		SightOffset=(X=4.20,Y=0.01,Z=6.97)
		SightPivot=(Pitch=0,Yaw=0)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=9
		bMagPlusOne=False //Animation actually accounts for this, magAmmo is +1 instead
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="X-007 Loaded",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="Mk 781 12ga Flechette Shotgun (LAM)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Dart
		//Layout core
		Weight=30
		LayoutName="4X Scope Sabot"
		LayoutTags="no_alt"
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_3XScope',BoneName="tip",Scale=0.15,AugmentOffset=(x=-28,y=0,z=-0.3),AugmentRot=(Pitch=0,Roll=16384,Yaw=32678))
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
        WeaponBoneScales(1)=(BoneName="ShellHolder",Slot=8,Scale=0f)
        WeaponBoneScales(2)=(BoneName="HShells",Slot=9,Scale=0f)
		//Zoom
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=4
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		SightOffset=(X=4.00,Y=0.00,Z=8.6)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
		InventorySize=7
		MagAmmo=9
		bMagPlusOne=False //Animation actually accounts for this, magAmmo is +1 instead
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="X-007 Loaded",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="Mk 781 12ga Sabot Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Dart'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Dart'
		FireParams(2)=FireParams'RealisticPrimaryFireParams_Dart'
		FireParams(3)=FireParams'RealisticPrimaryFireParams_DartSupp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Holo'
	Layouts(1)=WeaponParams'RealisticParams'
	Layouts(2)=WeaponParams'RealisticParams_Dart'
	
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