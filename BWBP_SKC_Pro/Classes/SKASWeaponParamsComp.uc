class SKASWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaAutoEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
        RangeAtten=0.250000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=13
        PushbackForce=180.000000
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        Recoil=450.000000
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

    Begin Object Class=ShotgunEffectParams Name=ArenaManualEffectParams
        TraceRange=(Min=2048.000000,Max=4096.000000)
        DecayRange=(Min=1000,Max=2500)
        RangeAtten=0.250000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=13
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
        Damage=10
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
		TargetState="SpinUpFire"
        FireInterval=1.700000
        AmmoPerFire=3
        FireAnim="FireBig"
        FireEndAnim=	
        FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.45
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.050000
        YRandFactor=0.050000
        DeclineTime=1.500000
        DeclineDelay=0.450000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3072,Yaw=-4096)
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=1024)
		SightOffset=(X=-20.000000,Y=9.700000,Z=19.000000)
		ViewOffset=(X=-4.000000,Y=1.000000,Z=-10.000000)
		
		PlayerJumpFactor=1.000000
		InventorySize=8
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=24
		WeaponModes(0)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaAutoFireParams'
        FireParams(1)=FireParams'ArenaManualFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}