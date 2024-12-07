class SRS900WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=10000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=1800.0,Max=9000.0)
		RangeAtten=0.1
		Damage=60.0
		HeadMult=2.2
		LimbMult=0.66
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=850.000000
		Chaos=0.100000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.09500 //700RPM
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="AimedFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Relic
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Relic
		TraceRange=(Min=10000.000000,Max=10000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=1800.0,Max=9000.0)
		RangeAtten=0.1
		Damage=55.0
		HeadMult=2.2
		LimbMult=0.66
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire3',Pitch=0.900000,Volume=1.500000)
		Recoil=750.000000 //
		Chaos=0.100000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Relic
		FireInterval=0.155000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="AimedFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Relic'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
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
		DeclineDelay=0.180000
		ViewBindFactor=0.500000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Iron
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.185000
		YRandFactor=0.185000
		MaxRecoil=4000
		DeclineTime=0.900000
		DeclineDelay=0.180000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-2560,Yaw=-4096)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=550.000000
		ChaosTurnThreshold=170000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Scoped"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		AllowedCamos(7)=7
		//Attachments
		SightOffset=(X=9.000000,Z=3.150000)
        ZoomType=ZT_Logarithmic
		//Function
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		InventorySize=7
		MagAmmo=20
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=1f)
		InitialWeaponMode=0
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName="Holosight"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		AllowedCamos(7)=7
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=0f)
		SightOffset=(X=6.000000,Z=2.03)
        ZoomType=ZT_Irons
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		MagAmmo=20
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Iron'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		AllowedCamos(5)=5
		AllowedCamos(6)=6
		AllowedCamos(7)=7
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=0f)
		SightOffset=(X=1.000000,Z=1.30000)
        ZoomType=ZT_Irons
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.22
		MagAmmo=20
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Iron'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Relic
		//Layout core
		LayoutName="Relic"
		Weight=1
		AllowedCamos(0)=8
		AllowedCamos(1)=9
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.SR18_FPm'
		AttachmentMesh=SkeletalMesh'BW_Core_WeaponAnim.SR18_TPm'
		SightOffset=(X=1.000000,Z=0.85000)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.2
		MagAmmo=20
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SR18 7.62mm Battle Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Iron'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Relic'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	Layouts(2)=WeaponParams'RealisticParams_Irons'
	Layouts(3)=WeaponParams'RealisticParams_Relic'
	
	//Camos ===================================
	Begin Object Class=WeaponCamo Name=SRS_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Desert
		Index=1
		CamoName="Desert"
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KMain",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KScopeShine",Index=2,AIndex=1,PIndex=1))
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KAmmo",Index=3,AIndex=2,PIndex=2))
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-FB",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-S",Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_DesertTac
		Index=2
		CamoName="Desert Tac"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KScopeShine",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KAmmo",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-FB",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-S",Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Black
		Index=3
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSGrey",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Flecktarn
		Index=4
		CamoName="Flecktarn"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSM2German",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Blue
		Index=5
		CamoName="Blue"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSJungle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-BSight-FB",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-BSight-S",Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Red
		Index=6
		CamoName="Red"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-FB",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-S",Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_RedTiger
		Index=7
		CamoName="Red Tiger"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSFlame",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-FB",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS-HSight-S",Index=5,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_RelicWood
		Index=8
		CamoName="Wood"
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.SRS900.SR18-Main',Index=1,AIndex=0,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.SRS900.SR18-Misc',Index=2,AIndex=1,PIndex=-1))
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo',Index=3,AIndex=-1,PIndex=2))
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.SRS900.SRS900Main',Index=4,AIndex=2,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_RelicBlack
		Index=9
		CamoName="Black"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SR18-MainBlack",Index=1,AIndex=0,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SR18-MiscBlack",Index=2,AIndex=1,PIndex=-1))
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo',Index=3,AIndex=-1,PIndex=2))
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.SRS900.SRS900Main',Index=4,AIndex=2,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'SRS_Gray'
    Camos(1)=WeaponCamo'SRS_Desert'
    Camos(2)=WeaponCamo'SRS_DesertTac'
    Camos(3)=WeaponCamo'SRS_Black'
    Camos(4)=WeaponCamo'SRS_Flecktarn'
    Camos(5)=WeaponCamo'SRS_Blue'
    Camos(6)=WeaponCamo'SRS_Red'
    Camos(7)=WeaponCamo'SRS_RedTiger'
    Camos(8)=WeaponCamo'SRS_RelicWood'
    Camos(9)=WeaponCamo'SRS_RelicBlack'
}