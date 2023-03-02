//=============================================================================
// A2WWeaponParams
//=============================================================================
class A2WWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.100000
    	TraceRange=(Min=8000.000000,Max=8000.000000)
        PenetrationEnergy=8.000000
        PenetrateForce=150
        Damage=50.000000
        DamageType=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
        DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Volume=0.800000)
        Recoil=512.000000
	    Inaccuracy=(X=128,Y=128)
        MomentumTransfer=80000
        SplashDamage=False
        RecommendSplashDamage=False
        WarnTargetPct=0.500000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ClassicPrimaryFireParams
        FireInterval=0.3
        FireEndAnim=
        FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
    End Object

    //=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ClassicRecoilParams
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

    Begin Object Class=AimParams Name=ClassicAimParams
        AimSpread=(Min=64,Max=128)
        ChaosDeclineTime=0.450000
        ADSMultiplier=2 
    End Object

    //=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
        MagAmmo=36
        InventorySize=12
        SightingTime=0.400000
        PlayerSpeedFactor=0.900000
        DisplaceDurationMult=0.5
		ViewOffset=(X=10.000000,Y=7.000000,Z=-11.000000)
		SightPivot=(Pitch=512)
		SightOffset=(X=-24.000000,Y=-0.500000,Z=18.000000)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
        FireParams(0)=FireParams'ClassicPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}