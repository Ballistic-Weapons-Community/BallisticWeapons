class MarlinWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=180.0
		DecayRange=(Min=1500.0,Max=6000.0)
		Damage=112.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=15.000000
		PenetrateForce=80
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
		Recoil=1536.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=9)
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=3.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Quick
		FireInterval=1.000000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		AimedFireAnim="SightFireCock"
		FireEndAnim=
		FireAnimRate=1.150000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Gauss
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Gauss
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=180.0
		DecayRange=(Min=1500.0,Max=6000.0)
		Damage=132.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=15.000000
		PenetrateForce=80
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-GFire',Volume=1.300000)
		Recoil=1836.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=9)
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Gauss
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=3.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Gauss'
	End Object
	
	//Carbine
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Carbine
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=180.0
		DecayRange=(Min=1500.0,Max=6000.0)
		Damage=112.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=15.000000
		PenetrateForce=80
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-HFire',Volume=1.600000) //
		Recoil=1536.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=9)
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Carbine
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=3.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Carbine'
	End Object
	
	//Supp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Supp
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=180.0
		DecayRange=(Min=1500.0,Max=6000.0)
		Damage=112.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=15.000000
		PenetrateForce=80
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.800000 //
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-SFire',Volume=1.100000,Radius=192.000000,bAtten=True) //
		Recoil=1336.000000 //
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8) //
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Supp
		FireInterval=1.100000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		AimedFireAnim="SightFireCock"
		FireEndAnim=
		FireAnimRate=0.900000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Supp'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=72.000000,Max=72.000000)
		WaterTraceRange=5000.0
		Damage=54.0
		HeadMult=2.129629
		LimbMult=0.462962
		DamageType=Class'BallisticProV55.DTMarlinMelee'
		DamageTypeHead=Class'BallisticProV55.DTMarlinMeleeHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinMelee'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.900000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.450000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
		PreFireAnimRate=2.000000
		FireAnimRate=2.500000
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1536.000000
		DeclineTime=0.500000
		DeclineDelay=0.200000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1536.000000
		DeclineTime=0.500000
		DeclineDelay=0.200000
		ViewBindFactor=0.300000
		ADSViewBindFactor=1 //
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.200000
		SprintOffSet=(Pitch=-3072,Yaw=-5120)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000)
		FallingChaos=0.100000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
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
		SightMoveSpeedFactor=0.500000
		SightingTime=0.22
		SightOffset=(X=6.000000,Y=-0.040000,Z=2.850000)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		InventorySize=7
		MagAmmo=7
		bMagPlusOne=True
		WeaponName="Redwood 7000 .400 'Bearmaster' (Gauss)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Quick'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Gauss
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
		SightMoveSpeedFactor=0.5
		SightingTime=0.22
		SightOffset=(X=6.000000,Y=-0.020000,Z=5.500000)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Accelerated Shot",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		InventorySize=7
		MagAmmo=7
		bMagPlusOne=True
		WeaponName="Redwood 7000 .400 'Bearmaster'"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Gauss'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_AdvSupp
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
		SightMoveSpeedFactor=0.5
		SightingTime=0.22
		SightOffset=(X=20.000000,Y=-0.020000,Z=3.650000)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		InventorySize=7
		MagAmmo=7
		bMagPlusOne=True
		WeaponName="Redwood 7000 .400 'Bearmaster' (Sil)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_AdvScope
		//Layout core
		LayoutName="Tac Scope"
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
		SightMoveSpeedFactor=0.500000
		SightingTime=0.27 //
		SightOffset=(X=30.000000,Y=0.000000,Z=9.400000)
		SightPivot=(Pitch=0)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		InventorySize=7
		MagAmmo=7
		bMagPlusOne=True
		WeaponName="Redwood 7000 .400 'Bearmaster' (4X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Carbine'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Gauss'
	Layouts(2)=WeaponParams'RealisticParams_AdvSupp'
	Layouts(3)=WeaponParams'RealisticParams_AdvScope'
	
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