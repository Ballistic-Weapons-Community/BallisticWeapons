class A500WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	    

    Begin Object Class=ProjectileEffectParams Name=TacticalMultiEffectParams
        ProjectileClass=Class'BallisticProV55.A500Projectile'
        MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'  
        Speed=3500.000000
        AccelSpeed=0.000000
        MaxSpeed=3500.000000
        Damage=22.000000
        HeadMult=1.75f
        LimbMult=0.85f
        MomentumTransfer=1000.000000
        MaxDamageGainFactor=0.2
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

    Begin Object Class=FireParams Name=TacticalMultiFireParams
        FireEndAnim=
        FireAnimRate=1.300000
        FireInterval=0.4
        FireEffectParams(0)=ProjectileEffectParams'TacticalMultiEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalChargeEffectParams
        ProjectileClass=Class'BallisticProV55.A500AltProjectile'
        MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
        Speed=6000.000000
        MaxSpeed=6000.000000
        Damage=80.000000
        DamageRadius=768.000000
        RadiusFallOffType=RFO_None
        Chaos=0.5
        FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
        SplashDamage=True
        RecommendSplashDamage=False
        WarnTargetPct=0.800000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalChargeFireParams
        AmmoPerFire=0
        FireEndAnim=
        FireInterval=1.500000
        MaxHoldTime=6.000000
        FireEffectParams(0)=ProjectileEffectParams'TacticalChargeEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================    

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.65
		ADSViewBindFactor=0.9
        CrouchMultiplier=0.800000
        XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.270000),(InVal=0.600000,OutVal=0.350000),(InVal=0.700000,OutVal=0.40000),(InVal=1.000000,OutVal=0.4500000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.170000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.100000),(InVal=1.000000,OutVal=0.5)))
        XRandFactor=0.200000
        YRandFactor=0.200000
        DeclineTime=1.500000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
    End Object

    //=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        ADSMultiplier=0.5
        SprintOffset=(Pitch=-3072,Yaw=-4096)
        AimAdjustTime=0.600000
        AimSpread=(Min=256,Max=1024)
        AimDamageThreshold=75.000000
        ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
        WeaponBoneScales(0)=(BoneName="Diamond",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SuperCharger",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Stands",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Glass",Slot=4,Scale=0f)
		SightPivot=(Pitch=512)
		SightOffset=(X=15.000000,Y=0.100000,Z=35.000000)
		ViewOffset=(X=-9.000000,Y=13.000000,Z=-15.000000)
		ViewPivot=(Pitch=600)
        SightMoveSpeedFactor=0.6
        InventorySize=5
		MagAmmo=5
        SightingTime=0.3
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalMultiFireParams'
        AltFireParams(0)=FireParams'TacticalChargeFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}