class E23WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.040000),(InVal=0.200000,OutVal=0.12000),(InVal=0.350000,OutVal=0.170000),(InVal=0.600000,OutVal=0.220000),(InVal=0.800000,OutVal=0.320000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.380000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.240000
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=64,Max=256)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.250000
	End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaSeriesEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=96
        WarnTargetPct=0.1
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaMultiEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SGFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.5
        Recoil=768
        WarnTargetPct=0.2
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaSniperEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Snpr'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.350000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
    End Object

    Begin Object Class=InstantEffectParams Name=ArenaLaserEffectParams
        TraceRange=(Min=10000.000000,Max=10000.000000)
        WaterTraceRange=5000
        Damage=11.000000
        HeadMult=1.5f
        LimbMult=0.5f
        DamageType=Class'BallisticProV55.DTVPRLaser'
        DamageTypeHead=Class'BallisticProV55.DTVPRLaserHead'
        DamageTypeArm=Class'BallisticProV55.DTVPRLaser'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.000000
	    Recoil=0
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=ArenaSeriesFireParams
        AmmoPerFire=5
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'ArenaSeriesEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaMultiFireParams
        AmmoPerFire=5
        TargetState="Shotgun"
        FireAnim="Fire2"
        FireEndAnim=
        FireInterval=0.50000
        FireEffectParams(0)=ProjectileEffectParams'ArenaMultiEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaSniperFireParams
        AmmoPerFire=20
        FireAnim="Fire"
        FireEndAnim=
        FireInterval=0.650000
        FireEffectParams(0)=ProjectileEffectParams'ArenaSniperEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.085000
        FireEffectParams(0)=InstantEffectParams'ArenaLaserEffectParams'
    End Object

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightingTime=0.550000	 
        MagAmmo=100        
        InventorySize=12
        SightMoveSpeedFactor=0.8
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaSeriesFireParams'
        FireParams(1)=FireParams'ArenaMultiFireParams'
        FireParams(2)=FireParams'ArenaSniperFireParams'
        AltFireParams(0)=FireParams'ArenaLaserFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}