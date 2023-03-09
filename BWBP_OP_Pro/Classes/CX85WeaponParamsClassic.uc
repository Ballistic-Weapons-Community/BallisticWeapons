class CX85WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX85Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		//TraceRange=(Min=9000.000000,Max=9000.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		//RangeAtten=0.350000
		Damage=45
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
		Recoil=256.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX85.CX85-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="SeekerFlechette"
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="FireAlt"
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=(,(InVal=0.100000),(InVal=0.250000,OutVal=0.120000),(InVal=0.400000,OutVal=0.180000),(InVal=0.800000,OutVal=0.220000),(InVal=1.000000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.445000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.25000
		YRandFactor=0.25000
		DeclineTime=1.000000
		DeclineDelay=0.100000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2048)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.600000
		ChaosDeclineTime=2.000000
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3000,Yaw=-8000)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-1024,Yaw=-1024)
		FallingChaos=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=19
		SightMoveSpeedFactor=0.8
		SightingTime=0.700000
		ReloadAnimRate=0.800000
		DisplaceDurationMult=1
		bNeedCock=True
		MagAmmo=32
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}