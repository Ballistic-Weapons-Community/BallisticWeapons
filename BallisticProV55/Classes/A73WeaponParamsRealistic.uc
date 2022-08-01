class A73WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A73Projectile'
		SpawnOffset=(X=-5.000000,Y=6.000000,Z=-4.000000)
		Speed=1350.000000
		MaxSpeed=6000.000000
		AccelSpeed=18000.000000
		Damage=67.0
		DamageRadius=72.000000
		MomentumTransfer=200.000000
		bLimitMomentumZ=False
		HeadMult=2.089552
		LimbMult=0.626865
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=false)
		Recoil=000.000000
		Chaos=0.00000
		Inaccuracy=(X=72,Y=72)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.250000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=5.000000,Y=6.000000,Z=-4.000000)
        Speed=400.000000
        AccelSpeed=8000.000000
        MaxSpeed=4200.000000
        Damage=100.000000
        DamageRadius=200.000000
        MomentumTransfer=100000.000000
		bLimitMomentumZ=False
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.1
        Recoil=960.000000
        Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectile'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        AmmoPerFire=6
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=1.000000
		FireAnimRate=0.90000	
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.300000),(InVal=0.700000,OutVal=0.500000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.200000
		XRandFactor=0.270000
		YRandFactor=0.270000
		MaxRecoil=1280.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=1792)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.400000
		ChaosSpeedThreshold=525.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=48
		ViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
		SightOffset=(X=-1-.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}