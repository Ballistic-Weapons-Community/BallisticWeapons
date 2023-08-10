class AH250WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//.44
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=62
		HeadMult=1.5
		LimbMult=0.375
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		//FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Pitch=0.900000,Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Pitch=0.900000,Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=1.300000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//.50
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_50
		TraceRange=(Min=8000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=70 //
		HeadMult=1.5
		LimbMult=0.375
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Eagle.Eagle50-Fire',Volume=5.500000)
		Recoil=2548.000000 //
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_50
		FireInterval=0.400000 //
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireAnimRate=1.100000	//
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_50'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Compensated
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.600000
		YRandFactor=0.900000
		YawFactor=0.200000
		MaxRecoil=7168.000000
		DeclineTime=1.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.000000)))
		YawFactor=0.400000
		XRandFactor=1
		YRandFactor=1
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object


	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=RealisticAimParams_Compensated
		AimSpread=(Min=668,Max=2900) //Comp
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000 //Comp
		ChaosSpeedThreshold=1400.000000
	End Object
    
	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=650,Max=2900)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.250000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1400.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams_Scope
		//Layout core
		LayoutName=".44 Marksman"
		Weight=10
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=1f)
		
		//ADS
		SightOffset=(X=18.5000000,Y=0,Z=2.75)
		MaxZoom=3
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		SightingTime=0.300000
		SightMoveSpeedFactor=0.500000
		
		//Function
		bDualBlocked=True
		InventorySize=3 //4 in future
		WeaponPrice=2000
		MagAmmo=8
		ViewOffset=(X=1.000000,Y=5.000000,Z=-1.800000)
		WeaponName="AH250 .44 Handgun (3X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Compensated'
		AimParams(0)=AimParams'RealisticAimParams_Compensated'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName=".44 RDS"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		
		//ADS
		SightOffset=(X=-11,Y=0,Z=2.78)
		ZoomType=ZT_Irons
		SightingTime=0.250000
		SightMoveSpeedFactor=0.500000
		
		//Function
		bDualBlocked=True
		InventorySize=3
		WeaponPrice=2000
		MagAmmo=8
		ViewOffset=(X=1.000000,Y=5.000000,Z=-1.800000)
		WeaponName="AH250 .44 Handgun (RDS)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=RealisticParams_Laser
		//Layout core
		LayoutName=".44 Laser"
		LayoutTags="laser"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		
		//ADS
		SightOffset=(X=-11,Y=0,Z=1.39)
		ZoomType=ZT_Irons
		SightingTime=0.250000
		SightMoveSpeedFactor=0.500000
		
		//Function
		InventorySize=3
		WeaponPrice=2000
		MagAmmo=8
		ViewOffset=(X=1.000000,Y=5.000000,Z=-1.800000)
		WeaponName="AH250 .44 Scoped Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=RealisticParams_50
		//Layout core
		LayoutName=".50"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-11,Y=0,Z=1.39)
		ZoomType=ZT_Irons
		SightingTime=0.250000
		
		//Function
		InventorySize=3
		WeaponPrice=2000
		SightMoveSpeedFactor=0.500000
		MagAmmo=7
		ViewOffset=(X=1.000000,Y=5.000000,Z=-1.800000)
		WeaponName="AH250 .50 Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_50'
	End Object

	Layouts(0)=WeaponParams'RealisticParams_Scope'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	Layouts(2)=WeaponParams'RealisticParams_Laser'
	Layouts(3)=WeaponParams'RealisticParams_50'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=Eagle_Silver
		Index=0
		CamoName="Silver"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Scope',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Front',Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Black
		Index=1
		CamoName="Black"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-BlackShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Scope',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontBlack',Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_TwoTone
		Index=2
		CamoName="Two-Tone"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-TwoToneShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Scope',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontBlack',Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Chromed
		Index=3
		CamoName="Chromed"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SilverShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed',Index=3),AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontSilver',Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MainGold-Shine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MagGold-Shine",Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-FrontGold-Shine",Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object

	Camos(0)=WeaponCamo'Eagle_Silver' //Silver
	Camos(1)=WeaponCamo'Eagle_Black' //Black
	Camos(2)=WeaponCamo'Eagle_TwoTone' //Two-Tone
	Camos(3)=WeaponCamo'Eagle_Chromed' //Silver Fancy
	Camos(4)=WeaponCamo'Eagle_Gold' //Gold'
}