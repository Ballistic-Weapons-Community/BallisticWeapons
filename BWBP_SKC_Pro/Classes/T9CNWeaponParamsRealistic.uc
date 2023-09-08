class T9CNWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		WaterTraceRange=800.0
		RangeAtten=0.500000
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=300.000000 //
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.130000 //
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000) //9mm JHP
		WaterTraceRange=800.0
		RangeAtten=0.500000
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=450.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object

	//Stock
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Stock
		TraceRange=(Min=4000.000000,Max=4000.000000) //9mm JHP
		WaterTraceRange=800.0
		RangeAtten=0.500000
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=300.000000 //
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Stock
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Stock'
	End Object

	//Gauss
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Gauss
		TraceRange=(Min=4000.000000,Max=4000.000000) //9mm JHP
		WaterTraceRange=800.0
		RangeAtten=0.500000
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-FireRobo',Volume=1.500000)
		Recoil=450.000000
		Chaos=0.070000
		Inaccuracy=(X=6,Y=6)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Gauss
		FireInterval=0.070000 //
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Gauss'
	End Object

	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=800.000000,Max=7000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=99.0
		HeadMult=2.181818
		LimbMult=0.606060
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=40.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.8
		WallPDamageFactor=0.6
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.800000)
		Recoil=900.000000
		Chaos=0.270000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.630000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
		TargetState=Gauss
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		FireInterval=0.200000
		AmmoPerFire=0
		TargetState=Scope
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.500000
		YawFactor=0.000000
		XRandFactor=0.3500000
		YRandFactor=0.350000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.120000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//Burst
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.180000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.700000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=800.000000
	End Object

	//Stock
	Begin Object Class=AimParams Name=RealisticAimParams_Stock
		AimSpread=(Min=386,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.70000 //
		ADSMultiplier=0.700000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.250000 //
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=600.000000 //
		ChaosTurnThreshold=140000.000000 //
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Robocop
		//Layout core
		LayoutName="Gauss Mod"
		LayoutTags="gauss"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=1f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=1f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.T9CN.Ber-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.T9CN.Ber-SlideShine',Index=3,Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MiscSilverShine',Index=4,Index=4,PIndex=-1)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.130000
		SightOffset=(X=5.00,Y=0.05,Z=1.2)
		SightPivot=(Pitch=-128)
		//Functions
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=1200
		MagAmmo=18
		bMagPlusOne=True
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		InitialWeaponMode=1
		WeaponName="T9CN 9mm Autopistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Gauss'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Gauss'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Auto
		//Layout core
		LayoutName="Automatic Mod"
		Weight=30
		WeaponPrice=1200
		//Attachments
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.130000
		SightOffset=(X=5.00,Y=0.05,Z=1.2)
		SightPivot=(Pitch=-128)
		//Functions
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=18
		bMagPlusOne=True
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="T9CN 9mm Police Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		RecoilParams(2)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Stock
		//Layout core
		LayoutName="Braced"
		Weight=10
		WeaponPrice=1200
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_T9CN'
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.180000 //+.05
		SightOffset=(X=0.00,Y=0.30,Z=1)
		SightPivot=(Pitch=0)
		//Functions
		PlayerSpeedFactor=1.050000 //-.05
		InventorySize=3
		MagAmmo=18
		bMagPlusOne=True
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="T9CN-R 9mm Police Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		RecoilParams(2)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams_Stock'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Stock'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Robocop'
	Layouts(1)=WeaponParams'RealisticParams_Auto'
	Layouts(2)=WeaponParams'RealisticParams_Stock'
	
	//Camos =====================================
	
	Begin Object Class=WeaponCamo Name=M9_Inox
		Index=0
		CamoName="Inox"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_Silver
		Index=1
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-SlideSilverShine',Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MiscSilverShine',Index=4,Index=4,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_BlackWorn
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MainBlack",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-SlideBlack",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscBlack",Index=4,Index=4,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_BlackWood
		Index=3
		CamoName="Black n Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineD",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineC",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscBlack",Index=4,Index=4,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_Tan
		Index=4
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainE",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideE",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscBlack",Index=4,Index=4,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_TwoTone
		Index=5
		CamoName="Two-Tone"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineB",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.T9CN.Ber-SlideShine',Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscBlack",Index=4,Index=4,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_Toy
		Index=6
		CamoName="Toy"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MainToy",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-SlideToy",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscToy",Index=4,Index=4,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MainGold",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-SlideGold",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MiscGold",Index=4,Index=4,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M9_Inox'
	Camos(1)=WeaponCamo'M9_Silver'
	Camos(2)=WeaponCamo'M9_BlackWorn'
	Camos(3)=WeaponCamo'M9_BlackWood'
	Camos(4)=WeaponCamo'M9_Tan'
	Camos(5)=WeaponCamo'M9_TwoTone'
	Camos(6)=WeaponCamo'M9_Toy'
	Camos(7)=WeaponCamo'M9_Gold'
}