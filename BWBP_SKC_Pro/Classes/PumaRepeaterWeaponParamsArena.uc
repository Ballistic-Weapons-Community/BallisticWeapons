class PumaRepeaterWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================
	
	//Impact Det
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryImpactEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectileFast'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6500.000000
		Damage=80
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryImpactFireParams
		FireInterval=0.900000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryImpactEffectParams'
	End Object

	//Proximity Det
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryProxyEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectile'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=70
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryProxyFireParams
		FireInterval=1.1250000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryProxyEffectParams'
	End Object
	
	//Range Det
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryRangeEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectileRShort'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=8500.000000
		Damage=70
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryRangeFireParams
		FireInterval=0.900000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryRangeEffectParams'
	End Object
	
	//Shield Explosion
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryShieldEffectParams
		ProjectileClass=Class'PumaProjectileClose'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6000.000000
		Damage=110.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryShieldFireParams
		FireInterval=1.125000
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryShieldEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		SpreadMode=None
		MuzzleFlashClass=None
		FlashScaleFactor=None
		FireSound=None
		Recoil=None
		Chaos=None
		PushbackForce=None
		Inaccuracy=None
		SplashDamage=None
		RecommendSplashDamage=None
		BotRefireRate=0.300000
		WarnTargetPct=None
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
	FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=4096
		DeclineDelay=0.350000
		DeclineTime=0.900000
		CrouchMultiplier=0.200000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=32,Max=512)
		SprintOffSet=(Pitch=-7000,Yaw=-3000)
		OffsetAdjustTime=0.600000
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		JumpChaos=0.700000
		FallingChaos=0.200000
		SprintChaos=0.200000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=2000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.8
		PlayerJumpFactor=0.8
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		MagAmmo=8
		ViewOffset=(X=7.000000,Y=6.000000,Z=-13.000000)
		SightOffset=(X=-10.000000,Y=-0.035000,Z=19.500000)
		SightPivot=(Pitch=0)
		WeaponModes(0)=(ModeName="Airburst: Impact Detonation",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Airburst: Proximity Detonation",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Airburst: Variable Range Detonation",ModeID="WM_FullAuto")
		//WeaponModes(3)=(ModeName="Shield (UNUSED)",bUnavailable=true)
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryImpactFireParams'
		FireParams(1)=FireParams'ArenaPrimaryProxyFireParams'
		FireParams(2)=FireParams'ArenaPrimaryRangeFireParams'
		FireParams(3)=FireParams'ArenaPrimaryShieldFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}