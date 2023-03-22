class A49WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

	Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.A49Projectile'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=4000.000000
        MaxSpeed=10000.000000
        AccelSpeed=60000.000000
        Damage=45.000000
        HeadMult=2
        LimbMult=0.67
        DamageRadius=48.000000
     	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.150000
     	Recoil=108.000000
     	Chaos=0.070000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-Fire',Volume=0.700000,Pitch=1.200000)
		WarnTargetPct=0.2
		BotRefireRate=0.99
	End Object
		
	Begin Object Class=FireParams Name=TacticalProjFireParams
		FireEndAnim=
		FireInterval=0.120000
		FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

	Begin Object Class=FireEffectParams Name=TacticalAltEffectParams
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A49FlashEmitter'
		FlashScaleFactor=1.200000
     	Recoil=512.000000
     	Chaos=0.5
		PushbackForce=1500.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-ShockWave',Volume=2.000000)
     	WarnTargetPct=0.100000
		BotRefireRate=0.900000
	End Object

	Begin Object Class=FireParams Name=TacticalAltFireParams
		FireAnim="AltFire"
		FireInterval=1.25
     	AmmoPerFire=8
		FireEffectParams(0)=FireEffectParams'TacticalAltEffectParams'
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.4
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.070000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.400000),(InVal=0.540000,OutVal=0.650000),(InVal=0.700000,OutVal=0.720000),(InVal=1.000000,OutVal=0.300000)))
		DeclineTime=0.5
		DeclineDelay=0.170000
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimAdjustTime=0.50000
		AimSpread=(Min=384,Max=1536)
        ADSMultiplier=0.5
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=4
		SightMoveSpeedFactor=0.75
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=32
		ViewOffset=(Y=10.000000,Z=-25.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalProjFireParams'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object
	
    Layouts(0)=WeaponParams'TacticalParams'
}