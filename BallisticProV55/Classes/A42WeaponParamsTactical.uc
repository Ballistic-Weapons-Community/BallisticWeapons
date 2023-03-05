//=============================================================================
// A42WeaponParams
//=============================================================================
class A42WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams
    	ProjectileClass=Class'BallisticProV55.A42Projectile'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
        Damage=45.000000
        HeadMult=2.25
        LimbMult=0.67
        Speed=3000.000000
        MaxSpeed=4500.000000
        DamageRadius=48.000000
        AccelSpeed=60000.000000
        MaxDamageGainFactor=0.35
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
	    MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
	    Recoil=96.000000
	    Chaos=0.130000
	    FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.700000)
	    Inaccuracy=(X=32,Y=32)
        WarnTargetPct=0.200000
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams
        FireInterval=0.16
        FireEndAnim=
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=TacticalBeamEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
    	TraceRange=(Min=8000.000000,Max=8000.000000)
        PenetrationEnergy=8
        PenetrateForce=150
        Damage=85.000000
        HeadMult=2.75
        LimbMult=0.67
        DamageType=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
        Recoil=512.000000
	    Inaccuracy=(X=128,Y=128)
        MomentumTransfer=80000
        SplashDamage=False
        RecommendSplashDamage=False
        WarnTargetPct=0.5
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=TacticalBeamFireParams
        AmmoPerFire=7
        FireAnim="SecFire"
	    FireInterval=0.300000
        FireEffectParams(0)=InstantEffectParams'TacticalBeamEffectParams'
    End Object

    //=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=0.05000),(InVal=0.400000,OutVal=0.0800000),(InVal=0.600000,OutVal=0.0200000),(InVal=0.700000,OutVal=0.1),(InVal=1.000000,OutVal=0.000000)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.550000,OutVal=0.550000),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.0)))
        XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.5
        DeclineDelay=0.200000
        ViewBindFactor=0.5
        HipMultiplier=1.5
    End Object

    //=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=64,Max=128)
        ChaosDeclineTime=0.450000
        ADSMultiplier=0.5
        ChaosSpeedThreshold=300
    End Object

    //=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
        MagAmmo=18
        InventorySize=6
        SightingTime=0.200000
        DisplaceDurationMult=0.5
		ViewOffset=(X=8.000000,Y=10.000000,Z=-10.000000)
		SightPivot=(Pitch=1024,Roll=-768)
		SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams'
        AltFireParams(0)=FireParams'TacticalBeamFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}