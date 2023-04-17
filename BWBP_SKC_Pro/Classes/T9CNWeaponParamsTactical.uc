class T9CNWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=24
        HeadMult=2.75f
        LimbMult=0.75f
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

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.130000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryBurstEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=24
        HeadMult=2.75f
        LimbMult=0.75f
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
		Chaos=0.070000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryBurstFireParams
		FireInterval=0.060000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryBurstEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.6
		EscapeMultiplier=1.1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.010000),(InVal=0.3500000,OutVal=0.04),(InVal=0.600000,OutVal=-0.05),(InVal=0.800000,OutVal=-0.03),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.18),(InVal=0.300000,OutVal=0.35),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.120000
		DeclineTime=0.750000
		MaxMoveMultiplier=2
	End Object
	
	//Burst
	Begin Object Class=RecoilParams Name=TacticalBurstRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.4
		EscapeMultiplier=1.1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.010000),(InVal=0.3500000,OutVal=0.04),(InVal=0.600000,OutVal=-0.05),(InVal=0.800000,OutVal=-0.03),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.18),(InVal=0.300000,OutVal=0.35),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.120000
		DeclineTime=0.750000
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ADSMultiplier=0.75
        SprintChaos=0.050000
        AimAdjustTime=0.450000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Robocop
		//Layout core
		LayoutName="Gauss Mod"
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
		//Functions
		InventorySize=3
		WeaponPrice=1200
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		MagAmmo=18
		SightPivot=(Pitch=128)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True,RecoilParamsIndex=1)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalBurstRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Auto
		//Layout core
		LayoutName="Automatic Mod"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		//Functions
		InventorySize=3
		WeaponPrice=1200
		SightMoveSpeedFactor=0.6
		SightingTime=0.2
		MagAmmo=18
		SightPivot=(Pitch=128)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalBurstRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalBurstRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryBurstFireParams'
		FireParams(2)=FireParams'TacticalPrimaryBurstFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Robocop'
	Layouts(1)=WeaponParams'TacticalParams_Auto'
	
	//Camos =====================================
	
	Begin Object Class=WeaponCamo Name=M9_Silver
		Index=0
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-SlideSilverShine',Index=3,Index=2,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.T9CN.T9CN-MiscSilverShine',Index=4,Index=4,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=M9_Inox
		Index=1
		CamoName="Inox"
		Weight=30
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
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShine",Index=3,Index=2,PIndex=1)
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
	
	Camos(0)=WeaponCamo'M9_Silver'
	Camos(1)=WeaponCamo'M9_Inox'
	Camos(2)=WeaponCamo'M9_BlackWorn'
	Camos(3)=WeaponCamo'M9_BlackWood'
	Camos(4)=WeaponCamo'M9_Tan'
	Camos(5)=WeaponCamo'M9_TwoTone'
	Camos(6)=WeaponCamo'M9_Toy'
	Camos(7)=WeaponCamo'M9_Gold'
}