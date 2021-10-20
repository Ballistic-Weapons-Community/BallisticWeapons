class M763WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=2000.000000,Max=4000.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.200000
			TraceCount=12
			TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
			ImpactManager=Class'BallisticProV55.IM_Shell'
			Damage=25.0
			LimbMult=0.24
			DamageType=Class'BallisticProV55.DTM763Shotgun'
			DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
			DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
			FlashScaleFactor=2.000000
			FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Fire1',Volume=1.300000)
			Recoil=512.000000
			Chaos=-1.0
			Inaccuracy=(X=700,Y=450)
			HipSpreadFactor=1.000000
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.800000
			BurstFireRateFactor=1.00
			bCockAfterFire=True
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	/*
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=65.0
			HeadMult=1.538461
			LimbMult=0.461538
			DamageType=Class'BallisticProV55.DTM763Hit'
			DamageTypeHead=Class'BallisticProV55.DTM763HitHead'
			DamageTypeArm=Class'BallisticProV55.DTM763Hit'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			SpreadMode=FSM_Rectangle
			FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.900000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.800000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepHit"
			FireAnim="Hit"
			FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
		End Object
		*/
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=0.900000
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
		ViewBindFactor=0.150000
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
		SightOffset=(X=5.000000,Z=18.500000)
		SightPivot=(Pitch=512)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		//AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}