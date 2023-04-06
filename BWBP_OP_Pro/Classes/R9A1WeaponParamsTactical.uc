class R9A1WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=45
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=420.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=40
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=420.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalFreezeFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalFreezeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalHeatEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		WaterTraceRange=5000
		RangeAtten=0.75
		Damage=35
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=240.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalHeatFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalHeatEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.10000),(InVal=0.350000,OutVal=0.25000),(InVal=0.5,OutVal=0.30000),(InVal=0.70000,OutVal=0.350000),(InVal=0.850000,OutVal=0.42000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.175000),(InVal=0.400000,OutVal=0.450000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineDelay=0.350000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.700000
		ChaosSpeedThreshold=300
		ADSMultiplier=0.5
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Roll=11800)
		//SightOffset=(X=30.000000,Y=2.850000,Z=9.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.4	
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=15
		// sniper 4-8x
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalFreezeFireParams'
		FireParams(2)=FireParams'TacticalHeatFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=R9_Orange
		Index=0
		CamoName="Orange"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.R9.USSRSkin',Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_OrangeShine
		Index=1
		CamoName="Fresh Orange"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.R9A1.R9_body_SH2",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_Gray
		Index=2
		CamoName="Gray"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH4",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_Jungle
		Index=3
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.R9A1.R9_body_SH3",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_Winter
		Index=4
		CamoName="Winter"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH4",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_IceFire
		Index=5
		CamoName="Fire & Ice"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.R9A1.R9_body_SH1",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'R9_Orange'
	Camos(1)=WeaponCamo'R9_OrangeShine'
	Camos(2)=WeaponCamo'R9_Gray'
	Camos(3)=WeaponCamo'R9_Jungle'
	Camos(4)=WeaponCamo'R9_Winter'
	Camos(5)=WeaponCamo'R9_IceFire'
}