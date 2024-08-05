class CoachWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE - 10ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryShotEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1000,Max=3000)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		HeadMult=1.50f 
		LimbMult=0.85f
		MaxHits=13 // inflict maximum of 156 damage to a single target
		Damage=12
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=400,Y=300)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-FireDouble',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireShotParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryShotEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - 10ga Super Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1536,Max=4096)
		RangeAtten=0.25
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		HeadMult=1.50f
		LimbMult=0.85f
		Damage=60
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
		WarnTargetPct=0.500000	
		Inaccuracy=(X=16,Y=0)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireSlugParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimarySlugEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - 12ga Shot
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams_12Sawn
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1000,Max=2000)
		RangeAtten=0.200000
		TraceCount=18
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=14
		Damage=6
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1152.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=550,Y=550)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.900000)	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		FireAnimRate=0.8
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams_12Sawn'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - 12ga Slug
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams_12SawnSlug
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.150000
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		MaxHits=14 
		Damage=80
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
        HeadMult=1.5f
        LimbMult=0.8f
        PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.000000
		Recoil=1152.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=32,Y=16)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-DFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_12SawnSlug
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=0.8
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimarySlugEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams_HE
		TraceRange=(Min=2048.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.250000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		MaxHits=14 // inflict maximum of 156 damage to a single target
		Damage=15
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'DT_CoachGunExplosive'
		DamageTypeHead=Class'DT_CoachGunExplosive'
		DamageTypeArm=Class'DT_CoachGunExplosive'
		PenetrateForce=0
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=1024.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_HE
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000
		TargetState="ShotgunHE"
	FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams_HE'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams_Shock
		TraceRange=(Min=4096.000000,Max=5120.000000)
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		MaxHits=0
		Damage=9
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
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Shock
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnimRate=0.800000	
		TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams_Shock'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Shot single
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryShotEffectParams
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1000,Max=3000)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		HeadMult=1.50f 
		LimbMult=0.85f
		MaxHits=13 // inflict maximum of 156 damage to a single target
		Damage=12
		PushbackForce=100.000000
		DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1280.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=300,Y=300)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireShotParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryShotEffectParams'
	End Object

	//Slug single
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondarySlugEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1536,Max=4096)
		RangeAtten=0.25
		TraceCount=1
	    TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_X83AM'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
		HeadMult=1.50f
		LimbMult=0.85f
		Damage=60
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
		WarnTargetPct=0.500000	
		Inaccuracy=(X=16,Y=0)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.SuperMagnum-Fire',Volume=7.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireSlugParams
		FireInterval=0.300000
		MaxHoldTime=0.0
		AimedFireAnim="Fire"
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondarySlugEffectParams'
	End Object
	
	//shot single 12
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondarEffectParams_12Sawn
		TraceRange=(Min=2560.000000,Max=3072.000000)
        DecayRange=(Min=1000,Max=2000)
		RangeAtten=0.200000
		TraceCount=18
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		MaxHits=14
		Damage=6
		DamageType=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachSawnOff'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=1152.000000
		Chaos=1.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000
		Inaccuracy=(X=350,Y=350)
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SawnOff.SawnOff-SFire',Volume=1.600000)	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondarFireParams_12Sawn
		FireInterval=0.300000
		MaxHoldTime=0.0
		FireAnimRate=1.35	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondarEffectParams_12Sawn'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		ClimbTime=0.06
		DeclineDelay=0.400000
		DeclineTime=0.750000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	Begin Object Class=RecoilParams Name=ArenaRecoilParams_Sawn
		ViewBindFactor=0.350000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.300000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		DeclineTime=0.900000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Coach Gun"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		//Function
		CockAnimRate=0.700000
		ReloadAnimRate=1.500000
		PlayerJumpFactor=1.000000
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireShotParams'
		FireParams(1)=FireParams'ArenaPrimaryFireSlugParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireShotParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireSlugParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_SawnOff
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
		PickupDrawScale=0.5
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		//Function
		CockAnimRate=0.700000
		ReloadAnimRate=1.500000
		PlayerJumpFactor=1.000000
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_Sawn'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_12Sawn'
		FireParams(1)=FireParams'ArenaPrimaryFireParams_12SawnSlug'
		AltFireParams(0)=FireParams'ArenaSecondarFireParams_12Sawn'
		AltFireParams(1)=FireParams'ArenaPrimaryFireParams_12SawnSlug'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Trench
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
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		//Function
		CockAnimRate=0.700000
		ReloadAnimRate=1.500000
		PlayerJumpFactor=1.000000
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Ammo: Shot",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Ammo: Slug",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Ammo: Electro",Value=1.000000)
		WeaponModes(3)=(ModeName="Ammo: Dragon",Value=1.000000,bUnavailable=True)
		WeaponModes(4)=(ModeName="Ammo: Explosive",Value=1.000000)
		WeaponModes(5)=(ModeName="Ammo: FRAG-12",Value=1.000000,bUnavailable=True)
		InitialWeaponMode=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireShotParams'
		FireParams(1)=FireParams'ArenaPrimaryFireSlugParams'
		FireParams(2)=FireParams'ArenaPrimaryFireParams_Shock'
		FireParams(3)=FireParams'ArenaPrimaryFireParams_HE'
		FireParams(4)=FireParams'ArenaPrimaryFireParams_HE'
		FireParams(5)=FireParams'ArenaPrimaryFireParams_HE'
		AltFireParams(0)=FireParams'ArenaSecondaryFireShotParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireSlugParams'
		AltFireParams(2)=FireParams'ArenaPrimaryFireParams_Shock'
		AltFireParams(3)=FireParams'ArenaPrimaryFireParams_HE'
		AltFireParams(4)=FireParams'ArenaPrimaryFireParams_HE'
		AltFireParams(5)=FireParams'ArenaPrimaryFireParams_HE'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_SawnOff'
	Layouts(2)=WeaponParams'ArenaParams_Trench'
	
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