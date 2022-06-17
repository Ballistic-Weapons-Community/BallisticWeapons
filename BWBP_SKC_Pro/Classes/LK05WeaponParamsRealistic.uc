class LK05WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=7500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=48.0
		HeadMult=2.333333
		LimbMult=0.666666
		PenetrationEnergy=19.000000
		PenetrateForce=55
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
		Recoil=700.000000
		Chaos=0.080000
		Inaccuracy=(X=10,Y=10)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
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

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.350000),(InVal=0.750000,OutVal=0.325000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.475000,OutVal=0.3250000),(InVal=0.750000,OutVal=0.425000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.175000
		XRandFactor=0.165000
		YRandFactor=0.165000
		MaxRecoil=3000.000000
		DeclineTime=0.775000
		DeclineDelay=0.180000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		SprintChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=30
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=-8.000000,Y=7.000000,Z=-11.000000)
		SightOffset=(X=8.000000,Y=-0.045000,Z=8.140000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}