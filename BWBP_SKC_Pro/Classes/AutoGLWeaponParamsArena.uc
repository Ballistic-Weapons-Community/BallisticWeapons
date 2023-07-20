class AutoGLWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AutoGLGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=140.000000
		DamageRadius=356.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AGLS.AGLS-Fire',Volume=9.200000)
		Recoil=256.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.210000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
    // PRIMARY FIRE - Unmounted
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParamsUnmount
		ProjectileClass=Class'BWBP_SKC_Pro.AutoGLGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=140.000000
		DamageRadius=356.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AGLS.AGLS-Fire',Volume=9.200000)
		Recoil=1024.0
		PushbackForce=500.000000
		Chaos=0.4
		Inaccuracy=(X=4,Y=4)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParamsUnmount
		FireInterval=0.250000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParamsUnmount'
	End Object
		
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=8192.000000
		//DeclineTime=0.900000
		DeclineTime=3.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=2560)
		CrouchMultiplier=0.900000
		ADSMultiplier=0.900000
		ViewBindFactor=0.250000
		SprintChaos=0.800000
		ChaosDeclineTime=3.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.700000
		PlayerJumpFactor=0.700000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=15
		//SightOffset=(X=-30.000000,Y=-0.48,Z=20.000000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaPrimaryFireParamsUnmount'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}