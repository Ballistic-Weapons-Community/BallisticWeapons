class MARSWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=150.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08
		BurstFireRateFactor=0.55
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_CQC
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=150.000000
		Chaos=0.02000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_CQC
		FireInterval=0.080000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_CQC'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Smoke
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Chaff'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=65
		DamageRadius=512.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.3
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Smoke
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Smoke'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Ice
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Ice'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
		Speed=3500.000000
		Damage=50
		DamageRadius=768.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.300000
		WarnTargetPct=0.600000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Ice
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Ice'
	End Object
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.25000,OutVal=0.0800),(InVal=0.3500000,OutVal=0.070000),(InVal=0.4800000,OutVal=0.0900),(InVal=0.600000,OutVal=-0.020000),(InVal=0.750000,OutVal=0.030000),(InVal=0.900000,OutVal=0.06),(InVal=1.000000,OutVal=0.1)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.130000
		CrouchMultiplier=0.85
		ViewBindFactor=0.4
		HipMultiplier=1.25
	End Object
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams_CQC
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.030000),(InVal=0.25000,OutVal=0.0800),(InVal=0.3500000,OutVal=0.070000),(InVal=0.4800000,OutVal=0.0900),(InVal=0.600000,OutVal=-0.020000),(InVal=0.750000,OutVal=0.030000),(InVal=0.900000,OutVal=0.06),(InVal=1.000000,OutVal=0.1)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.130000
		CrouchMultiplier=0.85
		ViewBindFactor=0.4
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048))
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=ArenaAimParams_CQC
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout core
		Weight=30
		LayoutName="Adv Scope"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=30
		// ADS handling
		SightOffset=(X=6.50,Y=0.01,Z=0.8)
		SightMoveSpeedFactor=0.6
		SightingTime=0.4	
		// Zoom
        ZoomType=ZT_Fixed
		MaxZoom=3
		ScopeScale=0.6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Smoke'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Holo
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS3'
		//SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
		SightOffset=(X=6.50,Y=0.01,Z=3.65)
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=30
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_CQC'
        AimParams(0)=AimParams'ArenaAimParams_CQC'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_CQC'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Ice'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams_Scope'
    Layouts(1)=WeaponParams'ArenaParams_Holo'
	
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.MARS.F2000-Irons",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Green
		Index=2
		CamoName="Olive Drab"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-MainGreen",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Urban
		Index=3
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-MainSplitter",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Arctic
		Index=4
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.MARS.F2000-IronArctic",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Proto
		Index=5
		CamoName="Prototype"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-IronBlack",Index=1,PIndex=1,AIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_LE
		Index=6
		CamoName="Limited Edition"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-IronWhite",Index=1,PIndex=1,AIndex=0)
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