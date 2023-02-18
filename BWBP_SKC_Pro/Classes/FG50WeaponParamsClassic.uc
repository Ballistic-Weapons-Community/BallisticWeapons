class FG50WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=6000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
		PushBackForce=125.000000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.000000
		Recoil=384.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPriControlledFireParams
		FireInterval=0.600000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ClassicPriControlledEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=6000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
		PushbackForce=125.000000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.165000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicSecControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=384.000000
		Chaos=0.5
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicSecControlledFireParams
		FireInterval=0.600000
		FireAnim="CFire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'ClassicSecControlledEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.250000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.300000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2800
		DeclineTime=2.2
		DeclineDelay=0.3
		ViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.100000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimAdjustTime=1.000000
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.100000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		ChaosDeclineTime=1.500000
	End Object

	Begin Object Class=AimParams Name=ClassicControlledAimParams
		AimAdjustTime=1.1
		ADSMultiplier=0.4
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintChaos=0.500000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
	End Object 
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.890000
		PlayerJumpFactor=0.750000
		InventorySize=27
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=40
		SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		ViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		AimParams(0)=AimParams'ClassicAimParams'
		AimParams(1)=AimParams'ArenaControlledAimParams'
		FireParams(0)=FireParams'ClassicPriControlledFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecControlledFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}