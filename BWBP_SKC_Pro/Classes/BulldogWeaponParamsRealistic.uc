class BulldogWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=5500.000000,Max=7000.000000) //.75 HE shell
		WaterTraceRange=2100.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=195
		HeadMult=1.5
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DTBulldog'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBulldogHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBulldog'
		PenetrationEnergy=4.000000
		PenetrateForce=250
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=2.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-HFire',Volume=7.500000)
		Recoil=3096.000000
		Chaos=0.15
		Inaccuracy=(X=32,Y=32)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=1.650000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.5	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.BulldogRocketFast' //FRAG-12
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=20000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		Damage=150.000000
		DamageRadius=200.000000 //4 meter dmg radius, approx 2 meter kill radius
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
		Recoil=800.000000
		Chaos=0.15
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="SGFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.450000
		XRandFactor=0.450000
		YRandFactor=0.450000
		DeclineTime=1.700000
		DeclineDelay=0.300000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=720,Max=3824)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=9,Scale=0f)
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.750000
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=8
		bMagPlusOne=True
		ViewOffset=(X=20.000000,Y=0.000000,Z=-18.000000)
		SightOffset=(X=-40.000000,Y=13.500000,Z=20.100000)
		SightPivot=(Pitch=200)
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		WeaponName="Bulldog .75 Assault Cannon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}