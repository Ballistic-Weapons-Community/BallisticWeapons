class RS8WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//.40
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=3500.000000,Max=3500.000000) //.40
		WaterTraceRange=1500.0
		DecayRange=(Min=800.0,Max=3500.0)
		RangeAtten=0.5
		Damage=37.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Fire1',Pitch=1.100000,Volume=1.50000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=680.000000
		Chaos=0.080000
		Inaccuracy=(X=11,Y=11)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireAnimRate=2.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//10mm
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Heavy
		TraceRange=(Min=4000.000000,Max=4000.000000) //10mm Super
		WaterTraceRange=1500.0
		DecayRange=(Min=800.0,Max=4000.0)
		RangeAtten=0.5
		Damage=50.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.850000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Pistol.RS8-HFire',Volume=1.500000)
		Recoil=1000.000000
		Chaos=0.080000
		Inaccuracy=(X=11,Y=11)
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Heavy
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		FireAnimRate=1.500000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Heavy'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		TargetState=Laser"
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams_TacKnife
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=46.0
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
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.500000
		YawFactor=0.100000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1536.000000
		DeclineTime=0.400000
		DeclineDelay=0.120000
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
		JumpChaos=0.025000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=800.000000
		ChaosTurnThreshold=1000000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName=".40 Suppressed"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		SightOffset=(X=-43,Y=-1.4,Z=13.4)
		SightPivot=(Pitch=-200,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=750
		MagAmmo=14
		bMagPlusOne=True
		ViewOffset=(X=20.00,Y=10.00,Z=-8.00)
		WeaponName="RS8 .40 Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_TacKnife
		//Layout core
		LayoutName=".40 Tac Knife"
		LayoutTags="tacknife"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Melee_FPm'
		ViewOffset=(X=20.00,Y=10.00,Z=-8.00)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.12
		SightOffset=(X=-30,Y=0.26,Z=3.5)
		SightPivot=(Pitch=0,Roll=0)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Stats
		bDualBlocked=true
		PlayerSpeedFactor=1.100000
		InventorySize=3
		WeaponPrice=750
		MagAmmo=14
		bMagPlusOne=True
		WeaponName="RS8 .40 Handgun (Tac Knife)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_TacKnife'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_10mm
		//Layout core
		LayoutName="10mm RDS"
		LayoutTags="comp"
		Weight=10
		WeaponPrice=750
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.RS8Heavy_FPm'
		ViewOffset=(X=0.000000,Y=10.000000,Z=-10.000000)
		AllowedCamos(0)=5
		AllowedCamos(1)=6
		AllowedCamos(2)=7
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.120000
		SightOffset=(X=0,Y=-2,Z=21.8)
		SightPivot=(Pitch=0,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=14
		bMagPlusOne=True
		WeaponName="RS8 10mm Handgun (RDS)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Heavy'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_TacKnife'
	Layouts(2)=WeaponParams'RealisticParams_10mm'
	
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