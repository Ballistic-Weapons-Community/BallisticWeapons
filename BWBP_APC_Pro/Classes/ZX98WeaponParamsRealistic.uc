class ZX98WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1700.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=50.0
		HeadMult=2.127272
		LimbMult=0.654545
		DamageType=Class'BWBP_APC_Pro.DTZX98Rifle'
		DamageTypeHead=Class'BWBP_APC_Pro.DTZX98RifleHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Rifle'
		PenetrationEnergy=28.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.ZX98.ZX98-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=825.000000
		Chaos=0.100000
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.550000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=3000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=146.0
		HeadMult=2.123287
		LimbMult=0.630136
		DamageType=Class'BWBP_APC_Pro.DTZX98Gauss'
		DamageTypeHead=Class'BWBP_APC_Pro.DTZX98GaussHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTZX98Gauss'
		PenetrationEnergy=30.000000
		PenetrateForce=350
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-QFire',Volume=1.500000)
		Recoil=1792.000000
		Chaos=0.800000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.250000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		BurstFireRateFactor=1.00
		FireAnim="ChargedFire"
		FireEndAnim=
		FireAnimRate=0.7500000	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.400000),(InVal=1.000000,OutVal=0.350000)))
		YawFactor=0.150000
		XRandFactor=0.285000
		YRandFactor=0.285000
		MaxRecoil=4000
		DeclineTime=0.900000
		DeclineDelay=0.140000
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
		AimSpread=(Min=620,Max=1336)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		ZoomType=ZT_Fixed
		ViewOffset=(X=5.000000,Y=4.000000,Z=-9.000000)
		SightOffset=(X=-10.000000,Y=-0.500000,Z=12.500000)
		SightPivot=(Pitch=64)
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=5
		WeaponPrice=3200
		SightMoveSpeedFactor=0.9
		SightingTime=0.450000		
		DisplaceDurationMult=1
		MagAmmo=20
		bMagPlusOne=True
		WeaponName="ZX-98 7.62mm Gauss Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}