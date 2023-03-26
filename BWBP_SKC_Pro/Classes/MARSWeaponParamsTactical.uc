class MARSWeaponParamsTactical extends BallisticWeaponParams;

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
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
        PenetrationEnergy=32
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.5
		Recoil=150.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08
		BurstFireRateFactor=0.55
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_CQC
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_MARSAssault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MARSAssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MARSAssault'
        PenetrationEnergy=32
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.5
		Recoil=160.000000
		Chaos=0.02000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
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
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Smoke
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Chaff'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
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
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Ice
		ProjectileClass=Class'BWBP_SKC_Pro.MARSGrenade_Ice' //DT's need updating to point to MARS-2
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
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
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.250000),(InVal=0.4800000,OutVal=0.30000),(InVal=0.600000,OutVal=0.320000),(InVal=0.750000,OutVal=0.370000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		DeclineDelay=0.140000
		ViewBindFactor=0.4
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_CQC
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.150000),(InVal=0.4800000,OutVal=0.20000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=0.0500000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.3)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.5
		DeclineDelay=0.140000
		ViewBindFactor=0.4
		ADSViewBindFactor=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1536)
		ADSMultiplier=0.5
		AimAdjustTime=0.500000
		SprintOffset=(Pitch=-3072,Yaw=-4096))
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_CQC
		AimSpread=(Min=384,Max=1536)
		AimAdjustTime=0.600000
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout core
		Weight=30
		LayoutName="Adv Scope"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_F2000'
		ViewOffset=(X=0.500000,Y=14.000000,Z=-20.000000)
		//Function
		ReloadAnimRate=0.85
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.5	
		DisplaceDurationMult=1
		MagAmmo=30
		// acog-like
        ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=4
		ZoomStages=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Smoke'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Holosight
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_MARS3'
		ViewOffset=(X=0.5,Y=12.000000,Z=-18.000000)
		SightDisplayFOV=48
		SightOffset=(X=10.000000,Y=-7.370000,Z=27.010000)
		//SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
		//Function
		ReloadAnimRate=0.85
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
	
	//Camos =======================================
	Begin Object Class=WeaponCamo Name=MARS_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Tan
		Index=1
		CamoName="Tan"
		Weight=15
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_SKC_Tex.MARS.F2000-Irons",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Green
		Index=2
		CamoName="Olive Drab"
		Weight=15
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-MainGreen",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Urban
		Index=3
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-MainSplitter",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Arctic
		Index=4
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_SKC_Tex.MARS.F2000-IronArctic",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_Proto
		Index=5
		CamoName="Prototype"
		Weight=3
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-IronBlack",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MARS_LE
		Index=6
		CamoName="Limited Edition"
		Weight=3
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.MARS.F2000-IronWhite",Index=1)
	End Object
	
    Layouts(0)=WeaponParams'TacticalParams_Scope'
    Layouts(1)=WeaponParams'TacticalParams_Holosight'
	
	Camos(0)=WeaponCamo'MARS_Black' //Black
	Camos(1)=WeaponCamo'MARS_Tan'
	Camos(2)=WeaponCamo'MARS_Green'
	Camos(3)=WeaponCamo'MARS_Urban'
	Camos(4)=WeaponCamo'MARS_Arctic'
	Camos(5)=WeaponCamo'MARS_Proto'
	Camos(6)=WeaponCamo'MARS_LE'
}