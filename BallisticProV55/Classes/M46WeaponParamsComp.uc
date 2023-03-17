class M46WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=2363,Max=5000)
        RangeAtten=0.75
        Damage=30
        HeadMult=2.0f
        LimbMult=0.67f
        DamageType=Class'BallisticProV55.DTM46Assault'
        DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
        DamageTypeArm=Class'BallisticProV55.DTM46Assault'
        PenetrateForce=150
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
        FlashScaleFactor=0.450000
        Recoil=170.000000
        Chaos=0.032000
        BotRefireRate=0.99
        WarnTargetPct=0.2
        FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Fire1',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        AimedFireAnim="AimedFire"
		FireInterval=0.135000
        FireEndAnim=	
        FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        ProjectileClass=Class'BallisticProV55.M46Grenade'
        SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
        Speed=2700.000000
        Damage=90.000000
		DamageRadius=384.000000
        MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
        Recoil=None
        Chaos=None
        BotRefireRate=0.3
        WarnTargetPct=0.8	
        FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_FireGren',Volume=1.750000)
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.750000
        PreFireTime=0.450000
        PreFireAnim="GrenadePrepFire"
        FireAnim="GrenadeFire"	
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.080000,OutVal=0.050000),(InVal=0.110000,OutVal=0.080000),(InVal=0.150000,OutVal=0.14000),(InVal=0.300000,OutVal=0.2300000),(InVal=0.450000,OutVal=0.2500000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.380000),(InVal=1.000000,OutVal=0.25)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineDelay=0.1700000
		DeclineTime=0.65
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.550000
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightingTime=0.500000
        SightMoveSpeedFactor=0.8
        MagAmmo=24
        InventorySize=6
        ZoomType=ZT_Logarithmic
        WeaponBoneScales(0)=(BoneName="RDS",Slot=0,Scale=0f)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaRDSParams
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightingTime=0.350000
        MagAmmo=24
        InventorySize=6
		ViewOffset=(X=5.000000,Y=4.750000,Z=-8.000000)
		ViewPivot=(Pitch=384)
        SightPivot=(Pitch=-300,Roll=0)
        SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
        WeaponBoneScales(0)=(BoneName="Scope",Slot=0,Scale=0f)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaRDSParams'
}