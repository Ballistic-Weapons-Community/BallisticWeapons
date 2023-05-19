class PKMMachinegunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=10000.000000) /7.62x54R long barrel RU
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=60.0
		HeadMult=2.127272
		LimbMult=0.654545
		DamageType=Class'BWBP_APC_Pro.DTPKM'
		DamageTypeHead=Class'BWBP_APC_Pro.DTPKMHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTPKM'
		PenetrationEnergy=25.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_APC_Pro.PKMFlashEmitter'
		FlashScaleFactor=1.400000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-Fire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=580.000000
		Chaos=0.080000
		Inaccuracy=(X=24,Y=24)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.092000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.PKMRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=4000.000000
		AccelSpeed=6000.000000
		Damage=125.000000
		DamageRadius=360.000000
		MomentumTransfer=2000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_APC_Pro.PKMRocketFlashEmitter'
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.RPG.Fire',Volume=4.500000)
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=64,Y=64)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="KnifeFirePrep"
		FireAnim="KnifeFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.300000
		YawFactor=0.300000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2960.000000
		DeclineTime=1.100000
		DeclineDelay=0.140000;
		ViewBindFactor=0.350000
		ADSViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=3072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.550000
		ChaosSpeedThreshold=400
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.850000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=100
		//ViewOffset=(X=5.000000,Y=3.000000,Z=-7.500000)
		SightOffset=(X=-2.000000,Y=-1.130000,Z=14.100000)
		SightPivot=(Pitch=-64)
		WeaponName="PKB-86 7.62mm GP Machinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}