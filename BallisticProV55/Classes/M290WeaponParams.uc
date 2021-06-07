class M290WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=2560.000000,Max=2560.000000)
        RangeAtten=0.25000
        TraceCount=20
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        MaxHits=18
        Damage=12
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=1536.000000
        Chaos=0.300000
        BotRefireRate=0.7
        WarnTargetPct=0.75	
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
        TraceRange=(Min=2560.000000,Max=2560.000000)
        RangeAtten=0.250000
        TraceCount=10
        TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=12
        DamageType=Class'BallisticProV55.DTM290Shotgun'
        DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=2
        Recoil=768.000000
        Chaos=0.250000
        BotRefireRate=0.7
        WarnTargetPct=0.5	
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
        DeclineTime=0.900000
        DeclineDelay=0.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=0.350000
        SprintOffSet=(Pitch=-1000,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=1.000000	
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=256)
		SightOffset=(X=-50.000000,Y=-0.040000,Z=14.050000)
		MagAmmo=6
		SightingTime=0.4
        InventorySize=12
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}