class MRS138WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=600.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=20.0
		HeadMult=2.15
		LimbMult=0.6
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRS138FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRS38.RSS-Fire',Volume=1.500000)
		Recoil=1792.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=900)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.500000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=1.3500000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=72.000000,Max=72.000000)
		WaterTraceRange=5000.0
		Damage=75.0
		HeadMult=1.4
		LimbMult=0.693333
		DamageType=Class'BallisticProV55.DTMRS138Tazer'
		DamageTypeHead=Class'BallisticProV55.DTMRS138Tazer'
		DamageTypeArm=Class'BallisticProV55.DTMRS138Tazer'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.900000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepAttack"
		FireAnim="Attack"
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1792
		DeclineTime=0.550000
		DeclineDelay=0.250000
		ViewBindFactor=0.700000
		ADSViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=640,Max=1280)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=5
		ViewOffset=(X=-1.000000,Y=8.500000,Z=-16.000000)
		SightOffset=(X=-3.000000,Z=17.150000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}