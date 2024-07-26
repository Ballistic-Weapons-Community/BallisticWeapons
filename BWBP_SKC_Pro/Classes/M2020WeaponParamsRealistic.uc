class M2020WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=20000.000000) //7.62x51 ACCEL
		WaterTraceRange=18000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=100
		HeadMult=2.2
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrationEnergy=150.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-FireGaussAlt',Volume=1.750000)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.650000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object	
	
	//Gauss Offline
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParamsOffline
		TraceRange=(Min=1800.000000,Max=9000.000000) //7.62x51mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=55.0
		HeadMult=2.2
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Off';
     	DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadOff';
     	DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020Off';
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-FireAlt',Volume=1.800000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsOffline
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireAnim="FireUnPowered"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParamsOffline'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.100000
		XRandFactor=1.000000
		YRandFactor=1.000000
		MaxRecoil=3096
		DeclineDelay=0.250000
		DeclineTime=1.25
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=820,Max=2136)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=475.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		bMagPlusOne=True
		//SightOffset=(X=0.000000,Y=-3.000000,Z=18.000000)
		SightingTime=0.35
		//ViewOffset=(X=1,Y=9,Z=-13)
		ZoomType=ZT_Smooth
		WeaponModes(0)=(ModeName="Gauss: Online",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Gauss: Full Charge",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Gauss: Offline",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Gauss: Deflecting",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		InitialWeaponMode=0
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="M2020 7.92mm Gauss Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParamsOffline'
		FireParams(3)=FireParams'RealisticPrimaryFireParamsOffline'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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