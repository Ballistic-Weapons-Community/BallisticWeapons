class D49WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaFireEffectParams
        DecayRange=(Min=788,Max=1838)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=16
        Damage=45.000000
        HeadMult=3
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
        Inaccuracy=(X=48,Y=48)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-FireSingle',Volume=1.200000)
        WarnTargetPct=0.4
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaFireParams
        FireAnim="FireSingle"
        FireEndAnim=
        FireInterval=0.4
        //AimedFireAnim="SightFire"
        FireEffectParams(0)=InstantEffectParams'ArenaFireEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaAltFireEffectParams
        DecayRange=(Min=788,Max=1838)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=16.000000
        Damage=90.000000
        HeadMult=2
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
        Inaccuracy=(X=48,Y=48)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Fire',Volume=1.300000)
        WarnTargetPct=0.5
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaAltFireParams
        FireEndAnim=
        FireInterval=0.9
        AmmoPerFire=2
        FireEffectParams(0)=InstantEffectParams'ArenaAltFireEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.5,OutVal=0.03),(InVal=1,OutVal=0.07)))
		ViewBindFactor=0.65
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192
		ClimbTime=0.1
		DeclineDelay=0.40000
		DeclineTime=1
		CrouchMultiplier=1
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=378)
		JumpChaos=0.750000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout
		LayoutName="Laser"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.9
        SightingTime=0.200000
		SightOffset=(X=-11,Y=-4.6,Z=25.5)
		SightPivot=(Pitch=350,Yaw=-48,Roll=-500)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=2000)
		WristAdjust=(Yaw=-2500,Pitch=-0000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
        DisplaceDurationMult=0.5
        MagAmmo=6
        InventorySize=3
		ViewOffset=(X=10,Y=22,Z=-16)
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Scope
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
		SightMoveSpeedFactor=0.600000
		SightingTime=0.4
		SightOffset=(X=50,Y=-0.5,Z=10)
		SightPivot=(Pitch=0,Yaw=0,Roll=0)
		bAdjustHands=false
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
        DisplaceDurationMult=0.5
        MagAmmo=6
        InventorySize=3
		ViewOffset=(X=10,Y=22,Z=-16)
		bDualBlocked=True
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Scope'
	
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