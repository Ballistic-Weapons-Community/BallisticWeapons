class CX85WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//15mm Cryon Seeker Spikes
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX85Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=50
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=1.350000
		Recoil=376.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX85.CX85-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="SeekerFlechette"
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//5.56mm mod
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_556
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.5
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
        PenetrationEnergy=32
		PenetrateForce=180
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.6
		Recoil=180
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_556
		FireInterval=0.08000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_556'
	End Object
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.350000
		Damage=5
		DamageType=Class'DTCX85Dart'
		DamageTypeHead=Class'DTCX85Dart'
		DamageTypeArm=Class'DTCX85Dart'
		PenetrateForce=0
		bPenetrate=False
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'AssaultSounds.PD97.TargetCycle01',Volume=1.250000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="FireAlt"
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object

	//Smart linked darts
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Smart
		FireInterval=0.750000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="FireAlt"
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		PitchFactor=0.500000
		YawFactor=0.300000
		MaxRecoil=4096.000000
		DeclineTime=2.000000
		DeclineDelay=0.165000
		ViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=2772)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=525
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3000,Yaw=-8000)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-1024,Yaw=-1024)
		FallingChaos=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.750000
		//Attachments
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=8
		DisplaceDurationMult=1
		MagAmmo=32
		bMagPlusOne=True
        ZoomType=ZT_Logarithmic
		WeaponName="CX85 15mm Flechette Cannon"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Smart'
    End Object 

	Begin Object Class=WeaponParams Name=RealisticParams_556
		//Layout core
		LayoutName="Seeker Spikes"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.750000
		//Attachments
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=8
		DisplaceDurationMult=1
		MagAmmo=60
		bMagPlusOne=True
        ZoomType=ZT_Logarithmic
		WeaponName="CX85 5.56mm Modified Rifle"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_556'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'RealisticParams'
    Layouts(1)=WeaponParams'RealisticParams_556'
}