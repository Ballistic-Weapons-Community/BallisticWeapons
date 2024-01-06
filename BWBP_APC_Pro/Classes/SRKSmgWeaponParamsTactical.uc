class SRKSmgWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Automatic
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=1100.000000,Max=4800.000000)
        DecayRange=(Min=1300,Max=2363) // 25-45m
		Inaccuracy=(X=48,Y=48)
		RangeAtten=0.500000
		Damage=45.0  //.45 SMG, long barrel
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BWBP_APC_Pro.DTSRKSmg'
		DamageTypeHead=Class'BWBP_APC_Pro.DTSRKSmgHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTSRKSmg'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgFlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.SRKS.SRKS-Fire')
		Recoil=120.000000
		Chaos=0.05
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.SHADRACHRifleGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=65
		DamageRadius=320.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgAltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.600000
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireSight"			
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL - Automatic
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.550000,OutVal=-0.10000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.350000),(InVal=1.000000,OutVal=0.350000)))
		YawFactor=0.600000
		PitchFactor=0.200000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=4096.000000
		DeclineTime=0.8
		DeclineDelay=0.20000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.25
		ClimbTime=0.06
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=640,Max=1480)
		ViewBindFactor=0.200000
		ChaosDeclineTime=1.0
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		MagAmmo=36
		SightOffset=(X=-20.000000,Y=-0.350000,Z=15.800000)
		ViewOffset=(X=4.000000,Y=6.000000,Z=-12.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		WeaponName="SRK-205 .45 Submachinegun"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}