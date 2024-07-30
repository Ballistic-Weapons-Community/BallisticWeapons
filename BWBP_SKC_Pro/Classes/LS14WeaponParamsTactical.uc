class LS14WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Long Barrel - Single
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=25
        HeadMult=2.5
        LimbMult=0.75
		Heat=10
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=128.000000
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.150000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	//Long Barrel - Double
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryDoubleEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=50
        HeadMult=2.5
        LimbMult=0.75
		Heat=20
		DamageType=Class'BWBP_SKC_Pro.DTLS14Twin'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Twin'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Twin'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=512.000000
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireDouble',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryDoubleFireParams
		FireInterval=0.75
		FireEndAnim=	
		AmmoPerFire=2
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryDoubleEffectParams'
	End Object
	
	//Auto Barrel
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Auto
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=25
        HeadMult=2.5
        LimbMult=0.75
		Heat=10
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=128.000000
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS440.AQ-Fire',Volume=0.900000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Auto
		TargetState="GatlingLaser"
		FireInterval=0.200000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Auto'
	End Object
	
	//Gatling Barrel
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Gatling
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=15
        HeadMult=2.5
        LimbMult=0.75
		Heat=5
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=None)
		Inaccuracy=(X=256,Y=256)
		Recoil=25.000000
		Chaos=0.100000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Gatling
		TargetState="GatlingLaser"
		FireInterval=0.040000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Gatling'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=7500.000000
		AccelSpeed=60000.000000
		Damage=105
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		FlashScaleFactor=2.600000
		Recoil=512.000000
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.7500000
		AmmoPerFire=0
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=1,OutVal=0)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=1,OutVal=1)))
		XRandFactor=0.0
		YRandFactor=0.0
		ClimbTime=0.01
		DeclineDelay=0.18
		DeclineTime=1.000000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
		AimAdjustTime=0.700000
        ADSMultiplier=0.7
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.0
		ChaosDeclineDelay=0.5
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_Gatling
		ADSViewBindFactor=0
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.8
		AimSpread=(Min=512,Max=2560)
        ADSMultiplier=0.7
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Marksman"
		LayoutDescription="Scope, Rockets, Double Barrel"
		LayoutTags="heavy"
		Weight=30
		
		//ADS - fixed 3x - acog/carbine
		SightMoveSpeedFactor=0.35
		SightingTime=0.45
		ZoomType=ZT_Fixed
		MaxZoom=3
		SightPivot=(Pitch=600,Roll=-1024)
		
		//Visual
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=1f)
		WeaponBoneScales(1)=(BoneName="RDS",Slot=92,Scale=0f)
		WeaponBoneScales(2)=(BoneName="LongBarrel",Slot=93,Scale=1f)
		WeaponBoneScales(3)=(BoneName="ShortBarrel",Slot=94,Scale=0f)
		AllowedCamos(0)=0
		
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=20
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryDoubleFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Auto
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
		
		//ADS - fixed 3x - acog/carbine
		SightMoveSpeedFactor=0.35
		SightingTime=0.5
		ZoomType=ZT_Fixed
		MaxZoom=3
		SightOffset=(X=5.000000,Y=0.00000,Z=2.750000)
		
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=40 //
		PlayerSpeedFactor=0.95 //
		PlayerJumpFactor=0.95 //
		ReloadAnimRate=0.8 //
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Auto'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Gatling
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
		SightMoveSpeedFactor=0.45
		SightingTime=0.8
		
		//Stats
		InventorySize=6
		DisplaceDurationMult=1.4 //
		MagAmmo=200 //
		PlayerSpeedFactor=0.9 //
		PlayerJumpFactor=0.9 //
		ReloadAnimRate=0.8 //
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams_Gatling'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Gatling'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Auto'
    Layouts(2)=WeaponParams'TacticalParams_Gatling'
}