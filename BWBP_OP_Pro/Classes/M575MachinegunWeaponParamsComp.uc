class M575MachinegunWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=15000.000000)
            DecayRange=(Min=2363,Max=5000)
			RangeAtten=0.67
			Damage=20
			DamageType=Class'BWBP_OP_Pro.DTM575MG'
			DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
			DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
			FlashScaleFactor=0.050000
			Recoil=80.000000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryFireParams
			FireInterval=0.082000
			FireEndAnim=
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
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

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.090000
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=12288.000000
		DeclineTime=0.5
		DeclineDelay=0.15000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=88,Max=768)
		ADSMultiplier=0.200000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		CockAnimRate=1.250000
		ReloadAnimRate=1.450000
		SightOffset=(X=-2.000000,Y=-0.375000,Z=13.220000)
		SightPivot=(Pitch=128)
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.550000
		DisplaceDurationMult=1
		MagAmmo=50
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		FireParams(2)=FireParams'ArenaPrimaryFireParams'
		FireParams(3)=FireParams'ArenaPrimaryFireParams'
		FireParams(4)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}