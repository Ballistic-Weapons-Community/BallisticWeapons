class M75WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=200000.000000,Max=200000.000000)
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=350.000000)
		Damage=325.0
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		PenetrationEnergy=2560.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.95
		WallPDamageFactor=0.7
		Recoil=3072.000000
		Chaos=-1.0
		PushbackForce=920.000000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=1.000000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        TargetState="FullChargedRail"
		AimedFireAnim="SightFire"
		FireInterval=0.900000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnimRate=0.300000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		DeclineDelay=0.350000
		ViewBindFactor=0.750000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=900,Max=2308)
		AimAdjustTime=0.450000
		OffsetAdjustTime=0.500000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-5120)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.400000
		ChaosTurnThreshold=100000.000000
		ChaosDeclineTime=1.200000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="X-Ray Scope"
		Weight=70
		//Visual
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		//ADS
		ZoomType=ZT_Logarithmic
		SightMoveSpeedFactor=0.500000
		SightingTime=1.000000
		//Stats
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=10
		MagAmmo=3
		bMagPlusOne=True
		//ReloadAnimRate=1.100000
		//CockAnimRate=1.325000
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
		WeaponName="M75-TIC 20mm Infantry Railgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Proto
		//Layout core
		LayoutName="X75 Prototype"
		Weight=5
		//Visual
		AllowedCamos(0)=2
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		SightOffset=(X=15.000000,Z=0)
		ZoomType=ZT_Irons
		//Stats
		PlayerSpeedFactor=0.770000
		PlayerJumpFactor=0.770000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000 //
		MagAmmo=3
		bMagPlusOne=True
		//ReloadAnimRate=1.100000
		//CockAnimRate=1.325000
		WeaponName="X75-TIC 20mm Infantry Railgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Proto'
	
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