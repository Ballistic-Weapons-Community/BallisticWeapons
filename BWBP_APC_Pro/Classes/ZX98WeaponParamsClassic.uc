class ZX98WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		RangeAtten=0.800000
		Damage=40
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_APC_Pro.DTZX98Rifle'
		DamageTypeHead=Class'BWBP_APC_Pro.DTZX98RifleHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Rifle'
		PenetrateForce=150
		PenetrationEnergy=48
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.ZX98FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=192.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_APC_Sounds.ZX98.ZX98-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.5500000
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=15000.000000,Max=20000.000000)
		RangeAtten=0.350000
		Damage=100
		HeadMult=1.35
		LimbMult=0.65
		DamageType=Class'BWBP_APC_Pro.DTZX98Gauss'
		DamageTypeHead=Class'BWBP_APC_Pro.DTZX98GaussHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Gauss'
		PenetrateForce=150
		PenetrationEnergy=64
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.ZX98SFlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=2048.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="ChargedFire"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.300000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=2.00000
		ChaosSpeedThreshold=7000.000000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		ZoomType=ZT_Fixed
		SightOffset=(X=-10.000000,Y=-0.500000,Z=12.500000)
		SightPivot=(Pitch=64)
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		bNeedCock=True
		MagAmmo=20
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}