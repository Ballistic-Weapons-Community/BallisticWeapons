class FLASHWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=15000.000000
		Damage=180.000000
		DamageRadius=350.000000
		MomentumTransfer=10000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireInc',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=-1.0
		Inaccuracy=(X=400,Y=400)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.700000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=15000.000000
		Damage=180.000000
		DamageRadius=350.000000
		MomentumTransfer=10000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireInc',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=-1.0
		Inaccuracy=(X=400,Y=400)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=3.500000
		BurstFireRateFactor=1.00
		FireAnim="FireAll"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=768.000000
		DeclineTime=0.650000
		ViewBindFactor=0.500000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=1000,Max=2560)
		AimAdjustTime=0.600000
		OffsetAdjustTime=0.350000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		ChaosDeclineTime=1.300000
		ChaosSpeedThreshold=475.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.850000
		InventorySize=29
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		MagAmmo=4
		SightOffset=(X=0.000000,Y=5.300000,Z=23.300000)
		ZoomType=ZT_Fixed
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}