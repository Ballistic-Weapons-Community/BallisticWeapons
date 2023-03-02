class ProtoWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2500.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.500000
		Damage=12.0
		HeadMult=3.75
		LimbMult=0.833333
		DamageType=Class'BWBP_APC_Pro.DTProto'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProto'
		PenetrationEnergy=24.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90Fire2',Volume=1.3)
		Recoil=48.000000
		Chaos=-1.0
		Inaccuracy=(X=21,Y=21)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.078000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Photon Burst
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPhotonPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		RangeAtten=0.100000
		Damage=22
		DamageType=Class'BWBP_APC_Pro.DTProtoPhoton'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoPhotonHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProtoPhoton'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.200000
		Recoil=70.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.F2000-FireAlt1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ClassicPhotonPrimaryFireParams
		FireInterval=0.085000
		PreFireAnim=
		FireEndAnim=
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=InstantEffectParams'ClassicPhotonPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.400000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.650000
		XRandFactor=0.100000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=120,Max=256)
		AimAdjustTime=1.200000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=850.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=50
		//SightOffset=(X=-8,Y=5.870000,Z=8.000000)
		//SightPivot=(Pitch=600)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPhotonPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}