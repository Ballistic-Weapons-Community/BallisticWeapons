class M806WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=6000.000000)
		WaterTraceRange=3600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=35.0
		HeadMult=3.0
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
		PenetrationEnergy=24.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000)
		Recoil=1836.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsBurst
		FireInterval=0.250000
		BurstFireRateFactor=0.75
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Laser
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams_Shotgun
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=6
		DamageType=Class'BallisticProV55.DTM806Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM806ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Shotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Shotgun
		TargetState="Shotgun"
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireAlt"
		AimedFireAnim='FireAlt'
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams_Shotgun'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.600000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=1024)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
		ChaosTurnThreshold=196608.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Laser + Ext Mags"
		Weight=30
		WeaponPrice=800
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.2250000
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		SightOffset=(X=-13.000000,Y=-4.2,Z=37.50000)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=12
		ViewOffset=(X=3.000000,Y=25.000000,Z=-23.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout core
		LayoutName="4X Scope"
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
		SightingTime=0.350000
		SightOffset=(X=0,Y=0,Z=18)
		SightPivot=(Pitch=0,Roll=0)
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=8
		ViewOffset=(X=3.000000,Y=25.000000,Z=-23.000000)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Shotgun
		// Layout core
		LayoutName="Shotgun"
		LayoutTags="shotgun"
		Weight=5
		WeaponPrice=1200
		// Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M806SG'
		// ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		SightPivot=(Pitch=0,Roll=0) 
		SightOffset=(X=-5.000000,Y=0,Z=4.50000)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		// Stats
		bDualBlocked=true
		PlayerSpeedFactor=1.100000
		InventorySize=3 //4
		bNeedCock=True
		MagAmmo=8
		ViewOffset=(X=3.000000,Y=25.000000,Z=-23.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Shotgun'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Scope'
	Layouts(2)=WeaponParams'ClassicParams_Shotgun'
	
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