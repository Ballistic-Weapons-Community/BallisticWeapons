class LS14WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Long Barrel - Single
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=25 //
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.10000 //
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//Long Barrel - Double
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryDoubleEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=50
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

	Begin Object Class=FireParams Name=ArenaPrimaryDoubleFireParams
		FireInterval=0.75
		FireEndAnim=	
		AmmoPerFire=2
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryDoubleEffectParams'
	End Object
	
	//Auto Barrel
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Auto
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=25 
		Heat=10 
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS440.AQ-Fire',Volume=0.900000)
		Recoil=128.000000 
		Chaos=0.000000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Auto
		TargetState="GatlingLaser"
		FireInterval=0.200000 
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Auto'
	End Object
	
	//Gatling Barrel
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Gatling
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=15 //
		Heat=5 //
		DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=None) //
		Inaccuracy=(X=256,Y=256) //
		Recoil=16.000000 //
		Chaos=0.300000
		BotRefireRate=0.99
		WarnTargetPct=0.30000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Gatling
		TargetState="GatlingLaser"
		FireInterval=0.040000 //
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Gatling'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LS14Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=750.000000
		MaxSpeed=9000.000000
		AccelSpeed=6750.000000
		Damage=80
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Rocket-Launch')
		FlashScaleFactor=2.600000
		Recoil=512.000000
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		PreFireAnim="GrenadePrepFire"
		FireAnim="RLFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.0
		ChaosDeclineDelay=0.5
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams_Gatling
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpOffSet=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.5
		AimSpread=(Min=256,Max=1536)
        ADSMultiplier=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Marksman"
		LayoutDescription="Scope, Rockets, Double Barrel"
		Weight=30
		
		//ADS - fixed 3x - acog/carbine
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000		
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
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=20
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimaryDoubleFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Auto
		//Layout core
		LayoutName="Automatic"
		LayoutDescription="Automatic Barrel, Big Battery"
		LayoutTags="gatling,heavy"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.LS440_FPm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.LS440_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.LS440.LS440PickupLo'
		PickupDrawScale=0.1
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.LS440.LS440-Blue',Index=1,AIndex=-1,PIndex=-1)
		ViewOffset=(X=5.000000,Y=10.000000,Z=-3.000000)
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		
		//ADS - fixed 3x - acog/carbine
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000		
		ZoomType=ZT_Fixed
		MaxZoom=3
		SightOffset=(X=5.000000,Y=0.00000,Z=2.750000)
	
		//Stats
		ReloadAnimRate=0.8 //
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=40 //
		WeaponModes(0)=(ModeName="Rotary Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Auto'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Gatling
		//Layout core
		LayoutName="Laser Gatling"
		LayoutDescription="Gatling Barrel, Backpack Battery"
		LayoutTags="gatling,rapid,backpack"
		Weight=10
		
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.LS440_FPm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.LS440_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.LS440.LS440PickupLo'
		PickupDrawScale=0.1
		WeaponBoneScales(0)=(BoneName="Scope",Slot=91,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.LS440.LS440-Blue',Index=1,AIndex=-1,PIndex=-1)
		AllowedCamos(0)=1
		AllowedCamos(1)=2
		
		//ADS
		SightOffset=(X=11.000000,Y=-0.00000,Z=4.700000)
		ZoomType=ZT_Irons
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000	
		MaxZoom=3
		
		//Stats
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=6
		DisplaceDurationMult=1.5
		MagAmmo=200
		WeaponModes(0)=(ModeName="Gatling Barrel",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Double Barrel",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Automatic",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams_Gatling'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Gatling'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Auto'
    Layouts(2)=WeaponParams'ArenaParams_Gatling'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=LS14_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=LS440_Black
		Index=1
		CamoName="Black"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LS440_Green
		Index=2
		CamoName="OD Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LS440Camos.LS440-Green",Index=1,AIndex=1,PIndex=-1)
		Weight=5
	End Object
	
	Camos(0)=WeaponCamo'LS14_Black'
	Camos(1)=WeaponCamo'LS440_Black'
	Camos(2)=WeaponCamo'LS440_Green'
}