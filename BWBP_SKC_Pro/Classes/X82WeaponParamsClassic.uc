class X82WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000000.000000,Max=10000000.000000)
		WaterTraceRange=8000000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=145
		HeadMult=2.137931
		LimbMult=0.586206
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrationEnergy=72.000000
		PenetrateForce=450
		bPenetrate=True
		PDamageFactor=0.900000
		WallPDamageFactor=0.900000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire3',Volume=12.100000,Radius=450.000000)
		Recoil=1950.000000
		Chaos=1.500000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.450000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.500000
		XRandFactor=0.850000
		YRandFactor=0.450000
		MaxRecoil=2048.000000
		DeclineTime=2.200000
		ViewBindFactor=0.500000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.850000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=0,Max=3840)
		AimAdjustTime=0.900000
		OffsetAdjustTime=0.325000
		CrouchMultiplier=0.850000
		ADSMultiplier=0.850000
		ViewBindFactor=0.350000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
		ChaosDeclineTime=1.800000
		ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.750000
		InventorySize=9
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=4
		//SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Logarithmic
		//CockAnimRate=1.000000
		//ReloadAnimRate=0.400000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
}