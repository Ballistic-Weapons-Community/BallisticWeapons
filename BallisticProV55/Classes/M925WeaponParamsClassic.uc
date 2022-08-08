class M925WeaponParamsClassic extends BallisticWeaponParams;

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
		Chaos=-1.0
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
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.250000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.600000
		YRandFactor=0.500000
		MaxRecoil=3000.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.850000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=50
		SightOffset=(X=-20.000000,Z=9.150000)
		SightPivot=(Pitch=512)
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'

}