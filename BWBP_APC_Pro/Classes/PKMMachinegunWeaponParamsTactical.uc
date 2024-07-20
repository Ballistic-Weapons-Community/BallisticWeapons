class PKMMachinegunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=16000.000000,Max=16000.000000)
		DecayRange=(Min=3150,Max=6300) // 60-120m
		RangeAtten=0.75
		Damage=60 //7.62x54R long barrel RU
		DamageType=Class'BWBP_APC_Pro.DTPKM'
		DamageTypeHead=Class'BWBP_APC_Pro.DTPKMHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTPKM'
		PenetrationEnergy=36.000000
		PenetrateForce=155
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.PKMFlashEmitter'
		FlashScaleFactor=1.100000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-Fire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=310.000000
		Chaos=0.080000
		Inaccuracy=(X=24,Y=24)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.092000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.PKMRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=4000.000000
		AccelSpeed=6000.000000
		Damage=155.000000
		DamageRadius=360.000000
		MomentumTransfer=2000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_APC_Pro.PKMRocketFlashEmitter'
		FireSound=(Sound=Sound'BWBP_CC_Sounds.rpk940.Fire',Volume=4.500000)
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=64,Y=64)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="KnifeFirePrep"
		FireAnim="KnifeFire"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.300000
		YawFactor=0.300000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2960.000000
		DeclineTime=1.100000
		DeclineDelay=0.140000
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		ClimbTime=0.04
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0 //MG
		ADSMultiplier=0.7
		AimAdjustTime=0.7
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		PlayerSpeedFactor=0.92
		InventorySize=7
		SightMoveSpeedFactor=0.35
		SightingTime=0.55
		DisplaceDurationMult=1
		MagAmmo=100
		SightOffset=(X=-2.000000,Y=-1.130000,Z=14.100000)
		SightPivot=(Pitch=-64)
		WeaponName="PKB-86 7.62mm GP Machinegun"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}