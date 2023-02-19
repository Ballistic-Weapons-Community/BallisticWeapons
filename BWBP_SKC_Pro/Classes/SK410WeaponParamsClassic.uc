class SK410WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
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
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=1400,Y=1200)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=6300.000000
        MaxSpeed=6300.000000
        AccelSpeed=3000.000000
        Damage=65
        DamageRadius=200.000000
        MomentumTransfer=10000.000000
		RadiusFallOffType=RFO_Linear
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.600000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000,Pitch=1.200000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
        BotRefireRate=0.6
        WarnTargetPct=0.4	
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        FireInterval=0.300000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=1.500000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1960)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.850000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		//BringUpTime=1.000000
		bNeedCock=True
		MagAmmo=6
		SightOffset=(X=-8.000000,Y=-10.000000,Z=21.000000)
		SightPivot=(Pitch=150)
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicRDSParams
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		bNeedCock=True
		MagAmmo=6
		SightPivot=(Pitch=150)
		SightOffset=(X=20.000000,Y=-10.000000,Z=22.500000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicRDSParams'


}