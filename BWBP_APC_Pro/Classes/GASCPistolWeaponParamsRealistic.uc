class GASCPistolWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=900.000000,Max=4000.000000) //10mm Inc
		WaterTraceRange=4000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_APC_Pro.DTGASCPistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTGASCPistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTGASCPistol'
		PenetrationEnergy=11.000000
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.GASCFlashEmitter'
		FlashScaleFactor=0.10000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.GASC.Gaucho-Fire',Volume=1.200000)
		Recoil=700.000000
		Chaos=0.060000
		Inaccuracy=(X=16,Y=16)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Burst
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
		TraceRange=(Min=900.000000,Max=4000.000000) //10mm Inc
		WaterTraceRange=4000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BWBP_APC_Pro.DTGASCPistol'
		DamageTypeHead=Class'BWBP_APC_Pro.DTGASCPistolHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTGASCPistol'
		PenetrationEnergy=11.000000
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.GASCFlashEmitter'
		FlashScaleFactor=0.10000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.GASC.Gaucho-Fire',Volume=1.200000)
		Recoil=725.000000
		Chaos=0.120000
		Inaccuracy=(X=16,Y=16)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsBurst
		FireInterval=0.095000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=1.000000,OutVal=0.700000)))
		XRandFactor=1.00000
		YRandFactor=1.00000
		PitchFactor=0.100000
		YawFactor=0.100000
		MaxRecoil=2048
		DeclineTime=0.5
		DeclineDelay=0.00000
		ViewBindFactor=0.1
		ADSViewBindFactor=0.1
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=1280)
		ViewBindFactor=0.05
		ADSMultiplier=0.700000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		SprintChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.150000
		DisplaceDurationMult=1
		MagAmmo=16
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst of Four",ModeID="WM_BigBurst",Value=4.000000)
		WeaponModes(2)=(ModeName="Semi-Auto",ModeID="WM_BigBurst",Value=5.000000,bUnavailable=True)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		ViewOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
		SightOffset=(X=-5.000000,Y=-6.350000,Z=9.700000)
		WeaponName="GP-X22 10mm Incendiary Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsBurst'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}