class XM20BWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{ 
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=7500.000000)
		WaterTraceRange=6750.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=20
		HeadMult=1.75
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		PenetrateForce=600
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20BFlashEmitter'
		FlashScaleFactor=0.300000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.350000)
		Recoil=10.000000
		Chaos=0.01
		Inaccuracy=(X=16,Y=16)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=None	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		WaterTraceRange=3500.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.350000
		Damage=20
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20B_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20B_Body'
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XM20.XM20-LaserStart',Volume=1.200000)
		Recoil=1.0
		Chaos=-1.0
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.060000
		PreFireTime=0.100000
		BurstFireRateFactor=1.00
		PreFireAnim="LoopStart"
		FireLoopAnim="LoopFire"
		FireEndAnim="LoopEnd"	
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Overcharge
	Begin Object Class=FireParams Name=RealisticSecondaryFireParamsOvercharge
		FireInterval=0.013000
		PreFireTime=0.100000
		BurstFireRateFactor=1.00
		PreFireAnim="LoopOpenStart"
		FireLoopAnim="LoopOpenFire"
		FireEndAnim="LoopOpenEnd"
		FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=512.000000
		DeclineTime=1.000000
		ViewBindFactor=0.550000
		ADSViewBindFactor=0.550000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1424)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.450000
		ChaosSpeedThreshold=550.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=40
		SightOffset=(X=-10.000000,Y=9.7500000,Z=22.500000)
		ViewOffset=(X=1.000000,Y=-3.000000,Z=-17.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Smooth
		WeaponModes(0)=(ModeName="Laser Beam",bUnavailable=True)
		WeaponModes(1)=(ModeName="Laser: Quick Charge",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Laser: Overcharge",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		WeaponName="XM-20 Experimental Laser System"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(2)=FireParams'RealisticSecondaryFireParamsOvercharge'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'

}