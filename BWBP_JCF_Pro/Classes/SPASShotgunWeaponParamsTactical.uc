class SPASShotgunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Slug
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=5500.000000,Max=7000.000000)
		WaterTraceRange=1000.0
        DecayRange=(Min=788,Max=2363) // 15-45m
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=140.0
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.35
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-HFire',Volume=1.800000)
		Recoil=1500.000000
		Chaos=0.4
		Inaccuracy=(X=32,Y=32)
		//HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=0.8500000	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//Shot
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_Shot
		TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.15
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.35
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-Fire',Volume=1.500000)
		Recoil=1536.000000
		Chaos=0.3
		Inaccuracy=(X=300,Y=300)
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Shot
		FireInterval=0.550000
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_Shot'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
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
	
	//Alt Shot
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.15
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.1
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.SPAS.SPAS-FireCock',Volume=1.500000)
		Inaccuracy=(X=240,Y=240)
		Recoil=2048.000000
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.80000
		AmmoPerFire=2
		FireAnim="FireCock"
		FireEndAnim=
		AimedFireAnim="SightFireCock"	
	FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		MaxRecoil=8192
		DeclineTime=0.75
		DeclineDelay=0.55
		ClimbTime=0.075
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=128,Max=1024)
        ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="12 Gauge Slug"
		LayoutTags="slug"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		ReloadAnimRate=1.500000
		MagAmmo=5
        InventorySize=5
		ViewOffset=(X=-1.000000,Y=4.000000,Z=-10.000000)
		SightOffset=(X=7.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Shot
		//Layout core
		LayoutName="12 Gauge Shot"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		ReloadAnimRate=1.500000
		MagAmmo=5
        InventorySize=5
		ViewOffset=(X=-1.000000,Y=4.000000,Z=-10.000000)
		SightOffset=(X=7.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Shot'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams'
	Layouts(1)=WeaponParams'TacticalParams_Shot'
	
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