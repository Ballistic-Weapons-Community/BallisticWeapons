class CX85WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX85Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		//TraceRange=(Min=9000.000000,Max=9000.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		//RangeAtten=0.350000
		Damage=50
		//Damage=85.000000
		DamageRadius=8.000000
		//DamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
		//DamageTypeHead=Class'BWBP_OP_Pro.DTCX85BulletHead'
		//DamageTypeArm=Class'BWBP_OP_Pro.DTCX85Bullet'
		//PenetrateForce=180
		//bPenetrate=True
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
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=8
		SightMoveSpeedFactor=0.8
		//ViewOffset=(X=25,Y=10,Z=-26)
		SightingTime=0.750000
		//ReloadAnimRate=0.800000
		DisplaceDurationMult=1
		MagAmmo=32
		bMagPlusOne=True
        ZoomType=ZT_Logarithmic
		WeaponName="CX85 15mm Flechette Cannon"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}