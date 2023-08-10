class D49WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
	BWA.ModeInfos[1].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalFireEffectParams
        DecayRange=(Min=1050,Max=3150) // 20-60m
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=16
        Damage=55.000000 // .44 Magnum
        HeadMult=3.5
        LimbMult=0.75
        DamageType=Class'BallisticProV55.DTD49Revolver'
        DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
        DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
        RangeAtten=0.5
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=1280.000000
        Chaos=0.400000
        Inaccuracy=(X=128,Y=128)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-FireSingle',Volume=1.200000)
        WarnTargetPct=0.4
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalFireParams
        FireAnim="FireSingle"
        FireEndAnim=
        FireInterval=0.65
        //AimedFireAnim="SightFire"
        FireEffectParams(0)=InstantEffectParams'TacticalFireEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalAltFireEffectParams
        DecayRange=(Min=1050,Max=3150) // 20-60m
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=16
        Damage=110.000000
        HeadMult=3.5
        LimbMult=0.75
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTD49Revolver'
        DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
        DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=2560.000000
        Chaos=0.800000
        Inaccuracy=(X=128,Y=128)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Fire',Volume=1.300000)
        WarnTargetPct=0.5
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalAltFireParams
        FireEndAnim=
        FireInterval=0.9
        AmmoPerFire=2
        FireEffectParams(0)=InstantEffectParams'TacticalAltFireEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.5,OutVal=0.03),(InVal=1,OutVal=0.07)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=8192
		ClimbTime=0.1
		DeclineDelay=0.40000
		DeclineTime=1
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.15
		ADSViewBindFactor=1
		EscapeMultiplier=1
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.5,OutVal=0.03),(InVal=1,OutVal=0.07)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=8192
		ClimbTime=0.1
		DeclineDelay=0.40000
		DeclineTime=1
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0.0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		JumpChaos=0.750000
		ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		ADSViewBindFactor=1
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		JumpChaos=0.750000
		ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout
		LayoutName="Laser"
		Weight=30
		WeaponPrice=1800
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		//ADS
        SightingTime=0.2
        SightMoveSpeedFactor=0.6
		SightOffset=(X=-11,Y=-4.6,Z=25.5)
		SightPivot=(Pitch=350,Yaw=-48,Roll=-500)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=2000)
		WristAdjust=(Yaw=-2500,Pitch=-0000)
		//Stats
        DisplaceDurationMult=0.5
        MagAmmo=6
        InventorySize=3
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalFireParams'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout
		LayoutName="3X Scope"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		//Zoom
		MaxZoom=3
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		//ADS
		SightMoveSpeedFactor=0.35
		SightingTime=0.45
		SightOffset=(X=50,Y=-0.5,Z=10)
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		bAdjustHands=false
		//Stats
        DisplaceDurationMult=0.5
        MagAmmo=6
        InventorySize=3
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalFireParams'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Scope'
	
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