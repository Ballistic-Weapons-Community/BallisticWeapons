class AH250WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//.44 comp
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=48
		RangeAtten=0.67
		Damage=50
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=1536.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.40000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//.44
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_208
		TraceRange=(Min=7500.000000,Max=7500.000000)
        DecayRange=(Min=1050,Max=2100)
		PenetrationEnergy=48
		RangeAtten=0.67
		Damage=50
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=1536.000000
		Chaos=0.350000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_208
		FireInterval=0.400000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_208'
	End Object

	//.50
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_50
		TraceRange=(Min=7500.000000,Max=7500.000000)
        DecayRange=(Min=1050,Max=2100)
		PenetrationEnergy=48
		RangeAtten=0.67
		Damage=60 //
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=1836.000000 //
		Chaos=0.350000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Eagle.Eagle50-Fire',Volume=5.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_50
		FireInterval=0.550000 //
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_50'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.02),(InVal=0.7,OutVal=-0.06),(InVal=1.0,OutVal=0.0)))
		ViewBindFactor=0.5
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=8192.000000
		ClimbTime=0.1
		DeclineDelay=0.3
        DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
	End Object
	
    Begin Object Class=RecoilParams Name=ArenaRecoilParams_208
        XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.03),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.00),(InVal=0.7,OutVal=0.03),(InVal=1.0,OutVal=0.00)))
        ViewBindFactor=0.5
        XRandFactor=0.100000
        YRandFactor=0.100000
        MaxRecoil=8192.000000
		ClimbTime=0.1
		DeclineDelay=0.3
        DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.25
    End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		AimSpread=(Min=16,Max=256)
		ChaosDeclineTime=0.60000
	End Object
	
	Begin Object Class=AimParams Name=ArenaAimParams_208
        ADSMultiplier=1
        AimSpread=(Min=16,Max=128)
        ChaosDeclineTime=0.60000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout core
		LayoutName=".44 Marksman"
		Weight=10

		//Function
		InventorySize=4
		DisplaceDurationMult=0.75
		MagAmmo=8
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		ViewOffset=(X=5.00,Y=10.00,Z=-6.00)
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=1f)

		// ADS handling
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000

		// Zoom
        ZoomType=ZT_Fixed
		MaxZoom=3
		SightOffset=(X=18.5000000,Y=0,Z=2.75)
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		LayoutName=".44 RDS"
		Weight=10
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-11,Y=0,Z=2.78)
		ZoomType=ZT_Irons
		
		//Function
		PlayerJumpFactor=1.000000
		InventorySize=3
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=0.5
		MagAmmo=8
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		ViewOffset=(X=5.00,Y=10.00,Z=-6.00)
		
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_208'
        AimParams(0)=AimParams'ArenaAimParams_208'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_208'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Laser
		//Layout core
		LayoutName=".44 Laser"
		LayoutTags="laser"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-11,Y=0,Z=1.39)
		ZoomType=ZT_Irons
		
		PlayerJumpFactor=1.000000
		InventorySize=3
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=0.5
		MagAmmo=8
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		ViewOffset=(X=5.00,Y=10.00,Z=-6.00)
		
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_208'
        AimParams(0)=AimParams'ArenaAimParams_208'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_208'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_50
		//Layout core
		LayoutName=".50"
		Weight=10
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-11,Y=0,Z=1.39)
		ZoomType=ZT_Irons
		
		PlayerJumpFactor=1.000000
		InventorySize=3
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=0.5
		MagAmmo=7
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		ViewOffset=(X=5.00,Y=10.00,Z=-6.00)
		
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_208'
        AimParams(0)=AimParams'ArenaAimParams_208'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_50'
    End Object 

    Layouts(0)=WeaponParams'ArenaParams_Laser'
    Layouts(1)=WeaponParams'ArenaParams_RDS'
    Layouts(2)=WeaponParams'ArenaParams_Scope'
    Layouts(3)=WeaponParams'ArenaParams_50'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=Eagle_Silver
		Index=0
		CamoName="Silver"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-MainShine',Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Front',Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Black
		Index=1
		CamoName="Black"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-BlackShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MiscBlack",Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-Scope",Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-FrontBlack",Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_TwoTone
		Index=2
		CamoName="Two-Tone"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-TwoToneShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MiscBlack",Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-Scope",Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-FrontBlack",Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Chromed
		Index=3
		CamoName="Chromed"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-SilverShine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc',Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed',Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-FrontSilver",Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MainGold-Shine",Index=1,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-MagGold-Shine",Index=2,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-ScopeGold",Index=3,AIndex=3,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.EagleCamos.Eagle-FrontGold-Shine",Index=4,AIndex=4,PIndex=1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen',Index=5,AIndex=5,PIndex=-1)
	End Object

	Camos(0)=WeaponCamo'Eagle_Silver' //Silver
	Camos(1)=WeaponCamo'Eagle_Black' //Black
	Camos(2)=WeaponCamo'Eagle_TwoTone' //Two-Tone
	Camos(3)=WeaponCamo'Eagle_Chromed' //Silver Fancy
	Camos(4)=WeaponCamo'Eagle_Gold' //Gold'
}