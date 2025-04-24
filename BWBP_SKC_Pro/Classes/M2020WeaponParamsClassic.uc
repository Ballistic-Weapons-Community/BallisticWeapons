class M2020WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=20000.000000)
		WaterTraceRange=18000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=80
		HeadMult=1.7
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrationEnergy=200.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=1.750000)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		AimedFireAnim="FireUnpowered"
		FireInterval=0.850000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Gauss Max Power
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsPower
		TraceRange=(Min=15000.000000,Max=20000.000000)
		WaterTraceRange=18000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.950000
		Damage=110
		HeadMult=1.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrationEnergy=200.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.850000
		WallPDamageFactor=0.850000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper',Volume=2.700000)
		Recoil=4096.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		PushbackForce=120
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsPower
		FireInterval=2.000000
		BurstFireRateFactor=1.00
		FireAnim="FirePowered"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsPower'
	End Object
	
	//Gauss Offline
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsOffline
		TraceRange=(Min=15000.000000,Max=20000.000000)
		WaterTraceRange=18000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.850000
		Damage=40
		HeadMult=2.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Off';
     	DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadOff';
     	DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020Off';
		PenetrationEnergy=64.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.400000
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow',Volume=1.200000)
		Recoil=172.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsOffline
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireUnPowered"
		AimedFireAnim="FireUnpowered"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsOffline'
	End Object	
		
	//Gauss Supp
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Supp
		TraceRange=(Min=15000.000000,Max=20000.000000)
		WaterTraceRange=18000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=80
		HeadMult=1.7
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrationEnergy=200.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-FireGaussAlt',Volume=1.750000)
		Recoil=1600.000000
		Chaos=4.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Supp
		AimedFireAnim="FireUnpowered"
		FireInterval=0.650000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Supp'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=1.000000
		YRandFactor=0.200000
		MaxRecoil=8096
		DeclineDelay=0.000000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.600000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=475.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Overcharger Coil"
		//Attachments
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.50000
		ZoomType=ZT_Smooth
		SightOffset=(X=4.00,Y=0.00,Z=1.93)
		//Function
		InventorySize=8
		bNeedCock=True
		MagAmmo=10
		WeaponModes(0)=(ModeName="Gauss: Std Charge",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Gauss: Overcharge",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsPower'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsOffline'
		FireParams(3)=FireParams'ClassicPrimaryFireParamsOffline'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.M2020Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-40,y=-1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.40000
		SightOffset=(X=4.00,Y=-0.10,Z=0.75)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		//Function
		InventorySize=8
		bNeedCock=True
		MagAmmo=10
		WeaponModes(0)=(ModeName="Gauss: Online",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Gauss: Full Charge",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsPower'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsOffline'
		FireParams(3)=FireParams'ClassicPrimaryFireParamsOffline'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressor"
		LayoutTags="supp"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.M2020Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_ReflexRU',BoneName="tip",Scale=0.08,AugmentOffset=(x=-40,y=-1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorOsprey',BoneName="tip",Scale=0.2,AugmentOffset=(x=-15,y=1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.50000
		SightOffset=(X=4.00,Y=-0.08,Z=0.55)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		//Function
		InventorySize=8
		bNeedCock=True
		MagAmmo=10
		WeaponModes(0)=(ModeName="Gauss: Online",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Gauss: Full Charge",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Supp'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_Supp'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsOffline'
		FireParams(3)=FireParams'ClassicPrimaryFireParamsOffline'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Holo'
	Layouts(2)=WeaponParams'ClassicParams_Supp'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M2020_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Aliens
		Index=1
		CamoName="Corporate"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainAlien",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainDesert",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Winter
		Index=3
		CamoName="Winter Hex"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainWinter",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Blue
		Index=4
		CamoName="Blue Hex"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainBlueHex",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Red
		Index=5
		CamoName="Red Tiger"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainRedTiger",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Camos(0)=WeaponCamo'M2020_Black'
	Camos(1)=WeaponCamo'M2020_Aliens'
	Camos(2)=WeaponCamo'M2020_Desert'
	Camos(3)=WeaponCamo'M2020_Winter'
	Camos(4)=WeaponCamo'M2020_Blue'
	Camos(5)=WeaponCamo'M2020_Red'
}