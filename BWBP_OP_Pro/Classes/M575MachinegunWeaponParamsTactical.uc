class M575MachinegunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=15000.000000)
            DecayRange=(Min=2363,Max=5000)
			RangeAtten=0.67
			Damage=34
			DamageType=Class'BWBP_OP_Pro.DTM575MG'
			DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
			DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
			PenetrationEnergy=32
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
			FlashScaleFactor=0.050000
			Recoil=200.000000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		End Object

		Begin Object Class=FireParams Name=TacticalPrimaryFireParams
			FireInterval=0.082000
			FireEndAnim=
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
            DecayRange=(Min=2363,Max=5000)
			RangeAtten=0.200000
			Damage=14
			DamageType=Class'BWBP_OP_Pro.DTM575Freeze'
			DamageTypeHead=Class'BWBP_OP_Pro.DTM575Freeze'
			DamageTypeArm=Class'BWBP_OP_Pro.DTM575Freeze'
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_OP_Pro.M575FlashEmitter'
			FlashScaleFactor=0.250000
			Recoil=70.000000
			Chaos=0.050000
			FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		End Object

		Begin Object Class=FireParams Name=TacticalSecondaryFireParams
			FireInterval=0.090000
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=12288.000000
		DeclineTime=0.5
		DeclineDelay=0.15000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=768,Max=3072)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimAdjustTime=0.700000
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		SightPivot=(Pitch=128)
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=85
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
}