class LonghornWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LonghornGrenade'
		Speed=3500.000000
		MaxSpeed=3500.000000
		Damage=200
		DamageRadius=450.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-Fire',Volume=1.500000)
		Recoil=512.000000
		Chaos=-1.0
		PushbackForce=300.000000
		Inaccuracy=(X=150,Y=300)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		TargetState="TimedCharge"
		FireInterval=0.40000
		BurstFireRateFactor=1.00
		bCockAfterFire=True	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'LonghornMicroClusterAltImpact'
		Speed=3800.000000
		Damage=25.000000
		DamageRadius=250.000000
		MomentumTransfer=15000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Longhorn.Longhorn-FireAlt',Volume=1.700000)
		Recoil=0.0
		Chaos=-1.0
		PushbackForce=800.000000
		Inaccuracy=(X=500,Y=500)
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		BurstFireRateFactor=1.00
		bCockAfterFire=True	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		DeclineDelay=0.100000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=8,Max=2560)
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.200000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpOffSet=(Pitch=1000)
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=800.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		MagAmmo=4
		//SightOffset=(Y=19.60,Z=26.40)
		SightPivot=(Pitch=150)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}