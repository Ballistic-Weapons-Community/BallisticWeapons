class Fifty9WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.181818
		LimbMult=0.606060
		DamageType=Class'BallisticProV55.DTFifty9SMG'
		DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
		PenetrationEnergy=7.000000
		PenetrateForce=20
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Pitch=1.000000,Volume=0.950000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=24,Y=24)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=80.000000,Max=80.000000)
		WaterTraceRange=5000.0
		Damage=57.0
		HeadMult=2.192982
		LimbMult=0.456140
		DamageType=Class'BallisticProV55.DTFifty9Blade'
		DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.750000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee1"
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.350000,OutVal=0.225000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.500000)))
		YawFactor=0.200000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2560.000000
		DeclineTime=0.600000
		DeclineDelay=0.125000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-1024);
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.165
		MagAmmo=36
		ViewOffset=(X=11.000000,Y=7.000000,Z=-9.000000)
		SightOffset=(X=-10.00000,Z=10.450000)
		SightPivot=(Pitch=16)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
        WeaponName="Fifty-9 9mm SMG"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}