class MRT6WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
        TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=525,Max=1838)
        RangeAtten=0.2
        TraceCount=20
        TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=9
        HeadMult=2.0f
        LimbMult=0.75f
        DamageType=Class'BallisticProV55.DTMRT6Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.200000
		PushbackForce=1200.000000
        Recoil=1024.000000
        Chaos=0.450000
        BotRefireRate=0.7
        WarnTargetPct=0.75	
		Inaccuracy=(X=600,Y=378)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6Fire')
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        FireInterval=0.800000
        AmmoPerFire=2
        bCockAfterFire=True	
        FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
        TraceRange=(Min=5000.000000,Max=5000.000000)
        DecayRange=(Min=525,Max=1838)
        RangeAtten=0.2
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=9
		PushbackForce=600.000000
        DamageType=Class'BallisticProV55.DTMRT6Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=378.000000
        Chaos=0.200000
        BotRefireRate=0.7
        WarnTargetPct=0.5	
		Inaccuracy=(X=378,Y=378)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6SingleFire')
    End Object

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=0.400000
        bCockAfterFire=True
        FireAnim="FireRight"	
        FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
        YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.100000
        YRandFactor=0.200000
        DeclineTime=0.700000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        JumpChaos=1.000000
        AimSpread=(Min=64,Max=128)
        ADSMultiplier=0.5
        ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
        SightPivot=(Pitch=768)
		SightOffset=(X=-30.000000,Z=11.000000)
		ViewOffset=(X=12.000000,Y=3.000000,Z=-8.500000)
		DisplaceDurationMult=0.33
		SightingTime=0.25
		MagAmmo=8
        InventorySize=3
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}