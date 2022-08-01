class Mk781WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2200.000000,Max=6500.000000)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=2.25
		LimbMult=0.666666
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
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=1.000000
		TraceCount=30
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=10
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
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=1300,Y=1200)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.100000)))
		YawFactor=0.100000
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
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=8
		SightOffset=(X=10.000000,Y=-7.645,Z=11.90000)
		SightPivot=(Pitch=-64,Yaw=10)
		ReloadAnimRate=1.200000
		CockAnimRate=1.000000
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=RealisticRDSParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=8
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="X-007 Loaded",bUnavailable=True)
		InitialWeaponMode=1
		SightOffset=(X=20.000000,Y=-7.660000,Z=13.940000)
		ReloadAnimRate=1.200000
		CockAnimRate=1.000000
		WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=3)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=4)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticRDSParams'
	Layouts(1)=WeaponParams'RealisticParams'


}