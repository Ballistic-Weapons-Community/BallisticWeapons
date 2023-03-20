class R9A1WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=45
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=420.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=40
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=420.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalFreezeFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalFreezeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalHeatEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		WaterTraceRange=5000
		RangeAtten=0.75
		Damage=35
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=240.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalHeatFireParams
		FireInterval=0.3000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalHeatEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.10000),(InVal=0.350000,OutVal=0.25000),(InVal=0.5,OutVal=0.30000),(InVal=0.70000,OutVal=0.350000),(InVal=0.850000,OutVal=0.42000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.175000),(InVal=0.400000,OutVal=0.450000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineDelay=0.350000
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.600000
		ChaosSpeedThreshold=300
		ADSMultiplier=0.5
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Roll=11800)
		SightOffset=(X=15.000000,Y=2.850000,Z=9.000000)
		ViewOffset=(Y=9.500000,Z=-11.000000)
		InventorySize=6
		SightMoveSpeedFactor=0.4
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalFreezeFireParams'
		FireParams(2)=FireParams'TacticalHeatFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}