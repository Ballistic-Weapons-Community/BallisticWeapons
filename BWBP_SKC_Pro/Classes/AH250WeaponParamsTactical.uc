class AH250WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=60
        HeadMult=2
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
        PenetrationEnergy=16
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.5
		Recoil=512.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.40000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_208
		TraceRange=(Min=7500.000000,Max=7500.000000)
        DecayRange=(Min=1050,Max=2100)
		RangeAtten=0.67
		Damage=60
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
        PenetrationEnergy=16
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.5
		Recoil=512.000000
		Chaos=0.350000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_208
		FireInterval=0.400000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_208'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.02),(InVal=0.7,OutVal=-0.06),(InVal=1.0,OutVal=0.0)))
		ViewBindFactor=0.5
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=6144.000000
		DeclineDelay=0.65
		DeclineTime=1
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_208
        XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.03),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.00),(InVal=0.7,OutVal=0.03),(InVal=1.0,OutVal=0.00)))
        ViewBindFactor=0.5
        XRandFactor=0.100000
        YRandFactor=0.100000
        MaxRecoil=6144.000000
        DeclineDelay=0.65
        DeclineTime=1
    End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=1
		AimSpread=(Min=128,Max=512)
		ChaosDeclineTime=0.60000
        ChaosSpeedThreshold=300
	End Object
	
    Begin Object Class=AimParams Name=TacticalAimParams_208
        ADSMultiplier=0.5
        AimSpread=(Min=128,Max=512)
        ChaosDeclineTime=0.60000
        ChaosSpeedThreshold=300
    End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout core
		LayoutName="Scoped Marksman"
		Weight=10
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=1f)
		SightOffset=(X=70.000000,Y=-7.350000,Z=45.400002)
		ViewOffset=(X=15.000000,Y=24.000000,Z=-37.000000)
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		
		//Function
		InventorySize=4
		SightMoveSpeedFactor=0.4
		SightingTime=0.5
		DisplaceDurationMult=0.75
		MagAmmo=7
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="Red Dot Sight"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=0.000000,Y=-7.350000,Z=45.400002)
		ViewOffset=(X=15.000000,Y=12.000000,Z=-37.000000)
		ZoomType=ZT_Irons
		
		//Function
		InventorySize=3
        SightMoveSpeedFactor=0.65
		SightingTime=0.2
		DisplaceDurationMult=0.5
		MagAmmo=7
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_208'
        AimParams(0)=AimParams'TacticalAimParams_208'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_208'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Laser
		//Layout core
		LayoutName="Laser Sight"
		LayoutTags="laser"
		Weight=30
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="RedDotSight",Slot=54,Scale=0f)
		WeaponBoneScales(1)=(BoneName="LAM",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Compensator",Slot=56,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Scope",Slot=57,Scale=0f)
		SightOffset=(X=-20.000000,Y=-7.350000,Z=41.700000)
		ViewOffset=(X=15.000000,Y=12.000000,Z=-37.000000)
		ZoomType=ZT_Irons
		
		//Function
		InventorySize=3
        SightMoveSpeedFactor=0.65
		SightingTime=0.2
		DisplaceDurationMult=0.5
		MagAmmo=7
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_208'
		AimParams(0)=AimParams'TacticalAimParams_208'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_208'
	End Object
	
	//Camos
	Begin Object Class=WeaponCamo Name=Eagle_Silver
		Index=0
		CamoName="Black" //Needs to be updated in assets to silver
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Black
		Index=1
		CamoName="Black"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-BlackShine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-MiscBlack",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-Scope",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-FrontBlack",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen",Index=5)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_TwoTone
		Index=2
		CamoName="Two-Tone"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-TwoToneShine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-MiscBlack",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-Scope",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-FrontBlack",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen",Index=5)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Chromed
		Index=3
		CamoName="Chromed"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SilverShine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-MiscBlack",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-ScopeRed",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-FrontSilver",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen",Index=5)
	End Object
	
	Begin Object Class=WeaponCamo Name=Eagle_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SilverShine",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-MiscBlack",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-ScopeRed",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-FrontSilver",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen",Index=5)
	End Object
	
    Layouts(0)=WeaponParams'TacticalParams_Laser'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
    Layouts(2)=WeaponParams'TacticalParams_Scope'

	Camos(0)=WeaponCamo'Eagle_Silver' //Silver
	Camos(1)=WeaponCamo'Eagle_Black' //Black
	Camos(2)=WeaponCamo'Eagle_TwoTone' //Two-Tone
	Camos(3)=WeaponCamo'Eagle_Chromed' //Silver Fancy
	Camos(4)=WeaponCamo'Eagle_Gold' //Gold'
}