class CoachWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE - 10ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.400000
		Damage=30
		TraceCount=10
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-FireDouble',Volume=1.200000)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=1000,Y=750)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		AmmoPerFire=1
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - 10ga Super Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_SuperSlug
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=125
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_SuperSlug
		FireInterval=0.300000
		AmmoPerFire=1
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_SuperSlug'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - 12ga Shot
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_12Sawn
		TraceRange=(Min=1200.000000,Max=1500.000000)
		RangeAtten=0.130000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'DT_CoachSawnOff'
		DamageTypeHead=Class'DT_CoachSawnOff'
		DamageTypeArm=Class'DT_CoachSawnOff'
		Damage=18
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.500000
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=2000,Y=1300)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_12Sawn
		FireInterval=0.150000
		AmmoPerFire=1
		FireAnimRate=0.8
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_12Sawn'
	End Object

	//=================================================================
	// PRIMARY FIRE - 12ga Slug
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_12SawnSlug
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=80
		DamageType=Class'DT_CoachSlug'
		DamageTypeHead=Class'DT_CoachSlug'
		DamageTypeArm=Class'DT_CoachSlug'
        HeadMult=1.5f
        LimbMult=0.8f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=1024.000000
		Chaos=100.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=256,Y=256)
		HipSpreadFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_12SawnSlug
		FireInterval=0.150000
		AmmoPerFire=1
		FireAnimRate=0.8
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_12SawnSlug'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Exp
		TraceRange=(Min=2048.000000,Max=2560.000000)
		RangeAtten=0.250000
		TraceCount=10
		TracerClass=class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=12
		Inaccuracy=(X=220,Y=220)
		DamageType=class'DT_CoachGunExplosive'
		DamageTypeHead=class'DT_CoachGunExplosive'
		DamageTypeArm=class'DT_CoachGunExplosive'
		MuzzleFlashClass=class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Exp
		FireInterval=0.100000
		FireAnimRate=0.800000		
		AmmoPerFire=1
        TargetState="ShotgunHE"
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Exp'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Shock
		TraceRange=(Min=2500.000000,Max=4500.000000)
		RangeAtten=1.000000
		TraceCount=30
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=10
		DamageType=class'DT_CoachGunElectro'
		DamageTypeArm=class'DT_CoachGunElectro'
		DamageTypeHead=class'DT_CoachGunElectro'
		MuzzleFlashClass=class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.electro_Shot',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		Recoil=355.000000
		Chaos=1.000000
		Inaccuracy=(X=800,Y=750)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Shock
		FireInterval=0.100000
		FireAnimRate=0.800000	
		AmmoPerFire=1
        TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Shock'
	End Object

	//=================================================================
	// PRIMARY FIRE - Dragon
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams_Flame
		TraceRange=(Min=2500.000000,Max=2500.000000)
		RangeAtten=0.200000
		TraceCount=7
		TracerClass=class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=class'DT_CoachFire'
		DamageTypeHead=class'DT_CoachFireHead'
		DamageTypeArm=class'DT_CoachFire'
		MuzzleFlashClass=class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=355.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Flame
		FireInterval=0.100000
		FireAnimRate=0.800000	
		AmmoPerFire=1
        TargetState="ShotgunIncendiary"
	FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams_Flame'
	End Object	
	
	//=================================================================
	// PRIMARY FIRE - FRAG-12
	//=================================================================	
		
	Begin Object Class=GrenadeEffectParams Name=ClassicPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_SKC_Pro.CoachGunRocket'
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
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Misc.GL-Fire',Volume=1.100000)
		Recoil=455.000000
		Chaos=-1.0
		Inaccuracy=(X=20,Y=20)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Frag
		FireInterval=0.100000
		FireAnimRate=0.800000	
		AmmoPerFire=1
        TargetState="Projectile"
	FireEffectParams(0)=GrenadeEffectParams'ClassicPrimaryEffectParams_Frag'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//10ga Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=2500.000000,Max=4500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.400000
		Damage=30
		TraceCount=10
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=800,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireInterval=0.150000
		AmmoPerFire=1
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//10ga super slug
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=125
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=5.100000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=1
		MaxHoldTime=0.0
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondarySlugEffectParams'
	End Object	
	
	//12ga shot - sawn
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryShotEffectParams_12Sawn
		TraceRange=(Min=1200.000000,Max=1500.000000)
		RangeAtten=0.130000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		Damage=18
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.500000
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1300,Y=1300)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.500000)	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireShotParams_12Sawn
		FireInterval=0.150000
		AmmoPerFire=1
		MaxHoldTime=0.0
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireAnimRate=1.35
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryShotEffectParams_12Sawn'
	End Object
	
	//12ga slug - sawn
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondarySlugEffectParams_12Sawn
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=1.5f
        LimbMult=0.8f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=1024.000000
		Chaos=100.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=256,Y=256)
		HipSpreadFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireSlugParams_12Sawn
		FireInterval=0.150000
		MaxHoldTime=0.0
		FireAnim="SightFire"
		AimedFireAnim="SightFire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondarySlugEffectParams_12Sawn'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=9192.000000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.850000
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
		AimSpread=(Min=32,Max=1868)
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
		//Layout core
		LayoutName="Coach Gun"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//ADS
		SightMoveSpeedFactor=0.500000
		//Function
		PlayerSpeedFactor=1.000000
		InventorySize=6
		MagAmmo=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_SuperSlug'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireSlugParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_SawnOff
		//Layout core
		LayoutName="Sawn Off"
		LayoutTags="quickload"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_SawnOff'
		PickupMesh=StaticMesh'BWBP_SKC_Static.SawnOff.SawnOffPickupLo'
		PickupDrawScale=0.1
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		//Function
		ReloadAnimRate=1.500000
		PlayerSpeedFactor=1.100000
		InventorySize=4
		MagAmmo=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams_Sawn'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_12Sawn'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_12SawnSlug'
		AltFireParams(0)=FireParams'ClassicSecondaryFireShotParams_12Sawn'
		AltFireParams(1)=FireParams'ClassicSecondaryFireSlugParams_12Sawn'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Trench
		//Layout core
		LayoutName="Trench Custom"
		LayoutTags="shield"
		Weight=10
		AllowedCamos(0)=5
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Trenchgun'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_Trenchgun'
		PickupMesh=StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupHi'
		PickupDrawScale=1.50000
		//ADS
		SightMoveSpeedFactor=0.500000
		//Function
		PlayerSpeedFactor=1.000000
		InventorySize=6
		MagAmmo=2
		WeaponModes(0)=(ModeName="Ammo: Shot",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Ammo: Slug",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(3)=(ModeName="Ammo: Dragon",Value=1.000000)
		WeaponModes(4)=(ModeName="Ammo: Explosive",Value=1.000000,bUnavailable=True)
		WeaponModes(5)=(ModeName="Ammo: FRAG-12",Value=1.000000)
		InitialWeaponMode=5
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams_SuperSlug'
		FireParams(2)=FireParams'ClassicPrimaryFireParams_Shock'
		FireParams(3)=FireParams'ClassicPrimaryFireParams_Flame'
		FireParams(4)=FireParams'ClassicPrimaryFireParams_Frag'
		FireParams(5)=FireParams'ClassicPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireSlugParams'
		AltFireParams(2)=FireParams'ClassicPrimaryFireParams_Shock'
		AltFireParams(3)=FireParams'ClassicPrimaryFireParams_Flame'
		AltFireParams(4)=FireParams'ClassicPrimaryFireParams_Frag'
		AltFireParams(5)=FireParams'ClassicPrimaryFireParams_Frag'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_SawnOff'
	Layouts(2)=WeaponParams'ClassicParams_Trench'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=Coach_Black
		Index=0
		CamoName="Blued"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Hunter
		Index=1
		CamoName="Hunter"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainHunter",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Veteran
		Index=2
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainVet",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Silver
		Index=3
		CamoName="Nickel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainChromeShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainGoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=Trench_Blue
		Index=5
		CamoName="Trench"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.TechWrench.TechWrenchShiny',Index=1,AIndex=0,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.TechWrench.ExplodoShell',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.TechWrench.ShockShell',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Shader'BWBP_SKC_Tex.TechWrench.WrenchShiny',Index=4,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BWBP_SKC_Tex.CYLO.ReflexShine',Index=5,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-SightShader',Index=6,AIndex=-1,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'Coach_Black'
	Camos(1)=WeaponCamo'Coach_Hunter'
	Camos(2)=WeaponCamo'Coach_Veteran'
	Camos(3)=WeaponCamo'Coach_Silver'
	Camos(4)=WeaponCamo'Coach_Gold'
	Camos(5)=WeaponCamo'Trench_Blue'
}