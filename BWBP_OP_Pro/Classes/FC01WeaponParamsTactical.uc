class FC01WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//6mm Smart Seeker
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams_Smart
		ProjectileClass=Class'BWBP_OP_Pro.FC01SmartProj'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=25
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=1.350000
		Recoil=256.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.FC01.FC01-SmartShot',Volume=1.0)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Smart
		FireInterval=0.150000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="SeekerFlechette"
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Smart'
	End Object
	
	//5.7mm FMJ
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=20 // 5.7mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DT_FC01Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FC01Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FC01Body'
        PenetrationEnergy=16
		PenetrateForce=100
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FC01.P90Fire2',Pitch=1.200000,Volume=0.950000)
		Recoil=360.000000
		Chaos=0.02
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.050000 //real fast 1100rpm
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Photon Burst
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPhotonPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		RangeAtten=0.100000
		Damage=22
		DamageType=Class'BWBP_OP_Pro.DT_FC01Photon'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FC01PhotonHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FC01Photon'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.200000
		Recoil=70.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.F2000-FireAlt1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalPhotonPrimaryFireParams
		FireInterval=0.085000
		PreFireAnim=
		FireEndAnim=
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=InstantEffectParams'TacticalPhotonPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_OP_Pro.DT_FC01Photon'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FC01PhotonHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FC01Photon'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		BurstFireRateFactor=1.00
	FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		//XCurve=(Points=(,(InVal=0.250000,OutVal=0.300000),(InVal=0.400000,OutVal=-0.100000),(InVal=1.000000,OutVal=-0.200000)))
		//YCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		XCurve=(Points=(,(InVal=0.1,OutVal=0.01),(InVal=0.2,OutVal=0.07),(InVal=0.25,OutVal=0.06),(InVal=0.3,OutVal=0.03),(InVal=0.35,OutVal=0.00),(InVal=0.40000,OutVal=-0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.5,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		YawFactor=0.300000
		XRandFactor=0.240000
		YRandFactor=0.240000
		MaxRecoil=6400.000000
		DeclineTime=0.550000
		DeclineDelay=0.140000
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		ClimbTime=0.02
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0 //CYLO handling
		AimSpread=(Min=256,Max=1024)
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Smart
		//Layout core
		LayoutName="6mm Smart"
		LayoutTags="TargetScope"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=40
		ViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
		SightOffset=(X=0.00000,Y=-0.95,Z=24.450000)
		//SightPivot=(Pitch=16)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Smart'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="5.7mm AP"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=50
		ViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
		SightOffset=(X=0.00000,Y=-0.95,Z=24.450000)
		//SightPivot=(Pitch=16)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPhotonPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Smart'
	Layouts(1)=WeaponParams'TacticalParams'


}