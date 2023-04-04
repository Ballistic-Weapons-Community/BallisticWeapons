class M290WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1312,Max=3938)
        RangeAtten=0.25
        TraceCount=20
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        MaxHits=12
        Damage=13
        HeadMult=1.75f
        LimbMult=0.85f
		PushbackForce=1000.000000
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=1536.000000
        Chaos=0.300000
        BotRefireRate=0.7
        WarnTargetPct=0.75	
		Inaccuracy=(X=512,Y=378)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Fire',Volume=1.500000)
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        AimedFireAnim="SightFire"
		FireInterval=1.200000
        AmmoPerFire=2
        bCockAfterFire=True	
        FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1250,Max=3000)
        RangeAtten=0.25
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=13
        HeadMult=1.75f
        LimbMult=0.85f
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        PenetrateForce=100
		PushbackForce=600.000000
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=2
        Recoil=768.000000
        Chaos=0.250000
        BotRefireRate=0.7
        WarnTargetPct=0.5	
		Inaccuracy=(X=256,Y=256)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290SingleFire',Volume=1.200000)
    End Object

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        AimedFireAnim="SightFireAlt"
		FireInterval=0.400000
        bCockAfterFire=True
        FireAnim="FireRight"	
        FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.2
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.750000
        DeclineDelay=0.5
		HipMultiplier=1.25
		MaxMoveMultiplier=2
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        ADSMultiplier=0.75
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=1.000000	
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Magazine",Slot=2,Scale=0f)
		ReloadAnimRate=1.250000
        SightMoveSpeedFactor=0.6
		SightPivot=(Pitch=256)
		MagAmmo=6
		SightingTime=0.3
        InventorySize=8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M290_Yellow
		Index=0
		CamoName="Yellow"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M290_Dark
		Index=1
		CamoName="Dark Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M290Camos.MiniThorSkin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M290_Retro
		Index=2
		CamoName="Retro Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M290Camos.M290_SH1",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'M290_Yellow'
	Camos(1)=WeaponCamo'M290_Dark'
	Camos(2)=WeaponCamo'M290_Retro'
}