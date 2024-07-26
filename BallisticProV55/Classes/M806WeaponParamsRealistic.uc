class M806WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)  //.45
		WaterTraceRange=5000.0
		RangeAtten=0.5
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=45.0 //longer barrel than rs04/sx45
		HeadMult=2.3
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=30
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000) //Custom Sound
		Recoil=640.000000
		Chaos=0.080000
		Inaccuracy=(X=15,Y=15)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.170000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=2.750000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Laser
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_SG
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=6
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BallisticProV55.DTM806Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM806ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Shotgun'
		PenetrationEnergy=4.000000
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=768.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_SG
		TargetState="Shotgun"
		FireInterval=0.700000
		PreFireAnim=
		AmmoPerFire=0
		FireAnim="FireAlt"
		AimedFireAnim='FireAlt'
		FireAnimRate=1.100000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_SG'
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
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.550000
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1536.000000
		DeclineTime=0.400000
		DeclineDelay=0.1250000
		ViewBindFactor=0.30000
		ADSViewBindFactor=0.30000
		HipMultiplier=1.000000
		CrouchMultiplier=0.820000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.550000
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1536.000000
		DeclineTime=0.400000
		DeclineDelay=0.1250000
		ViewBindFactor=1.00000
		ADSViewBindFactor=1.00000
		HipMultiplier=1.000000
		CrouchMultiplier=0.820000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=750.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Laser + Ext Mags"
		Weight=30
		WeaponPrice=800
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		SightOffset=(X=-13.000000,Y=-4.2,Z=37.50000)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=12
		bMagPlusOne=True
		ViewOffset=(X=0.00,Y=20.00,Z=-20.00)
		WeaponName="M806 .45 Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Scope
		//Layout core
		LayoutName="4X Scope"
		LayoutTags="scope"
		Weight=5
		WeaponPrice=800
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.M806.M806_Main-SD',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=2)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_PistolRail',BoneName="Muzzle",Scale=0.35,AugmentOffset=(x=-60,y=0,z=-50),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.35,AugmentOffset=(x=-120,y=0,z=25),AugmentRot=(Pitch=0,Roll=0,Yaw=0))
		//Zoom
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		ZoomType=ZT_Fixed	
		MaxZoom=4	
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.270000 //+.12
		SightOffset=(X=0,Y=0,Z=18)
		SightPivot=(Pitch=0,Roll=0)
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=8
		bMagPlusOne=True
		ViewOffset=(X=0.00,Y=20.00,Z=-20.00)
		WeaponName="M806 .45 Handgun (4X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Shotgun
		// Layout core
		LayoutName="Shotgun"
		LayoutTags="shotgun"
		Weight=5
		WeaponPrice=1200
		// Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M806SG'
		// ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.20000 //+.05
		SightPivot=(Pitch=0,Roll=0) 
		SightOffset=(X=-5.000000,Y=0,Z=4.50000)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		// Stats
		PlayerSpeedFactor=1.050000 //-.05
		InventorySize=3
		MagAmmo=8
		bMagPlusOne=True
		bDualBlocked=true //too big
		ViewOffset=(X=0.00,Y=20.00,Z=-20.00)
		WeaponName="M806 .45/16ga Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_SG'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Scope'
	Layouts(2)=WeaponParams'RealisticParams_Shotgun'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M806_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainBlackShine",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Tiger
		Index=3
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainTigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Dragon
		Index=4
		CamoName="Dragon"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.Dragon_Main-SD",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainGoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M806_Gray'
	Camos(1)=WeaponCamo'M806_Black'
	Camos(2)=WeaponCamo'M806_Desert'
	Camos(3)=WeaponCamo'M806_Tiger'
	Camos(4)=WeaponCamo'M806_Dragon'
	Camos(5)=WeaponCamo'M806_Gold'
}