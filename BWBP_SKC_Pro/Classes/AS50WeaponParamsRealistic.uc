class AS50WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000) //50 cal
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		//FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.FG50-HeavyFire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Pitch=1.000000,Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2600.000000
		Chaos=0.050000
		PushbackForce=100.000000
		Inaccuracy=(X=12,Y=12)
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnimRate=1.550000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Controlled
	Begin Object Class=InstantEffectParams Name=RealisticPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=2000.000000
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
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.200000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=4000.000000
		DeclineTime=1.750000
		DeclineDelay=0.500000
		ViewBindFactor=0.300000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=800,Max=3408)
		OffsetAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
		AimAdjustTime=0.7
	End Object

	Begin Object Class=AimParams Name=RealisticControlledAimParams
		AimSpread=(Min=800,Max=2808)
		OffsetAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.400000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=350
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
		AimAdjustTime=1
	End Object 
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.825000
		InventorySize=27
		SightMoveSpeedFactor=0.500000
		SightingTime=0.33
		MagAmmo=10
		bMagPlusOne=True
		ViewOffset=(X=4.000000,Y=-10.000000,Z=-15.000000)
		SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		ZoomType=ZT_Logarithmic
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		WeaponName="FSSG-50 12.7mm Anti-Materiel Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		AimParams(1)=AimParams'RealisticControlledAimParams'
		FireParams(0)=FireParams'RealisticPriControlledFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}