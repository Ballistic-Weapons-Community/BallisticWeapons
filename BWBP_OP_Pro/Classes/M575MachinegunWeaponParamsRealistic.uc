class M575MachinegunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=10000.000000) //7.62 long barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=55.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_OP_Pro.DTM575MG'
		DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.M575.M575-FireHeavy',Volume=2.300000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=580.000000
		Chaos=0.080000
		Inaccuracy=(X=18,Y=18)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.120000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.200000
		Damage=49.000000
		HeadMult=2.0
		LimbMult=1.0
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-FireFrost',Volume=1.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=470.000000
		Chaos=0.050000
		Inaccuracy=(X=16,Y=16)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.130000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_RDS
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.450000)))
		PitchFactor=0.400000
		YawFactor=0.400000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3260.000000
		DeclineTime=1.000000
		DeclineDelay=0.135000;
		ViewBindFactor=0.350000
		ADSViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

		Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.450000)))
		PitchFactor=0.400000
		YawFactor=0.400000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3260.000000
		DeclineTime=1.000000
		DeclineDelay=0.135000;
		ViewBindFactor=0.350000
		ADSViewBindFactor=1
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=3072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		PlayerSpeedFactor=0.850000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=50
		//ViewOffset=(X=5.000000,Y=2.000000,Z=-9.000000)
		//SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		//SightPivot=(Pitch=128)
		WeaponName="M575 7.62mm Medium Machinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_RDS'
		RecoilParams(1)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		FireParams(3)=FireParams'RealisticPrimaryFireParams'
		FireParams(4)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}