class M2020WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=20000.000000)
			WaterTraceRange=18000.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.900000
			Damage=80
			HeadMult=1.6875
			LimbMult=0.5
			DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
			PenetrationEnergy=64.000000
			PenetrateForce=600
			bPenetrate=True
			PDamageFactor=0.750000
			WallPDamageFactor=0.750000
			MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
			FlashScaleFactor=1.200000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=3.700000)
			Recoil=2048.000000
			Chaos=-1.0
			Inaccuracy=(X=1,Y=1)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.850000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=1.000000
		YRandFactor=0.200000
		MaxRecoil=8096
		DeclineDelay=0.000000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.600000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightOffset=(X=0.000000,Y=-3.000000,Z=18.000000)
		ZoomType=ZT_Smooth
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}