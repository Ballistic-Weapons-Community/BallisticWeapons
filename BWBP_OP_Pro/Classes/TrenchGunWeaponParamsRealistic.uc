class TrenchGunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{ 
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticExploPrimaryEffectParams
		TraceRange=(Min=2048.000000,Max=2560.000000)
		RangeAtten=0.250000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		Damage=12
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=1462.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticExploPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000		
        TargetState="Shotgun"
	FireEffectParams(0)=ShotgunEffectParams'RealisticExploPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticElectroPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		RangeAtten=1.000000
		TraceCount=5
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=60
		DamageType=Class'DT_TrenchGunElectro'
		DamageTypeArm=Class'DT_TrenchGunElectro'
		DamageTypeHead=Class'DT_TrenchGunElectro'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.electro_Shot',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		Recoil=462.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticElectroPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'RealisticElectroPrimaryEffectParams'
	End Object

	//=================================================================
	// PRIMARY FIRE - Dragon
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticDragonPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=2500.000000)
		RangeAtten=0.200000
		TraceCount=7
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=5
		DamageType=Class'BWBP_OP_Pro.DT_TrenchFire'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchFireHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchFire'
		MuzzleFlashClass=Class'BWBP_OP_Pro.RCS715FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=1462.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticDragonPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="ShotgunIncendiary"
	FireEffectParams(0)=ShotgunEffectParams'RealisticDragonPrimaryEffectParams'
	End Object	
	
	//=================================================================
	// PRIMARY FIRE - FRAG-12
	//=================================================================	
		
	Begin Object Class=ProjectileEffectParams Name=RealisticFragPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.TrenchGunRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		Damage=150.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		//FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Misc.GL-Fire',Volume=1.100000)
		Recoil=1462.000000
		Chaos=-1.0
		Inaccuracy=(X=20,Y=20)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticFragPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="Projectile"
	FireEffectParams(0)=ProjectileEffectParams'RealisticFragPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="WrenchPoint"
		FireAnimRate=1.25
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.500000,OutVal=0.800000),(InVal=0.850000,OutVal=-0.500000),(InVal=1.000000,OutVal=-0.300000)))
		YawFactor=0.200000
		XRandFactor=0.450000
		YRandFactor=0.350000
		MaxRecoil=1462.000000
		DeclineTime=0.400000
		DeclineDelay=0.165000
		ViewBindFactor=0.700000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=1400)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048)
		JumpChaos=0.800000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=600.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//ViewOffset=(X=-50.000000,Y=20.000000,Z=-30.000000)
		//SightOffset=(X=50.000000,Y=11.500000,Z=43.500000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=6
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(1)=(ModeName="Ammo: Dragon",Value=1.000000)
		WeaponModes(2)=(ModeName="Ammo: FRAG-12",Value=1.000000)
		InitialWeaponMode=2
		WeaponName="BR-112 12g Customized Trenchgun"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticElectroPrimaryFireParams'
		FireParams(1)=FireParams'RealisticDragonPrimaryFireParams'
		FireParams(2)=FireParams'RealisticFRAGPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}