class RS8WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//.40
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=30 // .40
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
        PenetrationEnergy=16
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=360.000000
		Chaos=0.250000
		BotRefireRate=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.140000 //.2
		FireEndAnim=
		//AimedFireAnim='SightFire'
		FireAnimRate=1	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//10mm Auto
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Heavy
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=40 // 10mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
        PenetrationEnergy=16
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=666.000000
		Chaos=0.350000
		BotRefireRate=0.750000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Pistol.RS8-HFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Heavy
		FireInterval=0.18000 //.28
		FireEndAnim=
		//AimedFireAnim='SightFire'
		FireAnimRate=1	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Heavy'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="Laser"
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=80.0
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
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.05
		DeclineDelay=0.240000
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="10mm Suppressable"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//ADS
		SightingTime=0.17
        SightMoveSpeedFactor=0.6
		SightOffset=(X=-43,Y=-1.4,Z=13.4)
		SightPivot=(Pitch=-200,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		ViewOffset=(X=20.000000,Y=7.000000,Z=-8.000000)
		bDualBlocked=True
		DisplaceDurationMult=0.33
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 	

	Begin Object Class=WeaponParams Name=TacticalParams_TacKnife
		//Layout core
		LayoutName="10mm Tac Knife"
		LayoutTags="tacknife"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Melee_FPm'
		ViewOffset=(X=20.000000,Y=7.000000,Z=-8.000000)
		//ADS
		SightingTime=0.17
        SightMoveSpeedFactor=0.6
		SightOffset=(X=-30,Y=0.26,Z=3.5)
		SightPivot=(Pitch=0,Roll=0)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Functions
		bDualBlocked=true
		DisplaceDurationMult=0.33
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_TacKnife'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Heavy
		//Layout core
		LayoutName="HV Ammo + RDS"
		LayoutTags="comp"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Heavy_FPm'
		ViewOffset=(X=0.000000,Y=10.000000,Z=-10.000000)
		AllowedCamos(0)=5
		AllowedCamos(1)=6
		AllowedCamos(2)=7
		//ADS
		SightMoveSpeedFactor=0.600000
		SightingTime=0.17
		SightOffset=(X=0,Y=-2,Z=21.8)
		SightPivot=(Pitch=0,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		bDualBlocked=True
		DisplaceDurationMult=0.33
		MagAmmo=7
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Heavy'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 	
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_TacKnife'
    Layouts(2)=WeaponParams'TacticalParams_Heavy'
	
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