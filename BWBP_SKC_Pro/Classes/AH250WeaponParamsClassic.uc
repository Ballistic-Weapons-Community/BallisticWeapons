class AH250WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Compensated
		TraceRange=(Min=8000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=80
		HeadMult=1.4375
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
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Compensated
		FireInterval=0.550000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Compensated'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=80
		HeadMult=1.4375
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
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Volume=4.100000)
		Recoil=4096.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.550000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams_Compensated
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.600000
		YRandFactor=0.900000
		MaxRecoil=7168.000000
		DeclineTime=1.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.550000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		MaxRecoil=8192.000000
		DeclineTime=0.600000
		DeclineDelay=0.200000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================
	
	Begin Object Class=AimParams Name=ClassicAimParams_Compensated //heavy pistol handling
		AimSpread=(Min=128,Max=2900) //comp
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		JumpChaos=0.300000 //comp
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000 //comp
		ChaosSpeedThreshold=950.000000
		//ChaosSpeedThreshold=1400.000000
	End Object
	
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=96,Max=2900)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		JumpChaos=0.250000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=950.000000
		//ChaosDeclineTime=0.500000
		//ChaosSpeedThreshold=1400.000000
	End Object
    
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams_Laser
		//Layout core
		LayoutName="Laser Sight"
		LayoutTags="laser"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-3.750000,Y=-2.76,Z=15.640000)
		ViewOffset=(X=-6.000000,Y=19.500000,Z=-30.000000)
		ZoomType=ZT_Irons
		
		//Function
        InventorySize=5
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RDS
		//Layout core
		LayoutName="Red Dot Sight"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		ZoomType=ZT_Irons
		SightOffset=(X=-3.750000,Y=-2.76,Z=17.03)
		ViewOffset=(X=-6.000000,Y=19.500000,Z=-30.000000)
		
		//Function
        InventorySize=5
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_ScopeComp
		//Layout core
		LayoutName="Scoped Marksman"
		Weight=10
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=1f)
		SightOffset=(X=26.25000000,Y=-2.76,Z=17.0)
		ViewOffset=(X=-6.000000,Y=19.500000,Z=-30.000000)
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		
		//Function
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_Compensated'
		AimParams(0)=AimParams'ClassicAimParams_Compensated'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Compensated'
	End Object

	Layouts(0)=WeaponParams'ClassicParams_Laser'
	Layouts(1)=WeaponParams'ClassicParams_RDS'
	Layouts(2)=WeaponParams'ClassicParams_ScopeComp'
	
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