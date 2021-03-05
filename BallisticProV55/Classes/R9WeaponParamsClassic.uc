class R9WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=15000.000000)
			WaterTraceRange=12000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=72.0
			HeadMult=1.7
			LimbMult=0.5
			DamageType=Class'BallisticProV55.DTR9Rifle'
			DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
			DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
			PenetrationEnergy=48.000000
			PenetrateForce=150
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=None
			MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
			FlashScaleFactor=2.000000
			FireSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Fire',Volume=0.800000)
			Recoil=128.000000
			Chaos=-1.0
			BotRefireRate=0.150000
			WarnTargetPct=0.050000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.300000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=3072)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightOffset=(X=-2.000000,Z=15.400000)
		SightPivot=(Pitch=512)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}