class M2020WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Recharge
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalRechargeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=70
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=100
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		PushbackForce=120.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		Recoil=400.000000
		Chaos=0.600000
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalRechargeFireParams
		FireInterval=0.8000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalRechargeEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Power
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalPowerEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=1.75
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		PenetrationEnergy=150
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.600000
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalPowerFireParams
		FireAnim="FirePowered"
		FireInterval=1.500000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPowerEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalOfflineEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=40
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Off'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020Off'
        PenetrationEnergy=48
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=150.000000
		Chaos=0.050000
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalOfflineFireParams
		FireAnim="FireUnPowered"
		FireInterval=0.400000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalOfflineEffectParams'
	End Object
	
    //=================================================================
    // PRIMARY FIRE - Recharge (Supp)
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalRechargeEffectParams_Supp
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=70
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=100
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		PushbackForce=120.000000
		Recoil=380.000000 //
		Chaos=1.200000 //
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash' //
		FlashScaleFactor=1.000000 //
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-FireGaussAlt',Volume=1.750000) //
	End Object

	Begin Object Class=FireParams Name=TacticalRechargeFireParams_Supp
		FireInterval=0.8500
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalRechargeEffectParams_Supp'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline (Supp)
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalOfflineEffectParams_Supp
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=40
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Off'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020Off'
        PenetrationEnergy=48
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		Recoil=140.000000 //
		Chaos=0.10000 //
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Mk781.Mk781-FireSupp',Volume=1.100000,Radius=192.000000,bAtten=True) //
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash' //
		FlashScaleFactor=1.000000 //
	End Object

	Begin Object Class=FireParams Name=TacticalOfflineFireParams_Supp
		FireAnim="FireUnPowered"
		FireInterval=0.400000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalOfflineEffectParams_Supp'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRechargeRecoilParams
		ViewBindFactor=0.2
		ADSViewBindFactor=1.0
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.040000),(InVal=0.380000,OutVal=-0.0500000),(InVal=0.550000,OutVal=0.07000),(InVal=0.720000,OutVal=-0.10000),(InVal=1.000000,OutVal=-0.15)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		ClimbTime=0.06
		DeclineDelay=0.5
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalPowerRecoilParams
		ViewBindFactor=0.2
		ADSViewBindFactor=1.0
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.45
		YRandFactor=0.45
		ClimbTime=0.125
		DeclineDelay=0.7
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.5
		MaxMoveMultiplier=3
	End Object

	Begin Object Class=RecoilParams Name=TacticalOfflineRecoilParams
		ViewBindFactor=0.2
		ADSViewBindFactor=1.0
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.800000,OutVal=0.010000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_RDS
		ViewBindFactor=0.2
		ADSViewBindFactor=0.5
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.800000,OutVal=0.010000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2560)
		AimAdjustTime=0.7
		ADSMultiplier=0.7
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_RDS
		AimSpread=(Min=512,Max=2560)
		AimAdjustTime=0.7
		ADSMultiplier=0.7
		ADSViewBindFactor=0
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Overcharger Coil"
		//Attachments
		//ADS sniper 5-10x
		SightMoveSpeedFactor=0.35
		SightingTime=0.45	
		ScopeScale=0.75
        ZoomType=ZT_Logarithmic
		MinZoom=5
		MaxZoom=10
		ZoomStages=1
		//Function
		PlayerSpeedFactor=0.95
		InventorySize=7
		DisplaceDurationMult=1
		MagAmmo=10
		RecoilParams(0)=RecoilParams'TacticalRechargeRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalPowerRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalOfflineRecoilParams'
		RecoilParams(3)=RecoilParams'TacticalOfflineRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalRechargeFireParams'
		FireParams(1)=FireParams'TacticalPowerFireParams'
		FireParams(2)=FireParams'TacticalOfflineFireParams'
		FireParams(3)=FireParams'TacticalOfflineFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.M2020Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-40,y=-1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		//ADS
		SightMoveSpeedFactor=0.45
		SightingTime=0.35
		SightOffset=(X=4.00,Y=-0.10,Z=0.75)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		//Function
		PlayerSpeedFactor=0.95
		InventorySize=7
		DisplaceDurationMult=1
		MagAmmo=10
		WeaponModes(0)=(ModeName="Gauss: Recharge",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=0)
		WeaponModes(1)=(ModeName="Gauss: Power",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=1,bUnavailable=True)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(1)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(2)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(3)=RecoilParams'TacticalRecoilParams_RDS'
        AimParams(0)=AimParams'TacticalAimParams_RDS'
		FireParams(0)=FireParams'TacticalRechargeFireParams'
		FireParams(1)=FireParams'TacticalRechargeFireParams'
		FireParams(2)=FireParams'TacticalOfflineFireParams'
		FireParams(3)=FireParams'TacticalOfflineFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressor"
		LayoutTags="supp"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.M2020Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_ReflexRU',BoneName="tip",Scale=0.08,AugmentOffset=(x=-40,y=-1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorOsprey',BoneName="tip",Scale=0.2,AugmentOffset=(x=-15,y=1,z=0.0),AugmentRot=(Pitch=0,Roll=16384,Yaw=32768))
		//ADS
		SightMoveSpeedFactor=0.45
		SightingTime=0.35
		SightOffset=(X=4.00,Y=-0.08,Z=0.55)
		ZoomType=ZT_Irons
		ScopeViewTex=None
		//Function
		PlayerSpeedFactor=0.95
		InventorySize=7
		DisplaceDurationMult=1
		MagAmmo=10
		WeaponModes(0)=(ModeName="Gauss: Recharge",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=0)
		WeaponModes(1)=(ModeName="Gauss: Power",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=1,bUnavailable=True)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000,RecoilParamsIndex=2)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(1)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(2)=RecoilParams'TacticalRecoilParams_RDS'
		RecoilParams(3)=RecoilParams'TacticalRecoilParams_RDS'
        AimParams(0)=AimParams'TacticalAimParams_RDS'
		FireParams(0)=FireParams'TacticalRechargeFireParams_Supp'
		FireParams(1)=FireParams'TacticalRechargeFireParams_Supp'
		FireParams(2)=FireParams'TacticalOfflineFireParams_Supp'
		FireParams(3)=FireParams'TacticalOfflineFireParams_Supp'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Holo'
    Layouts(2)=WeaponParams'TacticalParams_Supp'
	
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