class XK2WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //9mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.10000
		Damage=30.0
		HeadMult=2.566666
		LimbMult=0.666666
		DamageType=Class'BallisticProV55.DTXK2SMG'
		DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
		PenetrationEnergy=11.000000
		PenetrateForce=15
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Pitch=1.250000,Volume=1.100000)
		Recoil=520.000000
		Chaos=0.000000
		Inaccuracy=(X=10,Y=10)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.066666
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Ice
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryIceEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=14
		HeadMult=1.4f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.250000
		Recoil=98.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryIceFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryIceEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.550000,OutVal=0.20000),(InVal=0.800000,OutVal=-0.100000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.300000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2560.000000
		DeclineTime=0.550000
		DeclineDelay=0.150000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.0500000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3536,Yaw=-2048)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.050000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.18
		MagAmmo=40
		bMagPlusOne=True
		ViewOffset=(X=-2.000000,Y=6.500000,Z=-11.000000)
		SightOffset=(X=3.000000,Y=-0.032500,Z=11.300000)
		SightPivot=(Pitch=40)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Burst",ModeID="WM_BigBurst",Value=4.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=3
		ReloadAnimRate=0.950000
		CockAnimRate=1.000000
		WeaponName="XK2-SD 9mm Submachinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		FireParams(3)=FireParams'RealisticPrimaryFireParams'
		FireParams(4)=FireParams'RealisticPrimaryIceFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}