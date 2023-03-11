class PS9mWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=3000.000000)
		Damage=20
		HeadMult=1f
		LimbMult=1f
		DamageType=Class'BWBP_SKC_Pro.DT_PS9MDart'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_PS9MDartHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_PS9MDart'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.800000
		Recoil=64.000000
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Fire',Volume=0.25,Radius=16,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.075000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PS9mMedDart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6500.000000
		Damage=20
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-DartFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		FireAnim="Dart_Fire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.000000),(InVal=0.50000,OutVal=0.120000),,(InVal=0.7000,OutVal=-0.010000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.4500000,OutVal=0.40000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.450000
		AimSpread=(Min=64,Max=128)
        ADSMultiplier=1
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		ViewOffset=(X=3.000000,Y=-3.000000,Z=-8.500000)
		SightOffset=(X=-10.000000,Y=11.400000,Z=7.900000)
		MagAmmo=15
		InventorySize=1
        SightingTime=0.200000
        DisplaceDurationMult=0.5
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}