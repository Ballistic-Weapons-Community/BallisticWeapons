class A500WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	    

    Begin Object Class=ProjectileEffectParams Name=ArenaMultiEffectParams
        ProjectileClass=Class'BallisticProV55.A500Projectile'
        MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'  
        Speed=5500.000000
        MaxSpeed=6500.000000
        AccelSpeed=3000.000000
        Damage=22.000000
        MomentumTransfer=1000.000000
        MaxDamageGainFactor=0.5
        DamageGainEndTime=0.3
        Recoil=378.000000
        Chaos=0.400000
        Inaccuracy=(X=220,Y=220)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_Fire1',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
        SplashDamage=False
	    RecommendSplashDamage=False
        WarnTargetPct=0.200000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaMultiFireParams
        FireEndAnim=
        FireAnimRate=1.300000
        FireInterval=0.4
        FireEffectParams(0)=ProjectileEffectParams'ArenaMultiEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaChargeEffectParams
        ProjectileClass=Class'BallisticProV55.A500AltProjectile'
        MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
        Speed=6000.000000
        MaxSpeed=6000.000000
        Damage=25.000000
        DamageRadius=768.000000
        RadiusFallOffType=RFO_None
        Chaos=0.500000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
        SplashDamage=True
        RecommendSplashDamage=False
        WarnTargetPct=0.800000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=ArenaChargeFireParams
        AmmoPerFire=0
        FireEndAnim=
        FireInterval=1.500000
        MaxHoldTime=6.000000
        FireEffectParams(0)=ProjectileEffectParams'ArenaChargeEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================    

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.65
        CrouchMultiplier=0.800000
        XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.270000),(InVal=0.600000,OutVal=0.350000),(InVal=0.700000,OutVal=0.40000),(InVal=1.000000,OutVal=0.4500000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.170000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.100000),(InVal=1.000000,OutVal=0.500000)))
        XRandFactor=0.200000
        YRandFactor=0.200000
        DeclineTime=1.500000
    End Object

    //=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=0.150000
        SprintOffSet=(Pitch=-3000,Yaw=-4000)
        AimAdjustTime=0.600000
        AimSpread=(Min=0,Max=128)
        AimDamageThreshold=75.000000
        ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=1000.000000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        MagAmmo=5
        SightingTime=0.300000
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaMultiFireParams'
        AltFireParams(0)=FireParams'ArenaChargeFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}