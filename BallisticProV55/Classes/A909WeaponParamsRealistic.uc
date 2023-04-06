class A909WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=100.000000,Max=100.000000)
		WaterTraceRange=5000.0
		Damage=65.0
		HeadMult=2.153846
		LimbMult=0.461538
		DamageType=Class'BallisticProV55.DTA909Blades'
		DamageTypeHead=Class'BallisticProV55.DTA909Head'
		DamageTypeArm=Class'BallisticProV55.DTA909Limb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.200000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.360000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="PrepHack"
		FireAnimRate=1.300000
	FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=76.000000,Max=76.000000)
		WaterTraceRange=5000.0
		Damage=115.0
		HeadMult=2.086956
		LimbMult=0.478260
		DamageType=Class'BallisticProV55.DTA909Blades'
		DamageTypeHead=Class'BallisticProV55.DTA909Head'
		DamageTypeArm=Class'BallisticProV55.DTA909Limb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.500000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepBigHack3"
		FireAnim="BigHack3"
		FireAnimRate=1.450000
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.200000
		InventorySize=2
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//ViewOffset=(X=63.000000,Y=-4.000000,Z=-6.000000)
		WeaponName="A909 Skrith Wrist Blades"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}