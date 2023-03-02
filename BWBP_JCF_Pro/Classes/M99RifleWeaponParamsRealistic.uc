class M99RifleWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000) //55 cal
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=205.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrationEnergy=64.000000
		PenetrateForce=0.000000
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99-Fire',Volume=5.500000)
		Recoil=3000.000000
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
		XRandFactor=0.650000
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
		AimSpread=(Min=940,Max=2208)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=350
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		SightingTime=0.900000
		PlayerSpeedFactor=0.850000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		SightOffset=(X=-10.000000,Y=20.000000,Z=36.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=25.000000,Y=-3.000000,Z=-24.500000)
		ZoomType=ZT_Smooth
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		WeaponName="M100-ECS .55 Anti-Materiel Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}