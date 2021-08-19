class Mk781WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=3000.000000,Max=5000.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.600000
			TraceCount=10
			TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Flechette'
			ImpactManager=Class'BallisticProV55.IM_Shell'
			Damage=15
			HeadMult=2.0
			LimbMult=0.333333
			DamageType=Class'BWBP_SKC_Pro.DTM781Shotgun'
			DamageTypeHead=Class'BWBP_SKC_Pro.DTM781ShotgunHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DTM781Shotgun'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BWBP_SKC_Pro.Mk781FlashEmitter'
			FlashScaleFactor=2.000000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MK781.Mk781-Fire',Volume=1.300000)
			Recoil=768.000000
			Chaos=-1.0
			Inaccuracy=(X=400,Y=350)
			HipSpreadFactor=1.000000
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.400000
			BurstFireRateFactor=1.00
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=2000.000000,Max=4000.000000)
			WaterTraceRange=5000.0
			RangeAtten=1.000000
			TraceCount=30
			TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
			ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
			Damage=10
			HeadMult=1.5
			LimbMult=0.9
			DamageType=Class'BWBP_SKC_Pro.DT_Mk781Electro'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_Mk781Electro'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_Mk781Electro'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
			FlashScaleFactor=2.000000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Hit',Volume=1.600000)
			Recoil=768.000000
			Chaos=-1.0
			Inaccuracy=(X=1300,Y=1200)
			HipSpreadFactor=1.000000
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.500000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.600000
		YRandFactor=0.700000
		DeclineDelay=0.200000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		SightOffset=(X=10.000000,Y=-7.645,Z=11.90000)
		SightPivot=(Pitch=-64,Yaw=10)
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicRDSParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		SightOffset=(X=20.000000,Y=-7.660000,Z=13.940000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicRDSParams'


}