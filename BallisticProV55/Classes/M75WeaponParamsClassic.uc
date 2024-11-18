class M75WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=20000.000000,Max=20000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=325.0
		HeadMult=1.1
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		PenetrationEnergy=1280.000000
		PenetrateForce=700
		bPenetrate=True
		PDamageFactor=0.95
		WallPDamageFactor=0.7
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=350.000000)
		Recoil=3072.000000
		Chaos=-1.0
		PushbackForce=1300.000000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
        TargetState="ClassicRail"
		AimedFireAnim="SightFire"
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.400000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=2560)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.400000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-8000,Yaw=-10000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.500000
		ChaosTurnThreshold=100000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="X-Ray Scope"
		Weight=70
		//Visual
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		//Stats
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.750000
		InventorySize=14
		SightMoveSpeedFactor=0.500000
		SightingTime=0.8000
		bNeedCock=True
		MagAmmo=7
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ZoomType=ZT_Logarithmic
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
		ViewOffset=(X=-6,Y=8,Z=-3)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Irons
		//Layout core
		LayoutName="X75 Irons"
		Weight=5
		//Visual
		AllowedCamos(0)=2
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		SightOffset=(X=15.000000,Z=0)
		ZoomType=ZT_Irons
		//Stats
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.750000
		InventorySize=14
		SightMoveSpeedFactor=0.500000
		SightingTime=0.35000
		bNeedCock=True
		MagAmmo=7
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ViewOffset=(X=-6,Y=8,Z=-3)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Irons' //Prototype
	//Layouts(2)=WeaponParams'ClassicParams-Arctic'
	//Orange DDPAT
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M75_Standard
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M75_Winter
		Index=1
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Main-S1",Index=3,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Main2-S1",Index=4,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Clip-D1",Index=2,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Scope-S1",Index=1,AIndex=3,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M75_Prototype
		Index=2
		CamoName="Prototype"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BW_Core_WeaponTex.M75.M75_SKPart1_Shine",Index=3,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BW_Core_WeaponTex.M75.M75_SKPart2_Shine",Index=4,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'M75_Standard'
	Camos(1)=WeaponCamo'M75_Winter'
	Camos(2)=WeaponCamo'M75_Prototype'
}