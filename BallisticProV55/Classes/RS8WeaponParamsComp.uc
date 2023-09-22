class RS8WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10mm
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		PenetrationEnergy=16
		RangeAtten=0.5
		Damage=25
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=360.000000
		Chaos=0.250000
		BotRefireRate=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.20000
		FireEndAnim=
		//AimedFireAnim='SightFire'
		FireAnimRate=2	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//10mm Super
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Heavy
		TraceRange=(Min=4000,Max=4000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=16
        RangeAtten=0.67
		Damage=35 //+10
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=512.000000
		Chaos=0.250000
		BotRefireRate=0.750000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Pistol.RS8-HFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Heavy
		FireInterval=0.25000
		FireEndAnim=
		//AimedFireAnim='SightFire'
		FireAnimRate=1.3	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Heavy'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="Laser"
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object	
	
	//Stab
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams_TacKnife
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
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_TacKnife
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Stab"
		FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams_TacKnife'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.05
		DeclineDelay=0.240000
		DeclineTime=0.75
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Suppressable"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.200000
		SightOffset=(X=-43,Y=-1.4,Z=13.4)
		SightPivot=(Pitch=-200,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		ViewOffset=(X=20.00,Y=10.00,Z=-8.00)
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.33
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_TacKnife
		//Layout core
		LayoutName="Arena Knife"
		LayoutTags="tacknife"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_RS8Melee'
		ViewOffset=(X=20.00,Y=10.00,Z=-8.00)
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.200000
		SightOffset=(X=-30,Y=0.26,Z=3.5)
		SightPivot=(Pitch=0,Roll=0)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		//Functions
		bDualBlocked=true
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.33
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_TacKnife'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Heavy
		//Layout core
		LayoutName="HV Ammo + RDS"
		LayoutTags="comp"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_RS8Heavy'
		ViewOffset=(X=0.000000,Y=10.000000,Z=-10.000000)
		AllowedCamos(0)=5
		//ADS
		SightMoveSpeedFactor=0.900000
		SightingTime=0.200000
		SightOffset=(X=0,Y=-2,Z=21.8)
		SightPivot=(Pitch=0,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		//Functions
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.33
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Heavy'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_TacKnife'
    Layouts(2)=WeaponParams'ArenaParams_Heavy'
	
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
	
	Camos(0)=WeaponCamo'RS8_Silver'
	Camos(1)=WeaponCamo'RS8_Gray'
	Camos(2)=WeaponCamo'RS8_Black'
	Camos(3)=WeaponCamo'RS8_Rainbow'
	Camos(4)=WeaponCamo'RS8_Gold'
	Camos(5)=WeaponCamo'RS45_Silver'
}