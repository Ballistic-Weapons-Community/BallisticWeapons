class R9A1WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=10000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=93.0
		HeadMult=2.387096
		LimbMult=0.677419
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrationEnergy=27.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=1.000000,Pitch=1.000000)
		Recoil=1024.000000
		Chaos=0.100000
		Inaccuracy=(X=9,Y=9)
		BotRefireRate=0.150000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"
		FireEndAnim=
		FireAnimRate=2.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.5
		Damage=35
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle_Freeze'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead_Freeze'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle_Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=RealisticFreezeFireParams
		FireInterval=0.225000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'RealisticFreezeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=RealisticHeatEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		WaterTraceRange=5000
		RangeAtten=0.5
		Damage=20
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle_Laser'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead_Laser'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle_Laser'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=RealisticHeatFireParams
		FireInterval=0.225000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'RealisticHeatEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.60000
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=2560
		DeclineTime=0.800000
		DeclineDelay=0.190000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1664)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.125000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-3072)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
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
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.28
		MagAmmo=12
		bMagPlusOne=True
		//ViewOffset=(X=-4.000000,Y=9.00000,Z=-13.000000)
		//SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.250000
		WeaponName="R9E2 .308 Ranger Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticFreezeFireParams'
		FireParams(2)=FireParams'RealisticHeatFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_R9'
		SightOffset=(X=-5.000000,Y=-0.020000,Z=3.100000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponBoneScales(0)=(BoneName="RDS",Slot=58,Scale=1f)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23
		MagAmmo=12
		bMagPlusOne=True
		//ViewOffset=(X=-4.000000,Y=9.00000,Z=-13.000000)
		//SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.250000
		WeaponName="R9 .308 Ranger Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticFreezeFireParams'
		FireParams(2)=FireParams'RealisticHeatFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_R9'
		SightOffset=(X=-5.000000,Y=-0.000000,Z=2.000000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponBoneScales(0)=(BoneName="RDS",Slot=58,Scale=0f)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23
		MagAmmo=12
		bMagPlusOne=True
		//ViewOffset=(X=-4.000000,Y=9.00000,Z=-13.000000)
		//SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.250000
		WeaponName="R9 .308 Ranger Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticFreezeFireParams'
		FireParams(2)=FireParams'RealisticHeatFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Holo'
	Layouts(2)=WeaponParams'RealisticParams_Irons'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH2",Index=1,AIndex=0,PIndex=0)
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH3",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_Winter
		Index=4
		CamoName="Winter"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH5",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R9_IceFire
		Index=5
		CamoName="Fire & Ice"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R9Camos.R9_body_SH1",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'R9_Orange'
	Camos(1)=WeaponCamo'R9_OrangeShine'
	Camos(2)=WeaponCamo'R9_Gray'
	Camos(3)=WeaponCamo'R9_Jungle'
	Camos(4)=WeaponCamo'R9_Winter'
	Camos(5)=WeaponCamo'R9_IceFire'
}