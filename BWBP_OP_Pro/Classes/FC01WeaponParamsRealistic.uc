class FC01WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Smart Seeker
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Smart
		ProjectileClass=Class'BWBP_OP_Pro.FC01SmartProj'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=20
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=1.350000
		Recoil=256.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.FC01.FC01-SmartShot',Volume=1.0)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Smart
		FireInterval=0.150000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="SeekerFlechette"
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Smart'
	End Object
	
	//5.7mm
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=750.000000Max=3750.000000)
		WaterTraceRange=750.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=25.0
		HeadMult=2.12
		LimbMult=0.6
		DamageType=Class'BWBP_OP_Pro.DT_FC01Body'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_FC01Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_FC01Body'
		PenetrationEnergy=7.000000
		PenetrateForce=14
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.FC01.P90Fire2',Pitch=1.200000,Volume=0.950000)
		//FireSound=(sound=sound'BallisticSounds3.UZI.UZI-Fire',Pitch=1.200000,Volume=0.950000)
		Recoil=480.000000
		Chaos=-1.0
		Inaccuracy=(X=28,Y=28)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.050000//4545
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Photon Burst
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPhotonPrimaryEffectParams
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

	Begin Object Class=FireParams Name=RealisticPhotonPrimaryFireParams
		FireInterval=0.085000
		PreFireAnim=
		FireEndAnim=
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=InstantEffectParams'RealisticPhotonPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
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
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		BurstFireRateFactor=1.00
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.250000,OutVal=0.300000),(InVal=0.400000,OutVal=-0.100000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.300000
		XRandFactor=0.240000
		YRandFactor=0.240000
		MaxRecoil=3200.000000
		DeclineTime=0.550000
		DeclineDelay=0.140000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
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
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Smart
		//Layout core
		LayoutName="6mm Smart"
		LayoutTags="TargetScope"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.25
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=5
		MagAmmo=40
		ViewOffset=(X=20.000000,Y=10.000000,Z=-18.000000)
		//SightOffset=(X=-10.00000,Z=10.450000)
		//SightPivot=(Pitch=16)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPhotonPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="5.7mm AP"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.25
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=5
		MagAmmo=50
		ViewOffset=(X=20.000000,Y=10.000000,Z=-18.000000)
		//SightOffset=(X=-10.00000,Z=10.450000)
		//SightPivot=(Pitch=16)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Smart'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Smart'
	Layouts(1)=WeaponParams'RealisticParams'
}