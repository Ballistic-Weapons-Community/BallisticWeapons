class M290WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		//TraceCount=20
		//Damage=10
		TraceCount=16
		Damage=18.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM290Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Fire',Volume=1.500000)
		Recoil=1536.000000
		Chaos=0.240000
		Inaccuracy=(X=950,Y=800)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.850000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnimRate=1.350000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		//Damage=20
		//TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		TraceCount=8
		Damage=18.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM290Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290SingleFire',Volume=1.200000)
		Recoil=768.000000
		Chaos=0.120000
		Inaccuracy=(X=800,Y=800)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnim="FireRight"
		FireAnimRate=1.850000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.500000,OutVal=0.800000),(InVal=0.850000,OutVal=-0.500000),(InVal=1.000000,OutVal=-0.300000)))
		YawFactor=0.250000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1536.000000
		DeclineTime=0.550000
		DeclineDelay=0.165000
		ViewBindFactor=0.700000
		ADSViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1792)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3072,Yaw=-9000)
		JumpChaos=1.0
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.4
		ChaosDeclineTime=1.100000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=8
		bMagPlusOne=True //Todo: Plus two
		ViewOffset=(X=14.000000,Y=8.000000,Z=-13.000000)
		//SightOffset=(X=-50.000000,Z=17.000000)     //Original
		SightPivot=(Pitch=256)                     //Original
		//CockAnimRate=1.400000
		//ReloadAnimRate=1.350000
		WeaponName="M290 12ga Double-Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M290_Yellow
		Index=0
		CamoName="Yellow"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M290_Dark
		Index=1
		CamoName="Dark Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M290Camos.MiniThorSkin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M290_Retro
		Index=2
		CamoName="Retro Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M290Camos.M290_SH1",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'M290_Yellow'
	Camos(1)=WeaponCamo'M290_Dark'
	Camos(2)=WeaponCamo'M290_Retro'
}