class G5WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.G5Rocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=800.000000
		MaxSpeed=4000.000000
		AccelSpeed=8000.000000
		Damage=250.000000
		DamageRadius=350.000000
		MomentumTransfer=75000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Fire1',Volume=1.3)
		Recoil=768.000000
		Chaos=0.100000
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.200000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=1.00000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
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
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=900,Max=2560)
		AimAdjustTime=0.450000
		OffsetAdjustTime=0.350000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.300000
		ChaosSpeedThreshold=475.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.825000
		PlayerJumpFactor=0.850000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.400000
		ZoomType=ZT_Logarithmic
		MagAmmo=2
		ViewOffset=(X=9.000000,Y=9.500000,Z=-3.000000)
		SightOffset=(X=-2.7500000,Y=-5.40000,Z=4.80000000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="G5 90mm Guided Missile Launcher"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}