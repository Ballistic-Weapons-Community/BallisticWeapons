class M925TW_WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	

	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=50.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM925MG'
		DamageTypeHead=Class'BallisticProV55.DTM925MGHEad'
		DamageTypeArm=Class'BallisticProV55.DTM925MG'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.M925.M925-Fire',Volume=0.800000)
		Recoil=160.000000
		Chaos=0.35
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
		FlashScaleFactor=1.000000
		PushbackForce=200.000000
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		HipMultiplier=1.000000
		CrouchMultiplier=1.000000
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.400000),))
		XRandFactor=0.350000
		YRandFactor=0.100000
		YawFactor=0.000000
		MaxRecoil=800.000000
		DeclineTime=1.000000
		DeclineDelay=0.400000
		ViewBindFactor=0.000000
		bViewDecline=True
  	End Object

	//=================================================================
	// AIM
	//=================================================================
	  
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		AimAdjustTime=0.800000
		SprintChaos=0.400000
		ViewBindFactor=0.000000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimDamageThreshold=2000.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=850.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.8
		SightingTime=0.700000
		MagAmmo=50
        InventorySize=12
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}