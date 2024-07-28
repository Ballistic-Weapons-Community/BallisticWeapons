class CoachWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE - 10ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=500.000000,Max=2700.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		TraceCount=13
		Damage=15.0
		//TraceCount=24
		//Damage=20
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-DoubleShot',Volume=1.200000)
		Recoil=2548.000000
		Chaos=-1.0
		Inaccuracy=(X=700,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		AimedFireAnim="Fire"
		FireInterval=0.150000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// PRIMARY FIRE - 10ga Super Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000)
		RangeAtten=0.350000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=115
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=3072.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=48,Y=48)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-DoubleShot',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireSlugParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimarySlugEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - 12ga Shot
    //=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_12Sawn
		TraceRange=(Min=500.000000,Max=2500.000000)
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		Damage=20
		HeadMult=2.15
		LimbMult=0.6
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=4096.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1500,Y=1000)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		FireAnimRate=0.75
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_12Sawn'
	End Object

	//=================================================================
    // PRIMARY FIRE - 12ga Slug
    //=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_12SawnSlug
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=3.000000
		Recoil=4096.000000
		Chaos=100.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=1024,Y=1024)
		HipSpreadFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_12SawnSlug
		FireInterval=0.300000
		MaxHoldTime=0.0
		FireAnimRate=0.75
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_12SawnSlug'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_HE
		TraceRange=(Min=2048.000000,Max=2560.000000)
		RangeAtten=0.250000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		Damage=12
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=1462.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_HE
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000		
        TargetState="ShotgunHE"
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_HE'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_Shock
		TraceRange=(Min=2500.000000,Max=4500.000000)
		RangeAtten=1.000000
		TraceCount=5
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		Damage=60
		DamageType=Class'DT_CoachGunElectro'
		DamageTypeArm=Class'DT_CoachGunElectro'
		DamageTypeHead=Class'DT_CoachGunElectro'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.electro_Shot',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		Recoil=462.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Shock
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
        TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_Shock'
	End Object

	//=================================================================
	// PRIMARY FIRE - Dragon
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams_Flame
		TraceRange=(Min=2500.000000,Max=2500.000000)
		RangeAtten=0.200000
		TraceCount=7
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlame'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=5
		DamageType=Class'BWBP_SKC_Pro.DT_CoachFire'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachFireHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachFire'
		MuzzleFlashClass=class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.fire_shot',Volume=1.500000,Radius=384.000000,Pitch=1.000000)
		Recoil=1462.000000
		Chaos=1.000000
		Inaccuracy=(X=400,Y=350)
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Flame
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
        TargetState="ShotgunIncendiary"
	FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams_Flame'
	End Object	
	
	//=================================================================
	// PRIMARY FIRE - FRAG-12
	//=================================================================	
	Begin Object Class=GrenadeEffectParams Name=RealisticPrimaryEffectParams_Frag
		ProjectileClass=Class'BWBP_SKC_Pro.CoachGunRocket'
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

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Frag
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
        TargetState="Projectile"
	FireEffectParams(0)=GrenadeEffectParams'RealisticPrimaryEffectParams_Frag'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//10
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=500.000000,Max=2700.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		TraceCount=13
		Damage=15.0
		//TraceCount=13
		//Damage=20
		HeadMult=2.15
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		PenetrateForce=10
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-SingleShot',Volume=1.200000)
		Recoil=1592.000000
		Chaos=-1.0
		Inaccuracy=(X=650,Y=650)
		HipSpreadFactor=1.000000
		BotRefireRate=0.100000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireInterval=0.150000
		AmmoPerFire=1
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//10slug
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondarySlugEffectParams
		TraceRange=(Min=6000.000000,Max=6500.000000) //Super Slug
		RangeAtten=0.350000
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=135
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        HeadMult=2.2f
        LimbMult=0.6f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=1792.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=24,Y=24)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-SingleShot',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireSlugParams
		FireInterval=0.300000
		AmmoPerFire=1
		MaxHoldTime=0.0
		FireAnim="Fire"
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondarySlugEffectParams'
	End Object
	
	//12
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_12Sawn
		TraceRange=(Min=500.000000,Max=2500.000000)
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		Damage=20
		HeadMult=2.15
		LimbMult=0.6
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=1000,Y=1000)
		HipSpreadFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.600000)	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		FireAnimRate=1.00
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_12Sawn'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.500000,OutVal=0.800000),(InVal=0.850000,OutVal=-0.500000),(InVal=1.000000,OutVal=-0.300000)))
		YawFactor=0.250000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=3762.000000
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
		AimSpread=(Min=16,Max=1400)
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

	Begin Object Class=AimParams Name=RealisticAimParams_Sawn
		AimSpread=(Min=16,Max=1024)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.900000
		ADSMultiplier=0.900000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
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
		SightingTime=0.23
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=6
		MagAmmo=2
		WeaponName="Super-10 10ga Coach Gun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireSlugParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireSlugParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_SawnOff
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
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.2
		//Function
		PlayerSpeedFactor=1.100000
		InventorySize=6
		MagAmmo=2
		WeaponName="Super-10 12ga Sawn Off"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams_Sawn'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_12Sawn'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_12SawnSlug'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_12Sawn'
		AltFireParams(1)=FireParams'RealisticPrimaryFireParams_12SawnSlug'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Trench
		//Layout core
		LayoutName="Trench Custom"
		LayoutTags="shield"
		Weight=10
		AllowedCamos(0)=5
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Trenchgun'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_Trenchgun'
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.25
		//Function
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Ammo: Shot",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Ammo: Slug",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(3)=(ModeName="Ammo: Dragon",Value=1.000000)
		WeaponModes(4)=(ModeName="Ammo: Explosive",Value=1.000000,bUnavailable=True)
		WeaponModes(5)=(ModeName="Ammo: FRAG-12",Value=1.000000)
		InitialWeaponMode=5
		WeaponName="BR-112 12g Customized Trenchgun"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireSlugParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams_Shock'
		FireParams(3)=FireParams'RealisticPrimaryFireParams_Flame'
		FireParams(4)=FireParams'RealisticPrimaryFireParams_Frag'
		FireParams(5)=FireParams'RealisticPrimaryFireParams_Frag'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireSlugParams'
		AltFireParams(2)=FireParams'RealisticPrimaryFireParams_Shock'
		AltFireParams(3)=FireParams'RealisticPrimaryFireParams_Flame'
		AltFireParams(4)=FireParams'RealisticPrimaryFireParams_Frag'
		AltFireParams(5)=FireParams'RealisticPrimaryFireParams_Frag'
    End Object 
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_SawnOff'
	Layouts(2)=WeaponParams'RealisticParams_Trench'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainHunter",Index=1,AIndex=1,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Veteran
		Index=2
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainVet",Index=1,AIndex=1,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Silver
		Index=3
		CamoName="Nickel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainChromeShine",Index=1,AIndex=1,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Coach_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CoachCamos.Coach-MainGoldShine",Index=1,AIndex=1,PIndex=0)
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