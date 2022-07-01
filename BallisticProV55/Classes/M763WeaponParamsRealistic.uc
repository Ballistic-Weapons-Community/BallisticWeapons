class M763WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=12.0
		HeadMult=2.25
		LimbMult=0.666666
		DamageType=Class'BallisticProV55.DTM763Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
		PenetrationEnergy=7.000000
		PenetrateForce=24
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
		Recoil=920.000000
		Chaos=0.120000
		Inaccuracy=(X=800,Y=800)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.360000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=2.500000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=120.000000,Max=120.000000)
		WaterTraceRange=5000.0
		Damage=63.0
		HeadMult=1.984126
		LimbMult=0.476190
		DamageType=Class'BallisticProV55.DTM763Hit'
		DamageTypeHead=Class'BallisticProV55.DTM763HitHead'
		DamageTypeArm=Class'BallisticProV55.DTM763Hit'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=1.200000,Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.900000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepHit"
		FireAnim="Hit"
		PreFireAnimRate=1.400000
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.100000)))
		YawFactor=0.100000
		XRandFactor=0.280000
		YRandFactor=0.280000
		MaxRecoil=2560.000000
		DeclineTime=0.800000
		DeclineDelay=0.190000
		ViewBindFactor=0.800000
		ADSViewBindFactor=0.800000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=8
		ViewOffset=(X=-2.000000,Y=6.000000,Z=-6.000000)
		SightOffset=(X=5.500000,Z=2.360000)
		SightPivot=(Pitch=0)
		InitialWeaponMode=1
		WeaponModes(0)=(bUnavailable=true,ModeName="Long-Range",bUnavailable=true,Value=0.500000)
		WeaponModes(1)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=true)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}