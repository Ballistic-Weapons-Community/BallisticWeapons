class FG50WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1000.000000
		Chaos=0.250000
		PushbackForce=100.000000
		Inaccuracy=(X=12,Y=12)
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnimRate=1.550000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=384.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=6.750000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPriControlledFireParams
		FireInterval=0.500000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'RealisticPriControlledEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrationEnergy=72.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1000.000000
		Chaos=3.0
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
		PushbackForce=125.000000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.1200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticSecControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
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
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=6.750000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticSecControlledFireParams
		FireInterval=0.500000
		FireAnim="CFire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'RealisticSecControlledEffectParams'
	End Object
	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.200000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=4000.000000
		DeclineTime=1.250000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=3072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
	End Object

	Begin Object Class=AimParams Name=RealisticControlledAimParams
		AimAdjustTime=1
		ADSMultiplier=0.4
		AimSpread=(Min=16,Max=2048)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.825000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=40
		ViewOffset=(X=4.000000,Y=-10.000000,Z=-15.000000)
		SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		SightPivot=(Pitch=32)
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticControlledAimParams'
		FireParams(0)=FireParams'RealisticPriControlledFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecControlledFireParams'
		AltFireParams(2)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}