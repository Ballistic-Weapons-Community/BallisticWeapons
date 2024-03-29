class A49WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

	Begin Object Class=ProjectileEffectParams Name=ArenaProjEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.A49Projectile'
        SpawnOffset=(X=25.000000,Y=6.000000,Z=-8.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=8500.000000
        Damage=40.000000
        DamageRadius=48.000000
     	MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.150000
     	Recoil=108.000000
     	Chaos=0.070000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-Fire',Volume=0.700000,Pitch=1.200000)
		WarnTargetPct=0.2
		BotRefireRate=0.99
	End Object
		
	Begin Object Class=FireParams Name=ArenaProjFireParams
		FireEndAnim=
		FireInterval=0.120000
		FireEffectParams(0)=ProjectileEffectParams'ArenaProjEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

	Begin Object Class=FireEffectParams Name=ArenaAltEffectParams
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A49FlashEmitter'
		FlashScaleFactor=1.200000
     	Recoil=512.000000
     	Chaos=0.500000
		PushbackForce=1500.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A49.A49-ShockWave',Volume=2.000000)
     	WarnTargetPct=0.100000
		BotRefireRate=0.900000
	End Object

	Begin Object Class=FireParams Name=ArenaAltFireParams
		FireAnim="AltFire"
		FireInterval=1.25
     	AmmoPerFire=8
		FireEffectParams(0)=FireEffectParams'ArenaAltEffectParams'
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.200000,OutVal=-0.050000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.070000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.350000,OutVal=0.400000),(InVal=0.540000,OutVal=0.650000),(InVal=0.700000,OutVal=0.720000),(InVal=1.000000,OutVal=0.300000)))
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.170000
		CrouchMultiplier=1
	End Object

	//=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.350000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=7500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		
		PlayerJumpFactor=1.050000
		InventorySize=4
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.5
		MagAmmo=32
		//ViewOffset=(Y=10.000000,Z=-25.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaProjFireParams'
        AltFireParams(0)=FireParams'ArenaAltFireParams'
    End Object
	
    Layouts(0)=WeaponParams'ArenaParams'
}