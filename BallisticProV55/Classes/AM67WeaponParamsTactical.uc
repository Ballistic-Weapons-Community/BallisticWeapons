class AM67WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalPriEffectParams
        DecayRange=(Min=1050,Max=2100)
        PenetrationEnergy=16
        Damage=60.000000
        HeadMult=2.75
        LimbMult=0.67f
        RangeAtten=0.5
        DamageType=Class'BallisticProV55.DTAM67Pistol'
        DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
        DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FlashScaleFactor=0.900000
        Recoil=450.000000
        Chaos=0.2
        Inaccuracy=(X=48,Y=48)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Fire',Volume=1.100000)
        WarnTargetPct=0.400000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalPriFireParams
        AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.3
        FireEffectParams(0)=InstantEffectParams'TacticalPriEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=TacticalFlashEffectParams
        MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
        EffectString="Blinding flash"
    End Object

    Begin Object Class=FireParams Name=TacticalFlashFireParams
        MaxHoldTime=0.5
        FireAnim="Idle"
        FireEndAnim=
        FireInterval=10.000000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'TacticalFlashEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.5
        XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.5,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
        DeclineDelay=0.6
        DeclineTime=1.0
        MaxRecoil=8192.000000
        XRandFactor=0.10000
        YRandFactor=0.10000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=128,Max=512)
        AimAdjustTime=0.450000
        ADSMultiplier=0.5
        JumpChaos=0.200000
        ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
        DisplaceDurationMult=0.75
        MagAmmo=6
        InventorySize=4
		SightOffset=(X=10.000000,Y=0.04,Z=7.950000)
        SightingTime=0.2
        SightMoveSpeedFactor=0.6
		ViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalPriFireParams'
        AltFireParams(0)=FireParams'TacticalFlashFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}