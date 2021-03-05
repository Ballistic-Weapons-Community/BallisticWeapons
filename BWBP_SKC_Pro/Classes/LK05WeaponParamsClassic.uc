class LK05WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=10000.000000,Max=12000.000000)
			WaterTraceRange=9600.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.800000
			Damage=24
			HeadMult=3.125
			LimbMult=0.541666
			DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
			PenetrationEnergy=32.000000
			PenetrateForce=75
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			HookStopFactor=0.2
			HookPullForce=-10
			MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
			FlashScaleFactor=0.800000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
			Recoil=128.000000
			Chaos=-1.0
			Inaccuracy=(X=96,Y=96)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.080000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=1.300000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.7
		DeclineDelay=0.150000
		ViewBindFactor=0.600000
		ADSViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.450000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2250)
		CrouchMultiplier=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		MagAmmo=25
		SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}