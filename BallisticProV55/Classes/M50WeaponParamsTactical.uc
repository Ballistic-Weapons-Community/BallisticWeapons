class M50WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=134.000000
		Chaos=0.02
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.0825 // 800 rpm
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=110
        ImpactDamage=110
		DamageRadius=512.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		PreFireTime=0.450000
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		CrouchMultiplier=0.750000
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineDelay=0.140000     
		DeclineTime=0.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.250000
		SightPivot=(Pitch=200)
		SightOffset=(Y=0.050000,Z=12.130000)
        SightingTime=0.2
		ViewOffset=(X=1.000000,Y=7.000000,Z=-8.000000)
        MagAmmo=30
        InventorySize=20
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}