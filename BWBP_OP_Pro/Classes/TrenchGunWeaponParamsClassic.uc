class TrenchGunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{ 
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicExploPrimaryEffectParams
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
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicExploPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000		
        TargetState="Shotgun"
	FireEffectParams(0)=ShotgunEffectParams'ClassicExploPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicElectroPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		RangeAtten=1.000000
		TraceCount=30
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=10
		DamageType=Class'DT_TrenchGunElectro'
		DamageTypeArm=Class'DT_TrenchGunElectro'
		DamageTypeHead=Class'DT_TrenchGunElectro'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.electro_Shot',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		Recoil=355.000000
		Chaos=1.000000
		Inaccuracy=(X=800,Y=750)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicElectroPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="Shotgun"
	FireEffectParams(0)=ShotgunEffectParams'ClassicElectroPrimaryEffectParams'
	End Object

	//=================================================================
	// PRIMARY FIRE - Dragon
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicDragonPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=2500.000000)
		RangeAtten=0.200000
		TraceCount=7
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DT_TrenchFire'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchFireHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchFire'
		MuzzleFlashClass=Class'BWBP_OP_Pro.RCS715FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=355.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicDragonPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="ShotgunIncendiary"
	FireEffectParams(0)=ShotgunEffectParams'ClassicDragonPrimaryEffectParams'
	End Object	
	
	//=================================================================
	// PRIMARY FIRE - FRAG-12
	//=================================================================	
		
	Begin Object Class=ProjectileEffectParams Name=ClassicFragPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.TrenchGunRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		Damage=110.000000
		DamageRadius=180.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		//FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-FireTest',Volume=2.500000)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Misc.GL-Fire',Volume=1.100000)
		Recoil=455.000000
		Chaos=-1.0
		Inaccuracy=(X=20,Y=20)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicFragPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
        TargetState="Projectile"
	FireEffectParams(0)=ProjectileEffectParams'ClassicFragPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="WrenchPoint"
		FireAnimRate=1.25
	FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.65
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.200000
		MaxRecoil=8384.000000
		DeclineTime=0.900000
		DeclineDelay=0.100000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams_Sawn
		AimSpread=(Min=32,Max=768)
		CrouchMultiplier=0.850000
		ADSMultiplier=0.650000
		ViewBindFactor=0.150000
		SprintChaos=0.300000
		JumpChaos=0.600000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
	
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2068)
		CrouchMultiplier=0.850000
		ADSMultiplier=0.650000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.800000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		//ViewOffset=(X=-50.000000,Y=20.000000,Z=-30.000000)
		//SightOffset=(X=50.000000,Y=11.500000,Z=43.500000)
		SightPivot=(Pitch=256)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=2
		bNeedCock=True
		WeaponModes(0)=(ModeName="Ammo: Explosive",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(2)=(ModeName="Ammo: Cryogenic",Value=1.000000,bUnavailable=True)
		WeaponModes(3)=(ModeName="Ammo: Dragon",Value=1.000000)
		WeaponModes(4)=(ModeName="Ammo: FRAG-12",Value=1.000000)
		InitialWeaponMode=4
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicExploPrimaryFireParams'
		FireParams(1)=FireParams'ClassicElectroPrimaryFireParams'
		FireParams(2)=FireParams'ClassicElectroPrimaryFireParams'
		FireParams(3)=FireParams'ClassicDragonPrimaryFireParams'
		FireParams(4)=FireParams'ClassicFRAGPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}