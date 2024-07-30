class LS14WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Long Barrel
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=40
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=1.000000)
		Recoil=25.000000
		Chaos=-1.00
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Long Barrel - Dbl
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Dbl
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=80
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireDouble',Volume=0.900000)
		Recoil=50.000000
		Chaos=-1.00
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Dbl
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AmmoPerFire=2
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Dbl'
	End Object

	//Carbine
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Carbine
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
		Recoil=75.000000
		Chaos=0.1
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Carbine
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Carbine'
	End Object
	
	//Auto Barrel
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Auto
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35 //
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS440.AQ-Fire',Volume=0.900000)
		Recoil=25.000000
		Chaos=-1.00
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Auto
		TargetState="GatlingLaser"
		FireInterval=0.200000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Auto'
	End Object
	
	//Gatling Barrel
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Gatling
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30 //
		HeadMult=2.75
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrationEnergy=64.000000
		PenetrateForce=400
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=None) //
		Inaccuracy=(X=256,Y=256) //
		Recoil=16.000000 //
		Chaos=-1.00
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Gatling
		TargetState="GatlingLaser"
		FireInterval=0.04
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Gatling'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
		
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7500.000000
		MaxSpeed=10000.000000
		AccelSpeed=2000.000000
		Damage=100.000000
		DamageRadius=350.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=2.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		Recoil=256.000000
		Chaos=5.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.020000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.185000
		YRandFactor=0.185000
		MaxRecoil=4000
		DeclineTime=0.900000
		DeclineDelay=0.180000;
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=1936)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.350000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.700000
		ChaosSpeedThreshold=550.000000
	End Object
	
	Begin Object Class=AimParams Name=RealisticCarbineAimParams
		AimSpread=(Min=10,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.800000
		ViewBindFactor=0.250000
		SprintChaos=1.000000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.350000
		ChaosDeclineTime=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Marksman"
		LayoutDescription="Scope, Rockets, Double Barrel"
		LayoutTags="heavy"
		Weight=30
		
		//Visual
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=0f)
		AllowedCamos(0)=0
		
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Logarithmic
		
		//Stats
		InventorySize=7
		MagAmmo=20
		WeaponName="LS14 Directed Energy Weapon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams_Dbl'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Carbine
		//Layout core
		LayoutName="Carbine"
		LayoutDescription="Reflex Sight, Rockets, Double Barrel, Light"
		Weight=10
		
		//Visual
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=1f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=0f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=1f)
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		ZoomType=ZT_Fixed
		SightPivot=(Pitch=600,Roll=-1024)
		
		//Stats
		PlayerSpeedFactor=1.100000
		PlayerJumpFactor=1.100000
		InventorySize=7
		MagAmmo=20
		WeaponName="LS14K Directed Energy Weapon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticCarbineAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Carbine'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Auto
		//Layout core
		LayoutName="Laser Repeater"
		LayoutDescription="Automatic Barrel, Big Battery"
		LayoutTags="heavy,gatling"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LS440'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_LS440'
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.LS440.LS440-Blue',Index=1,AIndex=-1,PIndex=-1)
		ViewOffset=(X=5.000000,Y=10.000000,Z=-3.000000)
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.35
		ZoomType=ZT_Fixed
		SightOffset=(X=5.000000,Y=0.00000,Z=2.750000)
		
		//Stats
		InventorySize=7
		MagAmmo=40 //
		PlayerSpeedFactor=0.900000 //
		PlayerJumpFactor=0.900000 //
		ReloadAnimRate=0.8 //
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="LS10 Auto Directed Energy Weapon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Auto'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Gatling
		//Layout core
		LayoutName="Laser Gatling"
		LayoutDescription="Gatling Barrel, Backpack Battery"
		LayoutTags="gatling,rapid,backpack"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_LS440'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_LS440'
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.LS440.LS440-Blue',Index=1,AIndex=-1,PIndex=-1)
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		
		//ADS
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.500000
		SightingTime=0.45
		
		//Stats
		InventorySize=7
		MagAmmo=200
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		WeaponModes(0)=(ModeName="Gatling Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		WeaponName="LS440 Suppressive DEW"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Gatling'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Auto'
	Layouts(2)=WeaponParams'RealisticParams_Gatling'
	//Layouts(1)=WeaponParams'RealisticParams_Carbine'


}