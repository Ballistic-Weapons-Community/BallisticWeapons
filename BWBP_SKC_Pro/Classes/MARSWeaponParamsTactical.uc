class MARSWeaponParamsTactical extends BallisticWeaponParams;

static simulated function OnInitialize(BallisticWeapon BW)
{
	MARSAssaultRifle(BW).MaxTrackTime = 3;
}

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
        PenetrationEnergy=32
		PenetrateForce=150
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.66
		Recoil=180.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-Fire',Pitch=1.250000,Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08
		BurstFireRateFactor=0.55
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_CQC
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
        PenetrationEnergy=32
		PenetrateForce=150
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.66
		Recoil=180.000000
		Chaos=0.02000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-Fire',Pitch=1.250000,Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_CQC
		FireInterval=0.080000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_CQC'
	End Object		
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Smoke GL
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Smoke
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Chaff'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
        Speed=2700.000000
		MaxSpeed=2700.000000
		Damage=80
        ImpactDamage=80
		DamageRadius=256.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.5
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Smoke
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams_Smoke'
	End Object
	
	//Sensor GL
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Sensor'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
        Speed=2700.000000
		MaxSpeed=2700.000000
		Damage=10
        ImpactDamage=80
		DamageRadius=16.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.5
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Sensor
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams_Sensor'
	End Object
	
	//Ice GL
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Ice
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Ice'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
        Speed=2700.000000
		MaxSpeed=2700.000000
		Damage=80
        ImpactDamage=80
		DamageRadius=512.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.5
		BotRefireRate=0.300000
		WarnTargetPct=0.600000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Ice
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams_Ice'
	End Object	
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		FireInterval=0.200000
		AmmoPerFire=0
		TargetState=Scope
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.25000,OutVal=0.0800),(InVal=0.3500000,OutVal=0.070000),(InVal=0.4800000,OutVal=0.0900),(InVal=0.600000,OutVal=-0.020000),(InVal=0.750000,OutVal=0.030000),(InVal=0.900000,OutVal=0.06),(InVal=1.000000,OutVal=0.1)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.130000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
		ViewBindFactor=0.4
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_CQC
		ViewBindFactor=0.2
		ADSViewBindFactor=0.7
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.25000,OutVal=0.0800),(InVal=0.3500000,OutVal=0.070000),(InVal=0.4800000,OutVal=0.0900),(InVal=0.600000,OutVal=-0.020000),(InVal=0.750000,OutVal=0.030000),(InVal=0.900000,OutVal=0.06),(InVal=1.000000,OutVal=0.1)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.130000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
		ADSMultiplier=0.65
		AimAdjustTime=0.600000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_CQC
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams_Smoker
		//Layout core
		Weight=30
		LayoutName="NV + Smoke"
		LayoutTags="NV,tracker"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.MARS.F2000-LensShineAltGreen',Index=3,PIndex=2,AIndex=3)
		//Function
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=30
		// ADS handling
		SightOffset=(X=6.50,Y=0.01,Z=0.8)
		SightMoveSpeedFactor=0.35
		SightingTime=0.4	
		// Zoom
        ZoomType=ZT_Fixed
		MaxZoom=3
		ScopeScale=0.7
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Smoke'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Sensor
		//Layout core
		Weight=30
		LayoutName="Sensor"
		LayoutTags="always_track_sensor"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		//Function
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=30
		// ADS handling
		SightOffset=(X=6.50,Y=0.01,Z=0.8)
		SightMoveSpeedFactor=0.35
		SightingTime=0.4	
		// Zoom
        ZoomType=ZT_Fixed
		MaxZoom=3
		ScopeScale=0.6
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Sensor'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Holosight
		//Layout core
		Weight=30
		LayoutName="Holo + Ice"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS3'
		SightOffset=(X=6.50,Y=0.01,Z=3.65)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=30
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_CQC'
        AimParams(0)=AimParams'TacticalAimParams_CQC'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_CQC'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Ice'
    End Object 	

	Layouts(0)=TacticalParams_Smoker
	Layouts(1)=TacticalParams_Sensor
    Layouts(2)=TacticalParams_Holosight
	
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=MARS_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Tan
		Index=1
		CamoName="Tan"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronsTan",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Green
		Index=2
		CamoName="Olive Drab"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-MainGreen",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Urban
		Index=3
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-MainSplitter",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Arctic
		Index=4
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronArctic",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Proto
		Index=5
		CamoName="Prototype"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronBlack",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_LE
		Index=6
		CamoName="Limited Edition"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARSCamos.F2000-IronWhite",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'MARS_Black' //Black
	Camos(1)=WeaponCamo'MARS_Tan'
	Camos(2)=WeaponCamo'MARS_Green'
	Camos(3)=WeaponCamo'MARS_Urban'
	Camos(4)=WeaponCamo'MARS_Arctic'
	Camos(5)=WeaponCamo'MARS_Proto'
	Camos(6)=WeaponCamo'MARS_LE'
	//Camos(7)=WeaponCamos'MARS_Gold'
}