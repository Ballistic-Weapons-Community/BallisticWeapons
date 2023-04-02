class E5WeaponParams extends BallisticWeaponParams;

defaultproperties
{   
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaSeriesEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_Std'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=14000.000000
        AccelSpeed=100000.000000
        Damage=35.000000
        DamageRadius=16.000000
		HeadMult=2.0f
        LimbMult=0.75f
        MaxDamageGainFactor=0.6
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-FireAlt',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=96
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaMultiEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_SG'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=5500.000000
        AccelSpeed=60000.000000
        Damage=25.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.25
        DamageGainEndTime=0.3
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.MVPR.MVPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.5
        Recoil=768
        WarnTargetPct=0.2
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaSniperEffectParams
        ProjectileClass=Class'BWBP_APC_Pro.E5Projectile_Snpr'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        Speed=5500.000000
        MaxSpeed=50000.000000
        AccelSpeed=100000.000000
        Damage=50.000000
        DamageRadius=64.000000
        FlashScaleFactor=0.750000
        Chaos=0.350000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=FireParams Name=ArenaSeriesFireParams
        FireInterval=0.20000
		BurstFireRateFactor=0.55
		AmmoPerFire=2
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireEffectParams(0)=ProjectileEffectParams'ArenaSeriesEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaMultiFireParams
        AmmoPerFire=4
        TargetState="Shotgun"
        FireAnim="Fire"
		AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.50000
        FireEffectParams(0)=ProjectileEffectParams'ArenaMultiEffectParams'
    End Object

    Begin Object Class=FireParams Name=ArenaSniperFireParams
        AmmoPerFire=20
        FireAnim="Fire"
        FireEndAnim=
		AimedFireAnim="SightFire"
        FireInterval=0.650000
        FireEffectParams(0)=ProjectileEffectParams'ArenaSniperEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaLaserEffectParams
        TraceRange=(Min=10000.000000,Max=10000.000000)
        WaterTraceRange=5000
        Damage=11.000000
        HeadMult=1.5f
        LimbMult=0.5f
        DamageType=Class'BWBP_APC_Pro.DTE5Laser'
        DamageTypeHead=Class'BWBP_APC_Pro.DTE5LaserHead'
        DamageTypeArm=Class'BWBP_APC_Pro.DTE5Laser'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BWBP_APC_Pro.E5FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.000000
	    Recoil=0
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=ArenaLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.085000
        FireEffectParams(0)=InstantEffectParams'ArenaLaserEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.040000),(InVal=0.200000,OutVal=0.12000),(InVal=0.350000,OutVal=0.170000),(InVal=0.600000,OutVal=0.220000),(InVal=0.800000,OutVal=0.320000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.380000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.240000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
		AimSpread=(Min=64,Max=256)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightingTime=0.30000	 
        MagAmmo=60        
        InventorySize=3
        SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=256)
		SightOffset=(X=2.000000,Y=-0.850000,Z=10.850000)
		ViewOffset=(X=5.000000,Y=4.000000,Z=-10.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaSeriesFireParams'
        FireParams(1)=FireParams'ArenaMultiFireParams'
        FireParams(2)=FireParams'ArenaSniperFireParams'
        AltFireParams(0)=FireParams'ArenaLaserFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}