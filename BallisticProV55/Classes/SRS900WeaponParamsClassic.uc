class SRS900WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=48.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=180.000000
		Chaos=0.015000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Relic
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Relic
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=3.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=48.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire3',Pitch=0.900000,Volume=1.500000)
		Recoil=130.000000 //
		Chaos=0.015000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Relic
		FireInterval=0.155000
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_Relic'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.400000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=3072)
		AimAdjustTime=0.650000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
		ChaosTurnThreshold=170000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout core
		LayoutName="Adv Scope"
		Weight=30
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
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=1f)
		SightOffset=(X=9.000000,Z=3.150000)
		//Function
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.450000
		bNeedCock=True
		MagAmmo=20
		//SightOffset=(X=20.000000,Z=11.750000)
        ZoomType=ZT_Logarithmic
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RDS
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
		SightOffset=(X=5.000000,Z=2.03)
		//Function
		ZoomType=ZT_Irons
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		//SightOffset=(X=11.000000,Z=9.88000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=5
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
		//Function
		ZoomType=ZT_Irons
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		//SightOffset=(X=11.000000,Z=9.88000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Relic
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
		ZoomType=ZT_Irons
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SR18 Battle Rifle"
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Relic'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams_Scope'
	Layouts(1)=WeaponParams'ClassicParams_RDS'
	Layouts(2)=WeaponParams'ClassicParams_Irons'
	Layouts(3)=WeaponParams'ClassicParams_Relic'
		
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRSNSFlame",Index=1,AIndex=0,PIndex=0)
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