class D49WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaFireEffectParams
        DecayRange=(Min=788,Max=1838)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=8.000000
        Damage=45.000000
        HeadMult=2.0f
        LimbMult=0.67f
        DamageType=Class'BallisticProV55.DTD49Revolver'
        DamageTypeHead=Class'BallisticProV55.DTD49RevolverHead'
        DamageTypeArm=Class'BallisticProV55.DTD49Revolver'
        RangeAtten=0.5
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
        DecayRange=(Min=788,Max=1838)
        TraceRange=(Min=8000.000000,Max=9000.000000)
        PenetrationEnergy=8.000000
        Damage=90.000000
        HeadMult=1.5f
        LimbMult=0.67f
        RangeAtten=0.5
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
        WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="ShortBarrel",Slot=51,Scale=0f)
		CockAnimRate=1.750000
		ReloadAnimRate=1.750000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=6
        InventorySize=3
		ViewOffset=(X=-2.000000,Y=13.000000,Z=-12.000000)
		ViewPivot=(Pitch=512)
		SightOffset=(X=-30.000000,Y=-3.500000,Z=23.9500000)
		SightPivot=(Pitch=-175,Roll=-500)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=2000)
		WristAdjust=(Yaw=-2500,Pitch=-0000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}