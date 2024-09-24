class M75WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=3072.000000
		Chaos=0.750000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		Damage=200
        HeadMult=1.75
        LimbMult=0.85
		PushbackForce=350.000000
	    DamageType=Class'BallisticProV55.DTM75Railgun'
        DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM75Railgun'		
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Volume=0.750000,Radius=384.000000)
	End Object
	
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        TargetState="ChargedRail"
		AimedFireAnim="SightFire"
		FireInterval=1.500000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		Recoil=4096.000000
		Chaos=0.750000
		Damage=200
        HeadMult=1.75
        LimbMult=0.85
		BotRefireRate=0.3
		WarnTargetPct=0.75
		PushbackForce=1300.000000
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=768.000000)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.50000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.15)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		ClimbTime=0.15
		DeclineDelay=0.25
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=2
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-3072,Yaw=-3072)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		JumpChaos=0.800000
		AimSpread=(Min=512,Max=2560)
		AimAdjustTime=0.8
		ChaosDeclineTime=0.800000
		ADSMultiplier=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="X-Ray Scope"
		Weight=70
		//Visual
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		//ADS
		SightMoveSpeedFactor=0.35
		SightingTime=0.55	
		ScopeScale=0.6
		// sniper 5-10x
        ZoomType=ZT_Logarithmic
		MinZoom=5
		MaxZoom=10
		ZoomStages=1
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
		//Stats
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
        MagAmmo=5
        InventorySize=10
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Prototype
		//Layout core
		LayoutName="X75 Prototype"
		Weight=5
		//Visual
		AllowedCamos(0)=2
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.35
		SightingTime=0.50 //	
		SightOffset=(X=15.000000,Z=0)
		ZoomType=ZT_Irons
		//Stats
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
        MagAmmo=5
        InventorySize=10
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Prototype'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75_SKPart1_Shine",Index=3,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75_SKPart2_Shine",Index=4,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'M75_Standard'
	Camos(1)=WeaponCamo'M75_Winter'
	Camos(2)=WeaponCamo'M75_Prototype'
}