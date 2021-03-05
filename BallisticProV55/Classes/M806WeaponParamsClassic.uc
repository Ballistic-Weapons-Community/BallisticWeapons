class M806WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Max=6000.000000)
			WaterTraceRange=3600.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=32.0
			HeadMult=3.125
			LimbMult=0.625
			DamageType=Class'BallisticProV55.DTM806Pistol'
			DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
			DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
			PenetrationEnergy=24.000000
			PenetrateForce=150
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=None
			MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
			FireSound=(Sound=Sound'BallisticSounds3.M806.M806Fire',Volume=0.700000)
			Recoil=3072.000000
			Chaos=-1.0
			Inaccuracy=(X=4,Y=4)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.250000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=None
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.200000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=1024)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=12
		SightOffset=(X=-15.000000,Y=-0.350000,Z=8.750000)
		SightPivot=(Pitch=1024,Roll=-1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}