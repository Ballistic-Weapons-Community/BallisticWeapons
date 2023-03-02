class SRKSmgWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Automatic
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1100.000000,Max=4800.000000) //.45 SMG, long barrel
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=45.0
		HeadMult=2.6f
		LimbMult=0.6f
		DamageType=Class'BWBP_APC_Pro.DTSRKSmg'
		DamageTypeHead=Class'BWBP_APC_Pro.DTSRKSmgHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTSRKSmg'
		PenetrationEnergy=32.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgFlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.SRKS.SRKS-Fire')
		Recoil=120.000000
		Chaos=0.05
		Inaccuracy=(X=16,Y=16)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.SHADRACHRifleGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=65
		DamageRadius=320.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgAltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.600000
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireSight"			
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL - Automatic
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.550000,OutVal=-0.10000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.350000),(InVal=1.000000,OutVal=0.350000)))
		YawFactor=0.600000
		PitchFactor=0.200000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=4096.000000
		DeclineTime=0.8
		DeclineDelay=0.40000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=640,Max=1480)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.600000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		MagAmmo=36
		SightOffset=(X=-20.000000,Y=-0.350000,Z=15.800000)
		ViewOffset=(X=10.000000,Y=6.000000,Z=-12.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="SRK-205 .45 Submachinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}