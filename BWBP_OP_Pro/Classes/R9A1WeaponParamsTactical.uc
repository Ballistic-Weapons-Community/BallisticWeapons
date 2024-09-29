class R9A1WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=70 // .308
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=512.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.3000
		FireAnimRate=0.9
		FireEndAnim=
		//AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=40
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle_Freeze'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead_Freeze'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle_Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=512.000000
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
		Damage=40
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle_Laser'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead_Laser'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle_Laser'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=256.000000
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
		ADSViewBindFactor=1
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.10000),(InVal=0.350000,OutVal=0.25000),(InVal=0.5,OutVal=0.30000),(InVal=0.70000,OutVal=0.350000),(InVal=0.850000,OutVal=0.42000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.175000),(InVal=0.400000,OutVal=0.450000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.08
		DeclineDelay=0.350000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.70
		ChaosSpeedThreshold=300
		ADSMultiplier=0.7
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.70
		ChaosSpeedThreshold=300
		ADSMultiplier=0.7
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Hybrid Scope"
		LayoutTags="hybrid"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Optics",Slot=55,Scale=1f)
		WeaponBoneScales(1)=(BoneName="EOTech",Slot=56,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Scope",Slot=57,Scale=1f)
		SightPivot=(Roll=11800)
		SightOffset=(X=0.000000,Y=0.36000,Z=4.75)
		MinZoom=4 // sniper 4-8x
		MaxZoom=8
		ZoomStages=1
		//Function
		//SightOffset=(X=30.000000,Y=2.850000,Z=9.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.40
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=12
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalFreezeFireParams'
		FireParams(2)=FireParams'TacticalHeatFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Holo
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.R9_FPm'
		SightOffset=(X=-5.000000,Y=-0.020000,Z=3.100000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponBoneScales(0)=(BoneName="RDS",Slot=58,Scale=1f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.40	
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=12
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalFreezeFireParams'
		FireParams(2)=FireParams'TacticalHeatFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.R9_FPm'
		SightOffset=(X=-5.000000,Y=-0.000000,Z=2.000000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponBoneScales(0)=(BoneName="RDS",Slot=58,Scale=0f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.40	
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=12
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalFreezeFireParams'
		FireParams(2)=FireParams'TacticalHeatFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Holo'
    Layouts(2)=WeaponParams'TacticalParams_Irons'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=R9_IceFire
		Index=0
		CamoName="Fire & Ice"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.R9A1.R9_body_SH1",Index=1,AIndex=0,PIndex=0)
	End Object

	Begin Object Class=WeaponCamo Name=R9_OrangeShine
		Index=1
		CamoName="Fresh Orange"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH2",Index=1,AIndex=0,PIndex=0)
	End Object

	Begin Object Class=WeaponCamo Name=R9_Jungle
		Index=2
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH3",Index=1,AIndex=0,PIndex=0)
	End Object

	Begin Object Class=WeaponCamo Name=R9_Orange
		Index=3
		CamoName="Orange"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_Gray
		Index=4
		CamoName="Gray"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH4",Index=1,AIndex=0,PIndex=0)
	End Object

	Begin Object Class=WeaponCamo Name=R9_Winter
		Index=5
		CamoName="Winter"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH5",Index=1,AIndex=0,PIndex=0)
	End Object

	Camos(0)=R9_IceFire
	Camos(1)=R9_OrangeShine
	Camos(2)=R9_Jungle
	Camos(3)=R9_Orange
	Camos(4)=R9_Gray
	Camos(5)=R9_Winter
}