class D49WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaFireEffectParams
        DecayRange=(Min=1024,Max=2536)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=8.000000
        Damage=50.000000
        HeadMult=1.5f
        LimbMult=0.7f
        DamageType=Class'BallisticProV55.DTD49Revolver'
        DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
        DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
        RangeAtten=0.3500000
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=768.000000
        Chaos=0.400000
        Inaccuracy=(X=48,Y=48)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-FireSingle',Volume=1.200000)
        WarnTargetPct=0.4
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaFireParams
        FireAnim="FireSingle"
        FireEndAnim=
        FireInterval=0.4
        AimedFireAnim="SightFire"
        FireEffectParams(0)=InstantEffectParams'ArenaFireEffectParams'
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaAltFireEffectParams
        DecayRange=(Min=1024,Max=2536)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=8.000000
        Damage=100.000000
        HeadMult=1.25f
        LimbMult=0.8f
        RangeAtten=0.350000
        DamageType=Class'BallisticProV55.DTD49Revolver'
        DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
        DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
        FlashScaleFactor=1.200000
        Recoil=2048.000000
        Chaos=0.800000
        Inaccuracy=(X=48,Y=48)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-Fire',Volume=1.300000)
        WarnTargetPct=0.5
		BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaAltFireParams
        FireEndAnim=
        FireInterval=0.9
        AmmoPerFire=2
        FireEffectParams(0)=InstantEffectParams'ArenaAltFireEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.5,OutVal=0.03),(InVal=1,OutVal=0.07)))
		ViewBindFactor=0.65
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineTime=1.200000
		DeclineDelay=0.350000
		MaxRecoil=6144
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=378)
		JumpChaos=0.750000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        PlayerSpeedFactor=1.050000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=6
        InventorySize=6
		SightOffset=(X=-30.000000,Y=-0.400000,Z=14.500000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}