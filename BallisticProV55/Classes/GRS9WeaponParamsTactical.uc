class GRS9WeaponParamsTactical extends BallisticWeaponParams;

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
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=128,Y=128)
        RangeAtten=0.5
        Damage=24
        HeadMult=2.75f
        LimbMult=0.75f
        DamageType=Class'BallisticProV55.DTGRS9Pistol'
        DamageTypeHead=Class'BallisticProV55.DTGRS9PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTGRS9Pistol'
        PenetrationEnergy=16
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
        FlashScaleFactor=2.500000
        Recoil=140.000000
        Chaos=0.120000
        BotRefireRate=0.99
        WarnTargetPct=0.2
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        FireInterval=0.055000
        FireEndAnim=
        AimedFireAnim='SightFire'
        FireAnimRate=1.700000	
        FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
        RangeAtten=0.5
        Damage=14
        HeadMult=2.75f
        LimbMult=0.75f
        DamageType=Class'BallisticProV55.DTGRS9Laser'
        DamageTypeHead=Class'BallisticProV55.DTGRS9LaserHead'
        DamageTypeArm=Class'BallisticProV55.DTGRS9Laser'
        PenetrateForce=200
        bPenetrate=True
        Chaos=0.000000
        BotRefireRate=0.999000
        WarnTargetPct=0.010000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-LaserFire')
    End Object

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=0.080000
        AmmoPerFire=0
        FireAnim="Idle"	
        FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.35
		ADSViewBindFactor=0.7
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.12),(InVal=0.300000,OutVal=0.150000),(InVal=0.4,OutVal=0.02),(InVal=0.550000,OutVal=-0.120000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.200000)))
        YCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.1
        DeclineTime=1.1
        DeclineDelay=0.250000
        MaxRecoil=6144
		CrouchMultiplier=1
		HipMultiplier=1.5
		MaxMoveMultiplier=2
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=256,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
        ADSMultiplier=0.75
        SprintChaos=0.050000
        AimAdjustTime=0.450000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		bDualBlocked=True
        //SightOffset=(X=-5.000000,Z=5.900000)
        DisplaceDurationMult=0.5
        SightingTime=0.250000
        SightMoveSpeedFactor=0.6
        MagAmmo=18
        InventorySize=4
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Glock_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Brown
		Index=1
		CamoName="Brown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Green
		Index=2
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainTigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Silver
		Index=3
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainBlackShine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_UTC
		Index=4
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.UTCGlockShine",Index=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.Glock_GoldShine",Index=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Glock_Black'
	Camos(1)=WeaponCamo'Glock_Brown'
	Camos(2)=WeaponCamo'Glock_Green'
	Camos(3)=WeaponCamo'Glock_Silver'
	Camos(4)=WeaponCamo'Glock_UTC'
	Camos(5)=WeaponCamo'Glock_Gold'
}