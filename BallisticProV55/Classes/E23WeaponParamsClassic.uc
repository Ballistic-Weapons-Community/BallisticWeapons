class E23WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	//Series
	Begin Object Class=ProjectileEffectParams Name=ClassicSeriesEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=4500.000000
        MaxSpeed=12000.000000
        AccelSpeed=60000.000000
        Damage=35.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=40
		Inaccuracy=(X=8,Y=4)
        WarnTargetPct=0.1
    End Object

    Begin Object Class=FireParams Name=ClassicSeriesFireParams
        AmmoPerFire=1
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSeriesEffectParams'
    End Object

	//Shotgun
    Begin Object Class=ProjectileEffectParams Name=ClassicMultiEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23SGFlashEmitter'
        Speed=4500.000000
        MaxSpeed=4500.000000
        AccelSpeed=60000.000000
        Damage=20.000000
        DamageRadius=24.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=1.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SGFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.1
        Recoil=256
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=ClassicMultiFireParams
        AmmoPerFire=1
        TargetState="Shotgun"
        FireAnim="Fire2"
        FireEndAnim=
        FireInterval=1.50000
        FireEffectParams(0)=ProjectileEffectParams'ClassicMultiEffectParams'
    End Object

	//Sniper
    Begin Object Class=ProjectileEffectParams Name=ClassicSniperEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Snpr'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=4500.000000
        MaxSpeed=20000.000000
        AccelSpeed=100000.000000
        Damage=50.000000
        DamageRadius=16.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=0.750000
        Chaos=0.350000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
    End Object

    Begin Object Class=FireParams Name=ClassicSniperFireParams
        AmmoPerFire=4
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.600000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSniperEffectParams'
    End Object

	//Laser
    Begin Object Class=InstantEffectParams Name=ClassicLaserEffectParams
        TraceRange=(Min=3000.000000,Max=3000.000000)
        WaterTraceRange=2100
		RangeAtten=0.400000
        Damage=10.000000
        HeadMult=2.0f
        LimbMult=1.0f
        DamageType=Class'BallisticProV55.DTVPRLaser'
        DamageTypeHead=Class'BallisticProV55.DTVPRLaserHead'
        DamageTypeArm=Class'BallisticProV55.DTVPRLaser'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.005000
        Recoil=4
		Inaccuracy=(X=8,Y=4)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SRFire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.01
    End Object

    Begin Object Class=FireParams Name=ClassicLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.075000
        FireEffectParams(0)=InstantEffectParams'ClassicLaserEffectParams'
    End Object
		
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=-0.150000),(InVal=0.350000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.300000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=-0.400000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.400000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.350000
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.350000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Military Issue"
		Weight=30
		
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		MagAmmo=45
		SightOffset=(X=-8.000000,Z=9.300000)
		SightPivot=(Pitch=256)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
		AltFireParams(0)=FireParams'ClassicLaserFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-UTC
		LayoutName="Police Issue"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_Boom_Tex.Viper.UTCViperShine',Index=1)
		
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		MagAmmo=45
		WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000)
		SightOffset=(X=-8.000000,Z=9.300000)
		SightPivot=(Pitch=256)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicSeriesFireParams'
        FireParams(1)=FireParams'ClassicMultiFireParams'
        FireParams(2)=FireParams'ClassicSniperFireParams'
		AltFireParams(0)=FireParams'ClassicLaserFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-UTC'

}