class GRSXXWeaponParamsRealistic extends BallisticWeaponParams;

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
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Glock.Glk-Fire',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=800.000000Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=33.0
		HeadMult=2.181818
		LimbMult=0.606060
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=6.000000
		PenetrateForce=16
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.T9CN.T9CN-FireSingle',Volume=1.200000)
		Recoil=512.000000
		Chaos=0.070000
		Inaccuracy=(X=13,Y=13)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
	
	//Amp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryAmpEffectParams
		TraceRange=(Min=12000.000000Max=14000.000000) //9mm Gauss Accel
		WaterTraceRange=800.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=55.0
		HeadMult=2.181818
		LimbMult=0.606060
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=12.000000
		PenetrateForce=32
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.200000)
		Recoil=256.000000
		Chaos=0.070000
		Inaccuracy=(X=10,Y=10)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryAmpFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.550000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryAmpEffectParams'
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
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.000000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.400000
		DeclineDelay=0.120000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//Burst
	Begin Object Class=RecoilParams Name=RealisticBurstRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.4000000
		YRandFactor=0.400000
		MaxRecoil=2048.000000
		DeclineTime=0.600000
		DeclineDelay=0.180000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=800.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15
		MagAmmo=33
		bMagPlusOne=True
		//ViewOffset=(X=6.000000,Y=7.000000,Z=-8.000000)
		//SightOffset=(X=-15.000000,Y=0.000000,Z=6.500000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,RecoilParamsIndex=1)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",RecoilParamsIndex=1)
		WeaponModes(3)=(ModeName="Amp: Hypermode",ModeID="WM_FullAuto",RecoilParamsIndex=1,bUnavailable=True)
		InitialWeaponMode=2
		//ReloadAnimRate=0.700000
		//CockAnimRate=1.400000
		WeaponName="GRS-XX 9mm Golden Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticBurstRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(2)=FireParams'RealisticPrimaryBurstFireParams'
		FireParams(3)=FireParams'RealisticPrimaryAmpFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(2)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(3)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}