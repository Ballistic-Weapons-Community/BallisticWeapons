class XK2WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=20
		HeadMult=1.4f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTXK2SMG'
		DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=72.000000
		Chaos=0.025000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Volume=0.500000,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//Ice
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryIceEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=14
		HeadMult=1.4f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.250000
		Recoil=98.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryIceFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryIceEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.15
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		AimSpread=(Min=16,Max=512)
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=7500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightPivot=(Pitch=256)
		SightOffset=(X=5.000000,Z=12.700000)
		ViewOffset=(X=4.000000,Y=8.000000,Z=-11.000000)
		DisplaceDurationMult=0.75
		PlayerSpeedFactor=1.000000
		MagAmmo=30
		SightingTime=0.250000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		FireParams(2)=FireParams'ArenaPrimaryFireParams'
		FireParams(3)=FireParams'ArenaPrimaryFireParams'
		FireParams(4)=FireParams'ArenaPrimaryIceFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}