class MJ51WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.900000
		Damage=26
		DamageType=Class'BWBP_APC_Pro.DTMJ51Assault'
		DamageTypeHead=Class'BWBP_APC_Pro.DTMJ51AssaultHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTMJ51AssaultLimb'
		PenetrateForce=18
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
		FlashScaleFactor=0.450000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ55-Fire')
		Recoil=128.000000
		Chaos=0.040000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.082500
		BurstFireRateFactor=1.000000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//=================================================================
	// SECONDARY FIRE
	//=================================================================	

	Begin Object Class=GrenadeEffectParams Name=ArenaSecondaryEffectParams_HE
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=120
        ImpactDamage=150
		DamageRadius=1024.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_HE
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'ArenaSecondaryEffectParams_HE'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.250000,OutVal=0.060000),(InVal=0.400000,OutVal=-0.020000),(InVal=0.800000,OutVal=0.100),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.0900
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		ViewBindFactor=0.4
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================		
	Begin Object Class=WeaponParams Name=ArenaParams_HE
		Weight=10
		LayoutName="Irons + HE"
		SightOffset=(X=25.000000,Y=-6.4500000,Z=20.5000000)
		SightingTime=0.350000	
		SightMoveSpeedFactor=0.8
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=False)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_HE'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_EOtech
		Weight=10
		LayoutName="EOtech + HE"
		SightOffset=(X=25.000000,Y=-6.4500000,Z=20.5000000)
		SightingTime=0.350000	
		SightMoveSpeedFactor=0.8
		LayoutMesh=SkeletalMesh'BWBP_APC_Anim.M4A1Carbine_FPm'
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=False)
		WeaponModes(1)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_HE'
	End Object

	Layouts(0)=WeaponParams'ArenaParams_HE'
	Layouts(1)=WeaponParams'ArenaParams_EOtech'

	//Camos =====================================
	Begin Object Class=WeaponCamo Name=MJ51_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Camos(0)=WeaponCamo'MJ51_Black'
}