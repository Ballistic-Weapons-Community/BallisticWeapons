class CYLOWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//UAW
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=35
		DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1
		Recoil=300.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.120000
		PreFireAnim=
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//Firestorm
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_FS
		TraceRange=(Min=10000.000000,Max=12000.000000)
        DecayRange=(Min=2300,Max=6000)
		RangeAtten=0.5
		Damage=38
		DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		PenetrateForce=180
		MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
		Recoil=320.000000
		Chaos=0.065000
		Heat=0.1
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_FS
		FireInterval=0.125000
		PreFireAnim=
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_FS'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.25
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=12
		PushbackForce=150.000000
		DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Dragon's Breath
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams_Flame
		TraceRange=(Min=1572.000000,Max=1572.000000)
		RangeAtten=0.2
		TraceCount=4
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=19
		DamageType=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=1024.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=1250,Y=1250)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Flame
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="FireShot"
	FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams_Flame'
	End Object
	
	//HE Slug
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Slug
		ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
		SpawnOffset=(Y=20.000000,Z=-20.000000)
		Speed=8000.000000
		MaxSpeed=15000.000000
		AccelSpeed=3000.000000
		Damage=75
		DamageRadius=256.000000
		MomentumTransfer=50000.000000
		PushbackForce=200.000000
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000,Radius=256.000000)
		Recoil=512.000000
		Chaos=0.500000
		SplashDamage=True
		BotRefireRate=0.7
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Slug
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="HESlug"
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Slug'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	//UAW
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.1,OutVal=0.01),(InVal=0.2,OutVal=0.07),(InVal=0.25,OutVal=0.06),(InVal=0.3,OutVal=0.03),(InVal=0.35,OutVal=0.00),(InVal=0.40000,OutVal=-0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.160000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object
	
	//Firestorm
	Begin Object Class=RecoilParams Name=ArenaRecoilParams_FS
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.1,OutVal=0.01),(InVal=0.2,OutVal=0.07),(InVal=0.25,OutVal=0.06),(InVal=0.3,OutVal=0.03),(InVal=0.35,OutVal=0.00),(InVal=0.40000,OutVal=-0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.165000
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.35
		AimSpread=(Min=64,Max=768)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="UAW"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		//Attachments
		WeaponBoneScales(0)=(BoneName="ElecSight",Slot=54,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.35
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=22
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_FS
		//Layout core
		LayoutName="Firestorm"
		LayoutTags="exp,heat,slug"
		Weight=20
		AllowedCamos(0)=7
		AllowedCamos(1)=8
		AllowedCamos(2)=9
		AllowedCamos(3)=10
		AllowedCamos(4)=11
		AllowedCamos(5)=12
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.CYLOFirestorm_FPm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.CYLOFirestorm_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStormPickupHi'
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000	
		SightPivot=(Pitch=256)
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=26
        RecoilParams(0)=RecoilParams'ArenaRecoilParams_FS'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_FS'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Slug'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Cheap
		//Layout core
		LayoutName="Budget"
		LayoutTags="cheap"
		Weight=5
		AllowedCamos(0)=13
		AllowedCamos(1)=14
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.CYLOIV_FPm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.CYLOIV_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOPickupHi'
		PickupDrawScale=1.75
		//ADS
		SightOffset=(X=-4.250000,Y=0.000000,Z=0.000000)
		SightPivot=(Pitch=325)
		SightMoveSpeedFactor=0.8
		SightingTime=0.35
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		InventorySize=5
		DisplaceDurationMult=1
		MagAmmo=22
		ViewOffset=(X=4.000000,Y=3.500000,Z=-2.500000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_FS'
    Layouts(2)=WeaponParams'ArenaParams_Cheap'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=CYLO_Standard
		Index=0
		CamoName="Best Value"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_CYLO
		Index=1
		CamoName="CYLO"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainRust",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_Ork
		Index=2
		CamoName="Most Dakka"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainBlast",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_RealFakeWood
		Index=3
		CamoName="Real Fake Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainNewWood",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_NewRed
		Index=4
		CamoName="Ultracool"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainNewRed",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_NewPink
		Index=5
		CamoName="Girlpower"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainNewPink",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLO_Brass
		Index=6
		CamoName="Gold?"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOUAWCamos.CYLO-MainNewBrass",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Orange
		Index=7
		CamoName="Orange"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Red
		Index=8
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainRed",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Blue
		Index=9
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainBlue",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Yellow
		Index=10
		CamoName="Yellow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainYellow",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_OrangeFancy
		Index=11
		CamoName="Limited"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainStripes",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Gold
		Index=12
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainGold",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOld_Tan
		Index=13
		CamoName="Real Brown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-MainShineMk1',Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOld_Black
		Index=14
		CamoName="Black (TM)"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-MainShineMk2',Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'CYLO_Standard'
	Camos(1)=WeaponCamo'CYLO_CYLO'
	Camos(2)=WeaponCamo'CYLO_Ork'
	Camos(3)=WeaponCamo'CYLO_RealFakeWood'
	Camos(4)=WeaponCamo'CYLO_NewRed'
	Camos(5)=WeaponCamo'CYLO_NewPink'
	Camos(6)=WeaponCamo'CYLO_Brass'
	Camos(7)=WeaponCamo'CYLOFS_Orange' //Firestorm
	Camos(8)=WeaponCamo'CYLOFS_Red'
	Camos(9)=WeaponCamo'CYLOFS_Blue'
	Camos(10)=WeaponCamo'CYLOFS_Yellow'
	Camos(11)=WeaponCamo'CYLOFS_OrangeFancy'
	Camos(12)=WeaponCamo'CYLOFS_Gold'
	Camos(13)=WeaponCamo'CYLOld_Tan'
	Camos(14)=WeaponCamo'CYLOld_Black'
}