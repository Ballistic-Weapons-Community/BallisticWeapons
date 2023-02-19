class LAWWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWRocketHvy'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=7000.000000
		MaxSpeed=15000.000000
		AccelSpeed=1500.000000
		Damage=250.000000
		DamageRadius=1200.000000
		MomentumTransfer=300000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-FireLoud',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=6024.000000
		Chaos=-1.0
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.950000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWGrenadeHvy'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=3096.000000
		Chaos=-1.0
		Inaccuracy=(X=256,Y=256)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.600000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=9024.000000
		DeclineTime=1.000000
		DeclineDelay=0.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.400000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=70,Max=2600)
		AimAdjustTime=0.750000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.400000
		ADSMultiplier=0.100000
		ViewBindFactor=0.300000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.700000
		InventorySize=30
		SightMoveSpeedFactor=0.500000
		SightingTime=0.750000
		MagAmmo=1
		SightOffset=(Y=6.000000,Z=15.000000)
		ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}