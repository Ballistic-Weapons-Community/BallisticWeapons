class MarlinWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=80 // ?
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=1536.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Quick
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//Gauss
	Begin Object Class=InstantEffectParams Name=TacticalGaussEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=100
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMarlinRifle_Gauss'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead_Gauss'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle_Gauss'
		PenetrateForce=20
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=0.000000
		Recoil=1536.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-GFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalGaussFireParams
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalGaussEffectParams'
	End Object
	
	//Carbine
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Carbine
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=80 // ?
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=1536.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-HFire',Volume=1.600000) //
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Carbine
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Carbine'
	End Object
		
	//Supp
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Supp
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=80 // ?
        HeadMult=2.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		Recoil=1336.000000 //
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.800000 //
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-SFire',Volume=1.100000,Radius=192.000000,bAtten=True) //
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Supp
		FireInterval=1.100000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		AimedFireAnim="SightFireCock"
		FireEndAnim=
		FireAnimRate=0.900000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Supp'
	End Object
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.3
		ADSViewBindFactor=0.7
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.12)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		MaxRecoil=8192
		ClimbTime=0.08
		DeclineDelay=0.25
		DeclineTime=1
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.3
		ADSViewBindFactor=1 //
		EscapeMultiplier=1.0 //
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.12)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		MaxRecoil=8192
		ClimbTime=0.08
		DeclineDelay=0.25
		DeclineTime=1
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineDelay=1.000000
		ChaosDeclineTime=0.650000
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		ADSViewBindFactor=1 //
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineDelay=1.000000
		ChaosDeclineTime=0.650000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Iron Sights"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		//Attachments
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		//ADS
		SightOffset=(X=6.000000,Y=-0.040000,Z=2.850000)
		SightPivot=(Pitch=0)
		SightingTime=0.40
        SightMoveSpeedFactor=0.45
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Quick'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Gauss
		//Layout core
		LayoutName="Gauss Mod"
		LayoutTags="gauss"
		Weight=5
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		//Attachments
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=1f)
		//ADS
		SightOffset=(X=6.000000,Y=-0.060000,Z=6.300000)
		SightPivot=(Pitch=128)
		SightingTime=0.40
        SightMoveSpeedFactor=0.45
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Accelerated Shot",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalGaussFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_AdvSupp
		//Layout core
		LayoutName="Tac Supp"
		LayoutTags="laser"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		ViewOffset=(X=0,Y=10.00000,Z=-10.000000)
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MarlinIvory'
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Suppressor",Slot=20,Scale=1f)
		//ADS
		SightOffset=(X=20.000000,Y=-0.020000,Z=3.650000)
		SightPivot=(Pitch=0)
		SightingTime=0.40
		SightMoveSpeedFactor=0.45
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Supp'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_AdvScope
		//Layout core
		LayoutName="Tac 4X Scope"
		LayoutTags="laser"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		ViewOffset=(X=0,Y=10.00000,Z=-10.000000)
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MarlinIvory'
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Suppressor",Slot=20,Scale=-1f)
		//Zoom
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=4
		//ADS
		SightMoveSpeedFactor=0.350000
		SightingTime=0.450000
		SightOffset=(X=30.000000,Y=0.000000,Z=9.400000)
		SightPivot=(Pitch=0)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
        AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Carbine'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Gauss'
	Layouts(2)=WeaponParams'TacticalParams_AdvSupp'
	Layouts(3)=WeaponParams'TacticalParams_AdvScope'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=Deer_Wood
		Index=0
		CamoName="Wood"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Redwood
		Index=1
		CamoName="Redwood"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.MarlinK-Shiny",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Orange
		Index=2
		CamoName="Tiger"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.DeermasterOrange-Main-Shine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Gold
		Index=3
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.MarlinGold-Shine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_AdvBlack
		Index=4
		CamoName="Blued"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_Black_SH',Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_ammo_SH',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_glass_SH',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=FinalBlend'BW_Core_WeaponTex.Marlin.Ivory_UT2_beam_FB',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_RED_SH',Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_AdvCarbon
		Index=5
		CamoName="Carbon"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.Ivory_UT2_Carbon_SH",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_ammo_SH',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_glass_SH',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=FinalBlend'BW_Core_WeaponTex.Marlin.Ivory_UT2_beam_FB',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_RED_SH',Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_AdvGold
		Index=6
		CamoName="Gold"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.Ivory_UT2_body_SH",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_ammo_SH',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_glass_SH',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=FinalBlend'BW_Core_WeaponTex.Marlin.Ivory_UT2_beam_FB',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.Marlin.Ivory_UT2_RED_SH',Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'Deer_Wood'
	Camos(1)=WeaponCamo'Deer_Redwood'
	Camos(2)=WeaponCamo'Deer_Orange'
	Camos(3)=WeaponCamo'Deer_Gold'
	Camos(4)=WeaponCamo'Deer_AdvBlack'
	Camos(5)=WeaponCamo'Deer_AdvCarbon'
	Camos(6)=WeaponCamo'Deer_AdvGold'
}