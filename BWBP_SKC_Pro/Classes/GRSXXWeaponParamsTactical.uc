class GRSXXWeaponParamsTactical extends BallisticWeaponParams;

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
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=23 // 9mm
        HeadMult=3.5
        LimbMult=0.75
        DamageType=Class'BallisticProV55.DTGRS9Pistol'
        DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
        FlashScaleFactor=2.500000
        Recoil=270.000000
        Chaos=0.120000
        BotRefireRate=0.99
        WarnTargetPct=0.2
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        FireInterval=0.055000
        FireEndAnim=
		BurstFireRateFactor=1
        //AimedFireAnim='SightFire'
        FireAnimRate=1.700000	
        FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
    End Object
	
	//Amp
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryAmpEffectParams
        TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=1337,Max=2363) // 15-45m
		Inaccuracy=(X=100,Y=100)
        RangeAtten=0.5
        Damage=43 // 9mm
        HeadMult=3.5
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.200000)
		Recoil=340.000000
		Chaos=0.180000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryAmpFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryAmpEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	//Laser
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
        RangeAtten=0.5
		Damage=16
        HeadMult=2
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXLaserHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		PenetrateForce=300
		bPenetrate=True
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.G-Glk-LaserFire',Volume=1.200000)
		Recoil=0.0
		Chaos=0.0
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.080000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object

	//Amp
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Amp
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Amp
		TargetState="AmpAttach"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Amp'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.2
        XCurve=(Points=(,(InVal=0.150000,OutVal=0.09),(InVal=0.300000,OutVal=-0.080000),(InVal=0.4,OutVal=0.04),(InVal=0.550000,OutVal=-0.090000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.00000)))
        YCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.1
		MaxRecoil=8192
		ClimbTime=0.04
		DeclineDelay=0.150000
        DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.5
		MaxMoveMultiplier=1.25
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        SprintChaos=0.050000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Hyper Amp"
		LayoutTags="no_starting_amp,no_combat_laser"
		Weight=30
		//ADS
        SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Stats
        DisplaceDurationMult=0.5
        MagAmmo=33
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		WeaponModes(3)=(ModeName="Amp: Hypermode",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=2
        InventorySize=6
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		FireParams(2)=FireParams'TacticalPrimaryFireParams'
		FireParams(3)=FireParams'TacticalPrimaryAmpFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Amp'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams_Amp'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams_Amp'
		AltFireParams(3)=FireParams'TacticalSecondaryFireParams_Amp'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_Laser
		//Layout core
		LayoutName="Superlaser"
		LayoutTags="no_amp"
		Weight=30
		//ADS
        SightingTime=0.20
        SightMoveSpeedFactor=0.6
		//Stats
        DisplaceDurationMult=0.5
        MagAmmo=33
        InventorySize=6
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Laser'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Glock_Gold
		Index=0
		CamoName="Gold"
		Weight=60
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.Glock.Glock_Shiny',Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Brown
		Index=2
		CamoName="Brown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRSCamos.GlockFullBrown_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Green
		Index=3
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRSCamos.GlockGreen_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Silver
		Index=4
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.GlockSilver_Shine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_UTC
		Index=5
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.UTCGlockShine",Index=1)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Butter
		Index=6
		CamoName="Butter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.Glock_GoldShine",Index=1)
		Weight=5
	End Object
	
	Camos(0)=WeaponCamo'Glock_Gold'
	Camos(1)=WeaponCamo'Glock_Black'
	Camos(2)=WeaponCamo'Glock_Brown'
	Camos(3)=WeaponCamo'Glock_Green'
	Camos(4)=WeaponCamo'Glock_Silver'
	Camos(5)=WeaponCamo'Glock_UTC'
	Camos(6)=WeaponCamo'Glock_Butter'
}