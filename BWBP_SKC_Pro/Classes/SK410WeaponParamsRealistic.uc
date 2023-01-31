class SK410WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=750.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.600000
		TraceCount=8
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=25.0
		LimbMult=0.4
		DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=False
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.200000,Pitch=1.200000)
		Recoil=2048.000000
		Chaos=0.5
		Inaccuracy=(X=1100,Y=1100)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.140000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=10000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=80
        DamageRadius=256.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=2048.000000
        Chaos=0.450000
        BotRefireRate=0.6
        WarnTargetPct=0.4	
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000,Pitch=1.200000)
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        FireInterval=0.140000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.250000	
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=0.800000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.800000
		ADSMultiplier=0.800000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=8
		PlayerSpeedFactor=1.050000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		SightOffset=(X=-8.000000,Y=-10.000000,Z=21.000000)
		ReloadAnimRate=1.100000
		CockAnimRate=1.000000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		SightPivot=(Pitch=150)
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		WeaponName="SK-410 8ga Breaching Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticRDSParams
		InventorySize=8
		PlayerSpeedFactor=1.050000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		bMagPlusOne=True
		SightPivot=(Pitch=150)
		SightOffset=(X=20.000000,Y=-10.000000,Z=22.500000)
		ReloadAnimRate=1.100000
		CockAnimRate=1.000000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SK-410 8ga Breaching Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticRDSParams'


}