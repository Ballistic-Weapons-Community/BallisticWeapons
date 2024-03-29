class E23WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{   
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaSeriesEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Std'
        SpawnOffset=(X=30.000000,Y=6.000000,Z=-12.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=5500.000000
        MaxSpeed=14000.000000
        AccelSpeed=100000.000000
        Damage=43.000000
        DamageRadius=16.000000
        MaxDamageGainFactor=0.6
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.06
        Recoil=160
        WarnTargetPct=0.1
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaMultiEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_SG'
        SpawnOffset=(X=30.000000,Y=6.000000,Z=-12.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=5500.000000
        MaxSpeed=5500.000000
        AccelSpeed=60000.000000
        Damage=43.000000
        DamageRadius=64.000000
        MaxDamageGainFactor=0.25
        DamageGainEndTime=0.3
        FlashScaleFactor=0.750000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SGFire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        Chaos=0.5
        Recoil=768
        WarnTargetPct=0.2
        BotRefireRate=0.99	
    End Object

    Begin Object Class=ProjectileEffectParams Name=ArenaSniperEffectParams
        ProjectileClass=Class'BallisticProV55.E23Projectile_Snpr'
        SpawnOffset=(X=30.000000,Y=6.000000,Z=-12.000000)
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        Speed=5500.000000
        MaxSpeed=50000.000000
        AccelSpeed=100000.000000
        Damage=43.000000
		MaxDamageGainFactor=1
		DamageGainEndTime=0.35
        DamageRadius=64.000000
        FlashScaleFactor=0.750000
        Chaos=0.350000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-SRFire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
        Recoil=768.000000
        WarnTargetPct=0.1
        BotRefireRate=0.99	
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

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ArenaLaserEffectParams
        TraceRange=(Min=10000.000000,Max=10000.000000)
        WaterTraceRange=5000
        Damage=11.000000
        HeadMult=2.00
        LimbMult=0.75
        DamageType=Class'BallisticProV55.DTVPRLaser'
        DamageTypeHead=Class'BallisticProV55.DTVPRLaserHead'
        DamageTypeArm=Class'BallisticProV55.DTVPRLaser'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.E23FlashEmitter'
        FlashScaleFactor=0.750000
        Chaos=0.000000
	    Recoil=64
        FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.2
    End Object

    Begin Object Class=FireParams Name=ArenaLaserFireParams
        FireAnim=
        FireLoopAnim="'"
        FireEndAnim=
        FireInterval=0.07000
        FireEffectParams(0)=InstantEffectParams'ArenaLaserEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=-0.01000),(InVal=0.350000,OutVal=-0.030000),(InVal=0.600000,OutVal=0.010000),(InVal=0.800000,OutVal=0.040000),(InVal=1.000000,OutVal=0.1)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.380000),(InVal=0.600000,OutVal=0.750000),(InVal=0.700000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.04
		DeclineDelay=0.190000
		DeclineTime=0.75
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=64,Max=512)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
	    ReloadAnimRate=1.250000
		SightingTime=0.4
		ScopeScale=0.7
        MagAmmo=100        
        InventorySize=6
        SightMoveSpeedFactor=0.6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaSeriesFireParams'
        FireParams(1)=FireParams'ArenaMultiFireParams'
        FireParams(2)=FireParams'ArenaSniperFireParams'
        AltFireParams(0)=FireParams'ArenaLaserFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=VPR_Gray
		Index=0
		CamoName="Purple"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=VPR_UTC
		Index=1
		CamoName="UTC"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.ViperCamos.UTCViperShine",Index=1,PIndex=0,AIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'VPR_Gray'
    Camos(1)=WeaponCamo'VPR_UTC'
}