class T9CNWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		RangeAtten=0.500000
		Damage=19
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.300000)
		Recoil=225.000000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.080000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Stock
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Stock
		RangeAtten=0.500000
		Damage=19
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-Fire',Volume=1.300000)
		Recoil=185.000000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Stock
		FireInterval=0.080000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Stock'
	End Object
	
	//Robo
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Gauss
		RangeAtten=0.500000
		Damage=19
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.T9CNFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-FireRobo',Volume=1.500000)
		Recoil=205.000000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Gauss
		FireInterval=0.085000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Gauss'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		RangeAtten=0.500000
		Damage=59
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrateForce=580
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.800000)
		Recoil=625.000000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.480000
		AimedFireAnim="SightFire"	
		TargetState=Gauss
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		FireInterval=0.200000
		AmmoPerFire=0
		TargetState=Scope
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.3500000,OutVal=-0.02),(InVal=0.500000,OutVal=0.07),(InVal=0.6500000,OutVal=0.12),(InVal=0.800000,OutVal=-0.06),(InVal=1.000000,OutVal=0.07)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.18),(InVal=0.300000,OutVal=0.35),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=6144
		ClimbTime=0.04
		DeclineDelay=0.3
		DeclineTime=0.5
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=0.05
		ADSMultiplier=0.400000
		AimAdjustTime=1.200000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=850.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Auto
		//Layout core
		LayoutName="Automatic Mod"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.T9CN.Ber-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.T9CN.Ber-SlideShine',Index=3,Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MiscSilverShine',Index=4,Index=4,PIndex=-1)
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.225000
		SightOffset=(X=0.00,Y=0.00,Z=1.73)
		SightPivot=(Pitch=128)
		//Functions
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
        InventorySize=4
		MagAmmo=18
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_Gauss
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
		SightMoveSpeedFactor=0.9
		SightingTime=0.225000
		SightOffset=(X=5.00,Y=0.05,Z=1.2)
		SightPivot=(Pitch=-128)
		//Functions
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.050000
        InventorySize=4
		MagAmmo=18
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Gauss'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_Stock
		//Layout core
		LayoutName="Brace"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_T9CN'
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000 //
		SightOffset=(X=0.00,Y=0.30,Z=1)
		SightPivot=(Pitch=0)
		//Functions
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.0 //
        InventorySize=4
		MagAmmo=18
		ViewOffset=(X=4.00,Y=7.00,Z=-6.00)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Stock'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object

	Layouts(0)=WeaponParams'ArenaParams_Auto'
	Layouts(1)=WeaponParams'ArenaParams_Gauss'
	Layouts(2)=WeaponParams'ArenaParams_Stock'
	
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