class AM67WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaPriEffectParams
        DecayRange=(Min=1536,Max=2560)
        PenetrationEnergy=12 
        Damage=60.000000
        HeadMult=1.5f
        LimbMult=0.8f
        RangeAtten=0.500000
        DamageType=Class'BallisticProV55.DTAM67Pistol'
        DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FlashScaleFactor=0.900000
        Recoil=450.000000
        Chaos=0.2
        Inaccuracy=(X=16,Y=16)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Fire',Volume=1.100000)
        WarnTargetPct=0.400000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaPriFireParams
        AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.325
        FireEffectParams(0)=InstantEffectParams'ArenaPriEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=ArenaFlashEffectParams
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
    End Object

    Begin Object Class=FireParams Name=ArenaFlashFireParams
        MaxHoldTime=0.500000
        FireAnim="Idle"
        FireEndAnim=
        FireInterval=10.000000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'ArenaFlashEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
        DeclineDelay=0.6
        DeclineTime=1.0
        MaxRecoil=8192.000000
        XRandFactor=0.10000
        YRandFactor=0.10000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        AimSpread=(Min=16,Max=128)
        AimAdjustTime=0.450000
        ADSMultiplier=1
        JumpChaos=0.200000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=500.000000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        ReloadAnimRate=1.250000
		CockAnimRate=1.250000
		PlayerSpeedFactor=1.05
        DisplaceDurationMult=0.75
        MagAmmo=8
        InventorySize=12
		SightOffset=(X=10.000000,Y=0.04,Z=7.950000)
		SightingTime=0.250000
		ViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaFlashFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}