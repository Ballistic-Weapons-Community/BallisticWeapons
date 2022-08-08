class R9WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.5
		Damage=45
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BallisticProV55.DTR9Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.7
		WarnTargetPct=0.4
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.225000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.5
		Damage=40
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BallisticProV55.DTR9Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.7
		WarnTargetPct=0.4
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaFreezeFireParams
		FireInterval=0.225000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaFreezeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaHeatEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.5
		Damage=35
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BallisticProV55.DTR9Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.7
		WarnTargetPct=0.4
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaHeatFireParams
		FireInterval=0.225000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaHeatEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.10000),(InVal=0.350000,OutVal=0.25000),(InVal=0.500000,OutVal=0.30000),(InVal=0.70000,OutVal=0.350000),(InVal=0.850000,OutVal=0.42000),(InVal=1.000000,OutVal=0.45)))
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

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosSpeedThreshold=450.000000
		ADSMultiplier=0.35
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=50)
		SightOffset=(X=25.000000,Y=0.010000,Z=8.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaFreezeFireParams'
		FireParams(2)=FireParams'ArenaHeatFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}