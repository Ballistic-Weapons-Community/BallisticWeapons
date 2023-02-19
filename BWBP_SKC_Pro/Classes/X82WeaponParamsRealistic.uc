class X82WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000) //50 cal
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=185.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire8',Volume=12.100000,Radius=450.000000)
		Recoil=2000.000000
		Chaos=0.050000
		PushbackForce=100.000000
		Inaccuracy=(X=12,Y=12)
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.850000
		BurstFireRateFactor=1.00
		FireAnimRate=0.950000
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
		YawFactor=0.500000
		XRandFactor=0.850000
		YRandFactor=0.450000
		MaxRecoil=3000.000000
		DeclineTime=1.150000
		DeclineDelay=0.500000
		ViewBindFactor=0.300000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=740,Max=2008)
		AimAdjustTime=0.900000
		OffsetAdjustTime=0.325000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.850000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		SightingTime=0.33
		MagAmmo=5
		bMagPlusOne=True
		ViewOffset=(X=-5,Y=5,Z=-9)
		SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Logarithmic
		CockAnimRate=1.000000
		ReloadAnimRate=0.400000
		WeaponName="X83A1 12.7mm Anti-Materiel Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}