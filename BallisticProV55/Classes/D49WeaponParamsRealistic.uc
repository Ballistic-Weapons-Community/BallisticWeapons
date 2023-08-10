class D49WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.5
		DecayRange=(Min=1200.0,Max=6000.0)
		Damage=65.0
		HeadMult=2.3
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTD49Revolver'
		DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
		PenetrationEnergy=14.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-FireSingle',Pitch=1.100000,Volume=1.100000)
		Recoil=1280.000000
		Chaos=0.120000
		Inaccuracy=(X=6,Y=6)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireAnim="FireSingle"
		FireEndAnim=
		FireAnimRate=1.800000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.5
		DecayRange=(Min=1200.0,Max=6000.0)
		Damage=130.0
		HeadMult=2.3f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTD49Revolver'
		DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
		PenetrationEnergy=14.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Fire',Volume=1.300000)
		Recoil=1920.000000
		Chaos=0.200000
		Inaccuracy=(X=6,Y=6)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.750000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3072.000000
		DeclineTime=0.700000
		DeclineDelay=0.200000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3072.000000
		DeclineTime=0.700000
		DeclineDelay=0.200000
		ViewBindFactor=1.000000
		ADSViewBindFactor=0.400000
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
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=675.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout
		LayoutName="Laser"
		Weight=30
		WeaponPrice=1800
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15000
		SightOffset=(X=-11,Y=-4.6,Z=25.5)
		SightPivot=(Pitch=350,Yaw=-48,Roll=-500)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=2000)
		WristAdjust=(Yaw=-2500,Pitch=-0000)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=6
		ViewOffset=(X=10,Y=22,Z=-16)
		WeaponName="D49 .44 Magnum Revolver"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Scope
		//Layout
		LayoutName="4X Scope"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		//Zoom
		MaxZoom=4
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		SightOffset=(X=50,Y=-0.5,Z=10)
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		bAdjustHands=false
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=3
		MagAmmo=6
		ViewOffset=(X=10,Y=22,Z=-16)
		WeaponName="D49 .44 Magnum Revolver (4X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Scope'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=D49_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=D49_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.D49Camos.D49Black-Shine",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Camos(0)=WeaponCamo'D49_Silver'
	Camos(1)=WeaponCamo'D49_Black'
}