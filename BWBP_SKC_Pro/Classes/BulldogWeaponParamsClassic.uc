class BulldogWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=5500.000000,Max=7000.000000)
		WaterTraceRange=2100.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.400000
		Damage=105
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
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=1.100000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Bulldog.Bulldog-Fire',Volume=7.500000)
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=16,Y=9)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.500000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.5	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.BulldogRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		Damage=110.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
		Recoil=1048.000000
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="SGFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.450000
		XRandFactor=0.450000
		YRandFactor=0.450000
		DeclineTime=0.700000
		DeclineDelay=0.100000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=720,Max=3824)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=1250.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=9,Scale=0f)
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.750000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=8
		ViewOffset=(X=11.000000,Y=2.000000,Z=-6.000000)
		SightOffset=(X=-18.000000,Y=4.475000,Z=6.800000)
		SightPivot=(Pitch=256)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}