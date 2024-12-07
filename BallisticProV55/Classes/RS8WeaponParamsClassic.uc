class RS8WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Semi
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=2048.000000
		Chaos=0.015000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsBurst
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=30.0
		HeadMult=2.3
		LimbMult=0.3
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
		Recoil=256.000000 //
		Chaos=0.200000 //
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsBurst
		FireInterval=0.070000 //
		BurstFireRateFactor=1.00
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsBurst'
	End Object
	
	//H-Frame
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Heavy
		TraceRange=(Max=6000.000000)
		WaterTraceRange=2250.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=42.0 //10mm Super
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrationEnergy=20.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Pistol.RS8-HFire',Volume=1.500000)
		Recoil=3600.000000
		Chaos=0.015000
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Heavy
		FireInterval=0.250000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Heavy'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		TargetState="Laser"
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams_Scope'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTRS8Stab'
		DamageTypeHead=Class'BallisticProV55.DTRS8Stab'
		DamageTypeArm=Class'BallisticProV55.DTRS8Stab'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsBurst
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=8192)
		AimAdjustTime=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.025000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=11200.000000
		ChaosTurnThreshold=1000000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Suppressable"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		ViewOffset=(X=20.000000,Y=7.000000,Z=-8.000000)
		//ADS
		SightOffset=(X=-43,Y=-1.4,Z=13.4)
		SightPivot=(Pitch=-200,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=14
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_TacKnife
		//Layout core
		LayoutName="Classic Knife"
		LayoutTags="tacknife"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Melee_FPm'
		ViewOffset=(X=21,Y=6,Z=-5)
		//ADS
		SightOffset=(X=-30,Y=0.26,Z=3.5)
		SightPivot=(Pitch=0,Roll=0)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Functions
		bDualBlocked=true
		bDualMixing=false
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=14
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_TacKnife'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Heavy
		//Layout core
		LayoutName="RDS H-Frame"
		LayoutTags="comp"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Heavy_FPm'
		ViewOffset=(X=0.000000,Y=10.000000,Z=-10.000000)
		AllowedCamos(0)=5
		AllowedCamos(1)=6
		AllowedCamos(2)=7
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		SightOffset=(X=0,Y=-2,Z=21.8)
		SightPivot=(Pitch=0,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		PlayerSpeedFactor=1.100000
		InventorySize=3
		bNeedCock=True
		MagAmmo=7
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		bDualMixing=true
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsBurst'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Heavy'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_TacKnife'
	Layouts(2)=WeaponParams'ClassicParams_Heavy'
	
//Camos =====================================
	Begin Object Class=WeaponCamo Name=RS8_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RS8_Gray
		Index=1
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.M1911-Shiny",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=RS8_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.RS8-K-Shiney",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=RS8_Rainbow
		Index=3
		CamoName="Rainbow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.RS8-MainRainbowShine",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=RS8_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.RS8-MainGoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=RS45_Silver
		Index=5
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.RS8.RS8-MainHeavy',Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-RDS-Glow',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-Shiney',Index=3,AIndex=0,PIndex=0)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RS45_Black
		Index=6
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.RS8-MainHeavyBlack",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-RDS-Glow',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-Shiney',Index=3,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=RS45_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS8Camos.RS8-MainHeavyGoldShine",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-RDS-Glow',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.RS8.RS8-Shiney',Index=3,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'RS8_Silver'
	Camos(1)=WeaponCamo'RS8_Gray'
	Camos(2)=WeaponCamo'RS8_Black'
	Camos(3)=WeaponCamo'RS8_Rainbow'
	Camos(4)=WeaponCamo'RS8_Gold'
	Camos(5)=WeaponCamo'RS45_Silver'
	Camos(6)=WeaponCamo'RS45_Black'
	Camos(7)=WeaponCamo'RS45_Gold'
}
