class CYLOWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//UAW - 7.62mm Short
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1400.000000,Max=7000.000000) //7.62mm short
		WaterTraceRange=4000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=50
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
		PenetrationEnergy=22.000000
		PenetrateForce=70
		bPenetrate=True
		PDamageFactor=0.600000
		WallPDamageFactor=0.600000
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.1
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//Firestorm - 5.56mm Inc
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_FS
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=4800.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.050000
		Damage=43.0
		HeadMult=2.139534
		LimbMult=0.651162
		DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
		FlashScaleFactor=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
		Recoil=350.000000
		Chaos=0.020000
		Heat=0.1
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_FS
		FireInterval=0.085500
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_FS'
	End Object
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//16 gauge shotgun
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		PenetrationEnergy=4.000000
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		Inaccuracy=(X=1400,Y=1100)
		HipSpreadFactor=1.000000
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Dragon's Breath
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_Flame
		TraceRange=(Min=3072.000000,Max=3072.000000)
		RangeAtten=0.15000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.000000
		Recoil=768.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=200,Y=200)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Flame
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="FireShot"
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_Flame'
	End Object
	
	//BOOM
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Slug
		ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
		SpawnOffset=(Y=20.000000,Z=-20.000000)
        Speed=10000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=80
        DamageRadius=256.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000,Radius=256.000000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
        BotRefireRate=0.6
        WarnTargetPct=0.4	
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Slug
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="HESlug"
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Slug'
    End Object
				
	//=================================================================
	// RECOIL
	//=================================================================
	
	//UAW
	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.400000
		XRandFactor=0.300000
		YRandFactor=0.200000
		MinRandFactor=0.300000
		MaxRecoil=2800.000000
		DeclineTime=1.500000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//Firestorm
	Begin Object Class=RecoilParams Name=RealisticRecoilParams_FS
		//XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.500000),(InVal=0.600000,OutVal=0.300000)))
		//YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.200000,OutVal=0.080000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.300000
		MaxRecoil=3840.000000
		DeclineDelay=0.000000
		DeclineTime=1.200000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.500000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	//UAW
	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-8000)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
	End Object
	
	//Firestorm
	Begin Object Class=AimParams Name=RealisticAimParams_FS
		AimSpread=(Min=32,Max=2560)
		AimAdjustTime=0.400000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-8000)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object
	//=================================================================
	// BASIC PARAMS
	//=================================================================		
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="UAW"
		LayoutTags="cheap"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.230000
		SightPivot=(Pitch=450)
		//Function
		InventorySize=5
		WeaponPrice=800
		MagAmmo=37
		//SightOffset=(X=-3.000000,Y=13.575000,Z=22.1000)
		//ViewOffset=(X=4.000000,Y=-4,Z=-14.000000)
		WeaponName="CYLO-III 7.62mm Assault Weapon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_FS
		//Layout core
		LayoutName="Firestorm"
		LayoutTags="inc,heat"
		Weight=20
		AllowedCamos(0)=7
		AllowedCamos(1)=8
		AllowedCamos(2)=9
		AllowedCamos(3)=10
		AllowedCamos(4)=11
		AllowedCamos(5)=12
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_CYLOFirestorm'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.TPm_CYLOFirestorm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStormPickupHi'
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23
		SightPivot=(Pitch=256)
		//Function
		InventorySize=5
		MagAmmo=50
		//ViewOffset=(X=0,Y=-5,Z=-14)
		//SightOffset=(X=-3.000000,Y=13.565000,Z=24.785000)
		WeaponName="CYLO-V 5.56mm Incendiary Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_FS'
		AimParams(0)=AimParams'RealisticAimParams_FS'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_FS'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Flame'
	End Object
	
    Layouts(0)=WeaponParams'RealisticParams'
    Layouts(1)=WeaponParams'RealisticParams_FS'
	
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
}