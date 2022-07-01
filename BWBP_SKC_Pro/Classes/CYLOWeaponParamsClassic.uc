class CYLOWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=8000.000000,Max=12000.000000)
			WaterTraceRange=9600.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.650000
			Damage=35
			HeadMult=2.5
			LimbMult=0.7
			DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
			DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
			PenetrationEnergy=32.000000
			PenetrateForce=180
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
			FlashScaleFactor=0.500000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=130.000000
			Chaos=0.010000
			Inaccuracy=(X=96,Y=96)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.085500
			BurstFireRateFactor=1.00
			PreFireAnim=
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1250.000000,Max=1700.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		//FireSpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000)
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=1400,Y=1100)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.400000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="FireSG"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=1024.000000
		DeclineTime=0.800000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1600)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.900000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=28
		SightPivot=(Pitch=450)
		SightOffset=(X=15.000000,Y=13.575000,Z=22.1000)
		ViewOffset=(X=8.000000,Z=-14.000000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}