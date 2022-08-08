class AR23WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=125.0
		HeadMult=2.1
		LimbMult=0.66
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.5
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.170000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=36
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=25
		LimbMult=1.0
		DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
		PenetrationEnergy=16.000000
		PenetrateForce=500
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
		Recoil=2048.000000
		Chaos=0.5
		Inaccuracy=(X=1600,Y=1600)
		HipSpreadFactor=1
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=2.500000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireAimed"
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=4096.000000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=2560)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}