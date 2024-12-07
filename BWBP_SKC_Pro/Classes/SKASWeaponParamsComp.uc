class SKASWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//10ga auto
    Begin Object Class=ShotgunEffectParams Name=ArenaAutoEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
        RangeAtten=0.250000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=17
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

    Begin Object Class=FireParams Name=ArenaAutoFireParams
        FireInterval=0.300000
        FireAnim="Fire"
        FireEndAnim=
        FireAnimRate=1.500000	
        FireEffectParams(0)=ShotgunEffectParams'ArenaAutoEffectParams'
    End Object

	//10ga manual
    Begin Object Class=ShotgunEffectParams Name=ArenaManualEffectParams
        TraceRange=(Min=2048.000000,Max=4096.000000)
        DecayRange=(Min=1000,Max=2500)
        RangeAtten=0.250000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=17
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

    Begin Object Class=FireParams Name=ArenaManualFireParams
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.450000	
        FireEffectParams(0)=ShotgunEffectParams'ArenaManualEffectParams'
    End Object
		
	//12ga gatling
    Begin Object Class=ShotgunEffectParams Name=ArenaAutoEffectParams_Gatling
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
        RangeAtten=0.250000
        TraceCount=4
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=30
        PushbackForce=180.000000
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        Recoil=50.000000
        Chaos=0.300000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000	
		Inaccuracy=(X=310,Y=310)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Rapid',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ArenaAutoFireParams_Gatling
		TargetState="SpinUpFire"
		FireInterval=0.130000
		BurstFireRateFactor=1.00
        FireAnimRate=2.000000	
		FireAnim="Fire"
		FireEndAnim=	
        FireEffectParams(0)=ShotgunEffectParams'ArenaAutoEffectParams_Gatling'
    End Object
	
	//FRAG-10 Auto
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_SKC_Pro.SKASRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=150.000000
		MaxSpeed=50000.000000
		AccelSpeed=25000.000000
		Damage=105
		DamageRadius=130.000000
		MomentumTransfer=30000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.SRAC-Fire2',Volume=1.450000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Frag
		TargetState="Projectile"
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		FireAnim="FireRot"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Frag'
	End Object
	
	//FRAG-10 Manual
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_FragManual
		ProjectileClass=Class'BWBP_SKC_Pro.SKASRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=100000.000000
		AccelSpeed=50000.000000
		Damage=110
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.SRAC-Fire',Volume=1.450000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_FragManual
		TargetState="Projectile"
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.000000	
        FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_FragManual'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
        RangeAtten=0.600000
        TraceCount=30
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=13
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

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=1.700000
        AmmoPerFire=3
        FireAnim="FireBig"
        FireEndAnim=	
        FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Gatling
		TargetState="SpinUpFire"
        FireInterval=1.000000
        AmmoPerFire=3
        FireAnim="FireBig"
        FireEndAnim=	
        FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
    End Object

	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.45
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.600000,OutVal=-0.050000),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.050000
        YRandFactor=0.050000
		ClimbTime=0.05
		DeclineDelay=0.450000
        DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="10ga Rotary"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.35
		SightPivot=(Pitch=1024)
		//Function
		PlayerJumpFactor=1.0
		InventorySize=8
		DisplaceDurationMult=1
		MagAmmo=24
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
        FireParams(1)=FireParams'ArenaManualFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Gatling
		//Layout core
		LayoutName="12ga Gatling"
		LayoutTags="spinup"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.35
		SightPivot=(Pitch=1024)
		//Function
		PlayerJumpFactor=1.0
		InventorySize=8
		DisplaceDurationMult=1
		MagAmmo=30
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponModes(0)=(ModeName="Gatling",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=true)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams_Gatling'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Gatling'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Frag
		//Layout core
		LayoutName="SRAC HE"
		Weight=10
		AllowedCamos(0)=7
		AllowedCamos(1)=8
		AllowedCamos(2)=9
		AllowedCamos(3)=10
		AllowedCamos(4)=11
		AllowedCamos(5)=12
		AllowedCamos(6)=13
		AllowedCamos(7)=14
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.35
		SightPivot=(Pitch=1024)
		//Function
		PlayerJumpFactor=1.0
		InventorySize=8
		DisplaceDurationMult=1
		MagAmmo=24
		ReloadAnimRate=1.00
		CockAnimRate=1.00
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Frag'
        FireParams(1)=FireParams'ArenaPrimaryFireParams_FragManual'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Gatling'
    Layouts(2)=WeaponParams'ArenaParams_Frag'
	
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
	
	Begin Object Class=WeaponCamo Name=SRAC_Gray
		Index=7
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-MainShine",Index=1,AIndex=0,PIndex=0)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Tactical
		Index=8
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-TacticalShine",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Steel
		Index=9
		CamoName="Steel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-SteelShine",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Blood
		Index=10
		CamoName="Blood"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-BloodShine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Tiger
		Index=11
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-RedTiger",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_DarkTiger
		Index=12
		CamoName="Dark Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-TigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Pink
		Index=13
		CamoName="Fabulous"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-PinkShine",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SRAC_Gold
		Index=14
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SKASCamos.SRAC-GoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	//SKAS
	Camos(0)=WeaponCamo'SKAS_Gray'
	Camos(1)=WeaponCamo'SKAS_Urban'
	Camos(2)=WeaponCamo'SKAS_Digital'
	Camos(3)=WeaponCamo'SKAS_Desert'
	Camos(4)=WeaponCamo'SKAS_Jungle'
	Camos(5)=WeaponCamo'SKAS_Glitch'
	Camos(6)=WeaponCamo'SKAS_Glitch2'
	//SRAC
	Camos(7)=WeaponCamo'SRAC_Gray'
	Camos(8)=WeaponCamo'SRAC_Tactical'
	Camos(9)=WeaponCamo'SRAC_Steel'
	Camos(10)=WeaponCamo'SRAC_Blood'
	Camos(11)=WeaponCamo'SRAC_Tiger'
	Camos(12)=WeaponCamo'SRAC_DarkTiger'
	Camos(13)=WeaponCamo'SRAC_Pink'
	Camos(14)=WeaponCamo'SRAC_Gold'
}