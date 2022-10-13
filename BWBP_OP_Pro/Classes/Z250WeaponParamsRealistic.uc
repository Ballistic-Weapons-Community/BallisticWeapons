class Z250WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

//=================================================================
// PRIMARY FIRE
//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2250.000000,Max=9000.000000) //Explosive 12ga
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=135.000000
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeArm=Class'BWBP_OP_Pro.DTZ250Bullet'
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.Z250.Z250-DFire',Slot=SLOT_Interact,bNoOverride=False,Volume=5.750000)
		Recoil=256.000000
		Chaos=-1.000000
		PushbackForce=48.000000
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
//=================================================================
// SECONDARY FIRE
//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.Z250Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=30.000000
		DamageRadius=64.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_OP_Pro.Z250GrenadeFlashEmitter'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Z250.Z250-GrenadeFire',Slot=SLOT_Interact,bNoOverride=False,Volume=4.750000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireAnim="GLFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
//=================================================================
// RECOIL
//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.05000,OutVal=-0.200000),(InVal=0.20000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.350000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.050000),(InVal=0.475000,OutVal=0.250000),(InVal=0.575000,OutVal=0.500000),(InVal=0.675000,OutVal=0.400000),(InVal=0.825000,OutVal=0.500000),(InVal=1.000000,OutVal=0.350000)))
		PitchFactor=0.450000
		YawFactor=0.450000
		XRandFactor=0.3250000
		YRandFactor=0.32500000
		MaxRecoil=5500.000000
		DeclineTime=2.000000
		DeclineDelay=0.25
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.8
		bViewDecline=True
	End Object

//=================================================================
// AIM
//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimSpread=(Min=1336,Max=3884)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.9
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		AimDamageThreshold=375.000000
		ChaosDeclineTime=1.650000
		ChaosSpeedThreshold=350.000000
	End Object
    
//=================================================================
// BASIC PARAMS
//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.550000
		MagAmmo=50
		SightOffset=(X=50.000000,Y=-10.690000,Z=45.400002)
		ViewOffset=(X=1,Y=9,Z=-30)
		WeaponModes(0)=(ModeName="400 RPM",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="600 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(ModeName="800 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(3)=(ModeName="900 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(4)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="Z-250 20mm Explosive Chaingun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}