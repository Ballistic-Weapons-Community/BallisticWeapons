class T9CNWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Semi
	Begin Object Class=InstantEffectParams Name=TacticalSemiEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=23 // 9mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=210.000000
		Chaos=0.150000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalSemiFireParams
		FireInterval=0.130000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalSemiEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=TacticalAutoEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=23
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=280.000000
		Chaos=0.070000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalAutoFireParams
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalAutoEffectParams'
	End Object

	//Burst Stock (Reduced recoil, increased chaos)
	Begin Object Class=InstantEffectParams Name=TacticalEffectParams_Stock
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=23
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.200000)
		Recoil=220.000000 //
		Chaos=0.140000 //
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalFireParams_Stock
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalEffectParams_Stock'
	End Object

	//Burst Gauss Barrel (Improved acc, reduced recoil, reduced fire rate)
	Begin Object Class=InstantEffectParams Name=TacticalEffectParams_Gauss
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=96,Y=96) //
        RangeAtten=0.5
        Damage=23
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-FireRobo',Volume=1.500000)
		Recoil=240.000000 //
		Chaos=0.10000 //
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalFireParams_Gauss
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalEffectParams_Gauss'
	End Object

	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Gauss
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryFireEffectParams
        TraceRange=(Min=6000.000000,Max=6000.000000)
        DecayRange=(Min=2500,Max=5000) // 45-90m
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.75
        Damage=69 // 9mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
        PenetrationEnergy=100
        PenetrateForce=300
        bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.800000)
		Recoil=610.000000
		Chaos=0.450000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.530000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=0.7
		TargetState=Gauss
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryFireEffectParams'
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

	// Burst
	Begin Object Class=RecoilParams Name=TacticalControlledRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.010000),(InVal=0.3500000,OutVal=0.04),(InVal=0.600000,OutVal=-0.05),(InVal=0.800000,OutVal=-0.03),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.18),(InVal=0.300000,OutVal=0.35),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.120000
		DeclineTime=0.750000
		MaxMoveMultiplier=1.5 //stock
	End Object

	// Auto
	Begin Object Class=RecoilParams Name=TacticalAutoRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.25 //
		EscapeMultiplier=1.1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.090000),(InVal=0.3500000,OutVal=-0.09),(InVal=0.500000,OutVal=0.021),(InVal=0.6500000,OutVal=0.36),(InVal=0.800000,OutVal=-0.18),(InVal=1.000000,OutVal=0.21)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.18),(InVal=0.300000,OutVal=0.35),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.120000
		DeclineTime=0.750000
		MaxMoveMultiplier=1.25
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	//Standard
	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        SprintChaos=0.050000
		CrouchMultiplier=1
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//Stock
	Begin Object Class=AimParams Name=TacticalAimParams_Stock
		ADSViewBindFactor=0.5 //
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        SprintChaos=0.050000
		CrouchMultiplier=0.85 //
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Auto
		//Layout core
		LayoutName="Automatic Mod"
		Weight=10
		WeaponPrice=1200
		//Attachments
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.17
		SightOffset=(X=0.00,Y=0.00,Z=1.73)
		SightPivot=(Pitch=128)
		//Functions
		InventorySize=3
		MagAmmo=18
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'TacticalControlledRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalAutoRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalSemiFireParams'
		FireParams(1)=FireParams'TacticalAutoFireParams'
		FireParams(2)=FireParams'TacticalAutoFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams_Scope'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object

	Begin Object Class=WeaponParams Name=TacticalParams_Robocop
		//Layout core
		LayoutName="Gauss Mod"
		LayoutTags="gauss"
		Weight=10
		WeaponPrice=1200
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
		SightMoveSpeedFactor=0.6
		SightingTime=0.20 //+.03
		SightOffset=(X=5.00,Y=0.05,Z=1.2)
		SightPivot=(Pitch=-128)
		//Functions
		InventorySize=3
		MagAmmo=18
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalControlledRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalAutoRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalFireParams_Gauss'
		FireParams(1)=FireParams'TacticalFireParams_Gauss'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Stock
		//Layout core
		LayoutName="Braced"
		LayoutTags="raffica"
		Weight=10
		WeaponPrice=1200
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_T9CN'
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.22000 //+.05
		SightOffset=(X=0.00,Y=0.30,Z=1)
		SightPivot=(Pitch=0)
		//Functions
		InventorySize=3
		MagAmmo=18
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalControlledRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalAutoRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams_Stock'
		FireParams(0)=FireParams'TacticalFireParams_Stock'
		FireParams(1)=FireParams'TacticalFireParams_Stock'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Auto'
	Layouts(1)=WeaponParams'TacticalParams_Robocop'
	Layouts(2)=WeaponParams'TacticalParams_Stock'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-MainShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.T9CN-SlideSilverShine",Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MiscSilverShine',Index=4,Index=4,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_BlackWorn
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineB",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineC",Index=3,Index=2,PIndex=1)
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineE",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineE",Index=3,Index=2,PIndex=1)
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