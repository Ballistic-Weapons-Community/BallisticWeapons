class M290WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1250,Max=3000)
        RangeAtten=0.25
        TraceCount=20
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        MaxHits=18
        Damage=12
		PushbackForce=1000.000000
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=2560.000000
        Chaos=0.300000
        BotRefireRate=0.7
        WarnTargetPct=0.75	
		Inaccuracy=(X=512,Y=378)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Fire',Volume=1.500000)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=1.200000
        AmmoPerFire=2
        bCockAfterFire=True	
        FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=3072.000000,Max=3072.000000)
        DecayRange=(Min=1250,Max=3000)
        RangeAtten=0.25
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=12
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        PenetrateForce=100
		PushbackForce=600.000000
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=2
        Recoil=1536.000000
        Chaos=0.250000
        BotRefireRate=0.7
        WarnTargetPct=0.5	
		Inaccuracy=(X=256,Y=256)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290SingleFire',Volume=1.200000)
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.400000
        bCockAfterFire=True
        FireAnim="FireRight"	
        FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.2
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.100000
		ClimbTime=0.075
		DeclineDelay=0.5
        DeclineTime=0.750000
		CrouchMultiplier=0.85
		HipMultiplier=1.5
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=0.75
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=1.000000	
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Magazine",Slot=2,Scale=0f)
		CockAnimRate=1.350000
		ReloadAnimRate=1.750000
		MagAmmo=6
		SightingTime=0.4
		SightMoveSpeedFactor=0.8
		SightPivot=(Pitch=256)
        InventorySize=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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