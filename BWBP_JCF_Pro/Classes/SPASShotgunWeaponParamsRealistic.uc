class SPASShotgunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//12ga Slug
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=7000.000000,Max=7000.000000)
		DecayRange=(Min=1200.0,Max=7000.0)
		WaterTraceRange=5000.0
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=140.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.35
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-HFire',Volume=1.800000)
		Recoil=1500.000000
		Chaos=-1.0
		Inaccuracy=(X=32,Y=32)
		//HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=0.8500000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//12ga Shot
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_Shot
		TraceRange=(Min=4200.000000,Max=4200.000000)
		WaterTraceRange=4800.0
		DecayRange=(Min=1200.0,Max=4200.0)
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		TraceCount=8
		Damage=16.5
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
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-Fire',Volume=1.500000)
		Recoil=920.000000
		Chaos=0.120000
		Inaccuracy=(X=450,Y=450)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Shot
		FireInterval=0.40000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=0.8500000	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_Shot'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1500
		DeclineTime=0.550000
		DeclineDelay=0.200000
		ViewBindFactor=0.700000
		ADSViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=640,Max=1280)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="12 Gauge Slug"
		LayoutTags="slug"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.350000
		//Stats
		InventorySize=6
		MagAmmo=4
		SightOffset=(X=2.000000,Y=-0.050000,Z=10.200000)
		ReloadAnimRate=1.250000
		CockAnimRate=1.400000
		WeaponName="SP-12 12ga Slug Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Shot
		//Layout core
		LayoutName="12 Gauge Shot"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.350000
		//Stats
		InventorySize=6
		MagAmmo=4
		SightOffset=(X=2.000000,Y=-0.050000,Z=10.200000)
		ReloadAnimRate=1.250000
		CockAnimRate=1.400000
		WeaponName="SP-12 12ga Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Shot'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Shot'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SP_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Cobalt
		Index=1
		CamoName="Cobalt"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S4",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Bricks
		Index=2
		CamoName="Bricks"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S2",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Hazard
		Index=3
		CamoName="Hazard"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S5",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S3",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'SP_Gray'
	Camos(1)=WeaponCamo'SP_Cobalt'
	Camos(2)=WeaponCamo'SP_Bricks'
	Camos(3)=WeaponCamo'SP_Hazard'
	Camos(4)=WeaponCamo'SP_Gold'
}