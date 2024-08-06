class CYLOWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//7.62mm
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.650000
		Damage=35
		HeadMult=2.5
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
		PenetrationEnergy=32.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=130.000000
		Chaos=0.010000
		Inaccuracy=(X=96,Y=96)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.085500 //+ .15xrand offline, x2 online
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//5.56mm inc
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_FS
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=2400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.550000
		Damage=22
		HeadMult=2.0
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		PenetrationEnergy=20.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
		Recoil=110.000000
		Chaos=0.020000
		Heat=0.75
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_FS
		FireInterval=0.085500
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_FS'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Shot
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1250.000000,Max=1700.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=9
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=15
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		//FireSpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000)
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=1400,Y=1100)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.400000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="FireSG"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//Flame
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams_Flame
		TraceRange=(Min=1572.000000,Max=1572.000000)
		RangeAtten=0.200000
		TraceCount=4
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=15
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
		Inaccuracy=(X=1250,Y=1250)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Flame
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="FireShot"
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams_Flame'
	End Object
	
	//BOOM
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Slug
		ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
		SpawnOffset=(Y=20.000000,Z=-20.000000)
        Speed=6300.000000
        MaxSpeed=6300.000000
        AccelSpeed=3000.000000
        Damage=65
        DamageRadius=200.000000
        MomentumTransfer=10000.000000
		RadiusFallOffType=RFO_Linear
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000,Radius=256.000000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
        BotRefireRate=0.6
        WarnTargetPct=0.4	
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Slug
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="HESlug"
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Slug'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	//7.62
	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=1024.000000
		DeclineTime=0.800000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object
	
	//5.56
	Begin Object Class=RecoilParams Name=ClassicRecoilParams_FS
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3840.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	//7.62
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1600)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.900000
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

	//5.56	
	Begin Object Class=AimParams Name=ClassicAimParams_FS
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
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="UAW IV"
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
		SightingTime=0.30000
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=28
		ViewOffset=(X=9,Y=7.00,Z=-4)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Cheap
		//Layout core
		LayoutName="UAW II"
		LayoutTags="cheap"
		Weight=5
		AllowedCamos(0)=13
		AllowedCamos(1)=14
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_CYLOIV'
		AttachmentMesh=SkeletalMesh'BWBP_SKC_Anim.CYLOIV_TPm'
		PickupMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOPickupHi'
		PickupDrawScale=1.75
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25000
		//Function
		InventorySize=6 //Make this 5 later
		bNeedCock=True
		MagAmmo=28
		ViewOffset=(X=9,Y=7.00,Z=-4)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_FS
		//Layout core
		LayoutName="Firestorm V"
		LayoutTags="inc,heat,charge"
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
		PickupMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOFireStorm'
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		SightPivot=(Pitch=256)
		//Function
		InventorySize=6
		bNeedCock=True
		MagAmmo=35
		ViewOffset=(X=9,Y=7.00,Z=-4)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams_FS'
		AimParams(0)=AimParams'ClassicAimParams_FS'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_FS'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Flame'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Cheap'
	Layouts(2)=WeaponParams'ClassicParams_FS'
	
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
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-MainShineMk1',Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOld_Black
		Index=14
		CamoName="Black (TM)"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-MainShineMk2',Index=1,AIndex=0,PIndex=0)
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