class PumaRepeaterWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PumaProjectile'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6500.000000
		Damage=75
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Fire')
		Recoil=512.000000
		Chaos=0.5
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.9500000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
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
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.700000
		FallingChaos=0.200000
		SprintChaos=0.200000
		AimAdjustTime=0.900000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=2000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		MagAmmo=8
		ViewOffset=(X=7.000000,Y=6.000000,Z=-13.000000)
		SightOffset=(X=-10.000000,Y=-0.035000,Z=19.500000)
		SightPivot=(Pitch=0)
		//WeaponModes(0)=(ModeName="Airburst: Impact Detonation",ModeID="WM_FullAuto")
		//WeaponModes(1)=(ModeName="Airburst: Proximity Detonation",ModeID="WM_FullAuto",bUnavailable=True)
		//WeaponModes(2)=(ModeName="Airburst: Variable Range Detonation")
		//InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}