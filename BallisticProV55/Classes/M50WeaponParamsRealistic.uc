class M50WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=7500.000000) //5.56mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.266666
		LimbMult=0.666666
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Pitch=1.150000,Volume=1.10000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=600.000000
		Chaos=0.050000
		Inaccuracy=(X=9,Y=9)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.085714
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50GrenadeSafe'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=200.000000
		DamageRadius=400.000000
		MomentumTransfer=30000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"
		PreFireAnimRate=1.500000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.150000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=2800
		DeclineTime=0.725000
		DeclineDelay=0.175000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3072,Yaw=-6144)
		ChaosDeclineTime=1.450000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		ViewOffset=(X=-3.500000,Y=4.500000,Z=-9.000000)
		SightOffset=(X=1.000000,Y=0.050000,Z=12.09000)
		SightPivot=(Pitch=200,Roll=0)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="M50A1 5.56mm Assault Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}