class PKMMachinegunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		RangeAtten=0.35
		Damage=27
		DamageType=Class'BWBP_APC_Pro.DTPKM'
		DamageTypeHead=Class'BWBP_APC_Pro.DTPKMHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTPKM'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.PKMFlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=192.000000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.RPK940.RPK-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.110000
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
		
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.650000
			PreFireTime=0.450000
			PreFireAnim="KnifeFirePrep"
			FireAnim="KnifeFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.300000,OutVal=0.40000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.34000
		YRandFactor=0.34000
		YawFactor=0.5
		PitchFactor=0.5
		MaxRecoil=2048
		DeclineDelay=0.10
		DeclineTime=0.9
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=256,Max=2048)
		SprintOffset=(Pitch=-4000,Yaw=-8000)
		ChaosDeclineTime=1.600000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.900000
		InventorySize=15
		SightMoveSpeedFactor=0.9
		SightingTime=0.55000
		DisplaceDurationMult=1
		bNeedCock=True
		MagAmmo=75
		ViewOffset=(X=15.000000,Y=5.000000,Z=-7.000000)
		SightOffset=(X=-5.000000,Y=-1.1150000,Z=15.00000)
		SightPivot=(Pitch=64)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}