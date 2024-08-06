class CoachWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE - 10ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=2100)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=15 // inflict maximum of 150 damage to a single target, before modifiers
		Damage=17
        HeadMult=1.75
        LimbMult=0.85
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5
		Inaccuracy=(X=400,Y=300)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-DoubleShot',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams'
	End Object

	//=================================================================
	// PRIMARY FIRE - 10ga Super Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_Slug
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.25
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=60
        HeadMult=2.5
        LimbMult=0.75
		PushbackForce=250.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
		Inaccuracy=(X=192,Y=192)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Slug
		FireInterval=0.300000
		AmmoPerFire=1
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_Slug'
	End Object

	//=================================================================
	// PRIMARY FIRE - 12ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_12Sawn
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=1600) // 20-30m
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=15 // inflict maximum of 150 damage to a single target, before modifiers
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1580.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5
		Inaccuracy=(X=600,Y=450)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=0.75
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_12Sawn'
	End Object

	//=================================================================
	// PRIMARY FIRE - 12ga Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_12SawnSlug
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1050,Max=2100) // 20-40m
		RangeAtten=0.25
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		Damage=60
        HeadMult=2.5
        LimbMult=0.75
		PushbackForce=250.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSlug'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSlug'
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=1580.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
		Inaccuracy=(X=256,Y=256)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Fire',Volume=1.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_12SawnSlug
		FireInterval=0.300000
		AmmoPerFire=1
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=0.75
		FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_12SawnSlug'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_HE
		TraceRange=(Min=2048.000000,Max=2560.000000)
        DecayRange=(Min=1050,Max=2100)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		MaxHits=13 // inflict maximum of 156 damage to a single target
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachGunExplosive'
		PenetrateForce=0
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=1024.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_HE
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000
		TargetState="ShotgunHE"
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_HE'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=TacticalPrimaryEffectParams_Shock
		TraceRange=(Min=4096.000000,Max=5120.000000)
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		MaxHits=0
		Damage=5
        HeadMult=1
        LimbMult=1
		Inaccuracy=(X=150,Y=150)
		DamageType=Class'DT_CoachGunElectro'
		DamageTypeArm=Class'DT_CoachGunElectro'
		DamageTypeHead=Class'DT_CoachGunElectro'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.electro_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Shock
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
		TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'TacticalPrimaryEffectParams_Shock'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - FRAG
	//=================================================================	
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams_FRAG
		ProjectileClass=Class'BWBP_SKC_Pro.CoachGunRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2700.000000
		MaxSpeed=2700.000000
		Damage=75
        ImpactDamage=90
		PushbackForce=100.000000
		DamageRadius=512.000000
		MomentumTransfer=60000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Misc.GL-Fire',Volume=1.100000)
		Recoil=1462.000000
		Chaos=1.000000
		Inaccuracy=(X=20,Y=20)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.5
		WarnTargetPct=0.75	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_FRAG
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
		TargetState="Projectile"
	FireEffectParams(0)=GrenadeEffectParams'TacticalPrimaryEffectParams_FRAG'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//10ga
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=2100)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=15 // inflict maximum of 150 damage to a single target, before modifiers
		Damage=17
        HeadMult=1.75
        LimbMult=0.85
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5
		Inaccuracy=(X=300,Y=300)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Coach-SingleShot',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object	

	//12ga
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams_12Sawn
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1050,Max=1600) // 20-30m
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=15 // inflict maximum of 150 damage to a single target, before modifiers
		Damage=15
        HeadMult=1.75
        LimbMult=0.85
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1580.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5
		Inaccuracy=(X=600,Y=600)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.600000)	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.00
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams_12Sawn'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		ClimbTime=0.06
		DeclineDelay=0.400000
		DeclineTime=0.750000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
        ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-2048,Yaw=-1024)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Coach Gun"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.3
		//Function
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams_Slug'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalPrimaryFireParams_Slug'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_SawnOff
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
		PickupMesh=StaticMesh'BWBP_SKC_Static.SawnOff.SawnOff-High'
		PickupDrawScale=0.1
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.2
		//Function
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_12Sawn'
		FireParams(1)=FireParams'TacticalPrimaryFireParams_12SawnSlug'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_12Sawn'
		AltFireParams(1)=FireParams'TacticalPrimaryFireParams_12SawnSlug'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Trench
		//Layout core
		LayoutName="Trench Custom"
		Weight=10
		AllowedCamos(0)=5
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Trenchgun'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_Trenchgun'
		PickupMesh=StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupHi'
		PickupDrawScale=1.50000
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.30
		//Function
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Ammo: Shot",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Ammo: Slug",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(3)=(ModeName="Ammo: Dragon",Value=1.000000,bUnavailable=True)
		WeaponModes(4)=(ModeName="Ammo: Explosive",Value=1.000000,bUnavailable=True)
		WeaponModes(5)=(ModeName="Ammo: FRAG-12",Value=1.000000)
		InitialWeaponMode=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams_Slug'
		FireParams(2)=FireParams'TacticalPrimaryFireParams_Shock'
		FireParams(3)=FireParams'TacticalPrimaryFireParams_HE'
		FireParams(4)=FireParams'TacticalPrimaryFireParams_HE'
		FireParams(5)=FireParams'TacticalPrimaryFireParams_FRAG'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalPrimaryFireParams_Slug'
		AltFireParams(2)=FireParams'TacticalPrimaryFireParams_Shock'
		AltFireParams(3)=FireParams'TacticalPrimaryFireParams_HE'
		AltFireParams(4)=FireParams'TacticalPrimaryFireParams_HE'
		AltFireParams(5)=FireParams'TacticalPrimaryFireParams_FRAG'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_SawnOff'
    Layouts(2)=WeaponParams'TacticalParams_Trench'
	
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