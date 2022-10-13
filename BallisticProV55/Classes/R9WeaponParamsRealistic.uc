class R9WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=10000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=93.0
		HeadMult=2.387096
		LimbMult=0.677419
		DamageType=Class'BallisticProV55.DTR9Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
		PenetrationEnergy=27.000000
		PenetrateForce=200
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=1.000000,Pitch=1.000000)
		Recoil=1024.000000
		Chaos=0.100000
		Inaccuracy=(X=9,Y=9)
		BotRefireRate=0.150000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"
		FireEndAnim=
		FireAnimRate=2.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.60000
		YawFactor=0.100000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=2560
		DeclineTime=0.800000
		DeclineDelay=0.190000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1664)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.125000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-3072)
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=13,Scale=0f)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23
		MagAmmo=12
		ViewOffset=(X=-4.000000,Y=9.00000,Z=-13.000000)
		SightOffset=(X=25.000000,Y=0.025000,Z=6.290000)
		SightPivot=(Pitch=64,Yaw=0)
		ReloadAnimRate=1.000000
		CockAnimRate=1.250000
		WeaponName="R9E2 .308 Ranger Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}