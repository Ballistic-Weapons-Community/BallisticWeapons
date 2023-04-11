class E23WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	//Series
	Begin Object Class=ProjectileEffectParams Name=RealisticSeriesEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=10000.000000
        MaxSpeed=30000.000000
        AccelSpeed=100000.000000
        Damage=35.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=40
		Inaccuracy=(X=32,Y=32)
        WarnTargetPct=0.1
    End Object

    Begin Object Class=FireParams Name=RealisticSeriesFireParams
        AmmoPerFire=1
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'RealisticSeriesEffectParams'
    End Object

	//Shotgun
    Begin Object Class=ProjectileEffectParams Name=RealisticMultiEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23SGFlashEmitter'
        Speed=9000.000000
        MaxSpeed=9000.000000
        AccelSpeed=60000.000000
        Damage=20.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.00
        DamageGainEndTime=0.0
        FlashScaleFactor=1.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SGFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.1
        Recoil=256
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=RealisticMultiFireParams
        AmmoPerFire=1
        TargetState="Shotgun"
        FireAnim="Fire2"
        FireEndAnim=
        FireInterval=1.50000
        FireEffectParams(0)=ProjectileEffectParams'RealisticMultiEffectParams'
    End Object

	//Sniper
    Begin Object Class=ProjectileEffectParams Name=RealisticSniperEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Snpr'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=10000.000000
        MaxSpeed=50000.000000
        AccelSpeed=100000.000000
        Damage=70.000000
        DamageRadius=64.000000
        FlashScaleFactor=1.450000
        Chaos=0.100000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SRFire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
    End Object

    Begin Object Class=FireParams Name=RealisticSniperFireParams
        AmmoPerFire=3
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.600000
        FireEffectParams(0)=ProjectileEffectParams'RealisticSniperEffectParams'
    End Object

	//Laser
    Begin Object Class=InstantEffectParams Name=RealisticLaserEffectParams
        TraceRange=(Min=3000.000000,Max=3000.000000)
        WaterTraceRange=2100
		RangeAtten=0.400000
        Damage=16.000000
        HeadMult=1.3f
        LimbMult=0.7f
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
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.01
    End Object

    Begin Object Class=FireParams Name=RealisticLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.080000
        FireEffectParams(0)=InstantEffectParams'RealisticLaserEffectParams'
    End Object
		
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.300000),(InVal=0.700000,OutVal=0.500000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.300000
		YawFactor=0.300000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1024.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1648)
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
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=60
		//SightOffset=(X=-8.000000,Z=9.300000)
		SightPivot=(Pitch=256)
		WeaponName="E-23 'Viper' Particle Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
        FireParams(0)=FireParams'RealisticSeriesFireParams'
        FireParams(1)=FireParams'RealisticMultiFireParams'
        FireParams(2)=FireParams'RealisticSniperFireParams'
		AltFireParams(0)=FireParams'RealisticLaserFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}