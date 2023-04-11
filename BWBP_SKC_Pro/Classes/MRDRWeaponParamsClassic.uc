class MRDRWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.600000
		Damage=18
		HeadMult=3.166666
		LimbMult=0.388888
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Body'
		PenetrationEnergy=16.000000
		PenetrateForce=135
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MRDR.MRDR-Fire')
		Recoil=16.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35
		HeadMult=2.428571
		LimbMult=0.714285
		DamageType=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MRDR88SpikeHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MRDR88Spike'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee1"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000),(InVal=0.600000,OutVal=0.200000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.200000),(InVal=0.200000,OutVal=0.500000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=1024.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=512,Max=513)
		AimAdjustTime=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
        InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=36
		//SightOffset=(X=-10.000000,Y=-0.800000,Z=13.100000)
		SightPivot=(Pitch=900,Roll=-800)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}