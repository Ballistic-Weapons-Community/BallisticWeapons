class SKASWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalAutoEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
        RangeAtten=0.25
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=15
        HeadMult=1.75
        LimbMult=0.85
        PushbackForce=180.000000
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        Recoil=550.000000
        Chaos=0.300000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000	
		Inaccuracy=(X=310,Y=310)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Single',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=TacticalAutoFireParams
        FireInterval=0.300000
        FireAnim="Fire"
        FireEndAnim=
        FireAnimRate=1.500000	
        FireEffectParams(0)=ShotgunEffectParams'TacticalAutoEffectParams'
    End Object

    Begin Object Class=ShotgunEffectParams Name=TacticalManualEffectParams
        TraceRange=(Min=2048.000000,Max=4096.000000)
        DecayRange=(Min=2100,Max=6200)
        RangeAtten=0.25
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=18
        HeadMult=1.75
        LimbMult=0.85
        DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PushbackForce=180.000000
		PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.5
        Recoil=128.000000
        Chaos=0.200000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000
		Inaccuracy=(X=35,Y=35)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Power',Volume=1.300000)	
    End Object

    Begin Object Class=FireParams Name=TacticalManualFireParams
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.450000	
        FireEffectParams(0)=ShotgunEffectParams'TacticalManualEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=2363) // 15-45m
        RangeAtten=0.2
        TraceCount=30
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=45
        HeadMult=1.75
        LimbMult=0.85
        PushbackForce=850.000000
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
        Recoil=1500.000000
        Chaos=1.000000
        BotRefireRate=0.900000
        WarnTargetPct=0.100000	
		Inaccuracy=(X=378,Y=378)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Triple',Volume=2.200000)
    End Object

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		TargetState="SpinUpFire"
        FireInterval=1.700000
        AmmoPerFire=3
        FireAnim="FireBig"
        FireEndAnim=	
        FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.3
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.050000),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.15
        YRandFactor=0.15
		ClimbTime=0.05
		DeclineDelay=0.450000
        DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=8
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		SightPivot=(Pitch=1024)
		DisplaceDurationMult=1
		MagAmmo=24
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
        FireParams(1)=FireParams'TacticalManualFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SKAS_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoU",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Digital
		Index=2
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoT",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Desert
		Index=3
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoD",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Jungle
		Index=4
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-CamoG",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Glitch
		Index=5
		CamoName="XR4"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-Charged",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=SKAS_Glitch2
		Index=6
		CamoName="11011"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SKAS-BlueGlow",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'SKAS_Gray'
	Camos(1)=WeaponCamo'SKAS_Urban'
	Camos(2)=WeaponCamo'SKAS_Digital'
	Camos(3)=WeaponCamo'SKAS_Desert'
	Camos(4)=WeaponCamo'SKAS_Jungle'
	Camos(5)=WeaponCamo'SKAS_Glitch'
	Camos(6)=WeaponCamo'SKAS_Glitch2'
}