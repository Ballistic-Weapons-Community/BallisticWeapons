class SRS900WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Scope
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=6000)
		PenetrationEnergy=48
		RangeAtten=0.75
		Damage=60
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.500000
		Recoil=600.000000
		Chaos=0.070000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.25000
		BurstFireRateFactor=0.55
		FireEndAnim=	
		AimedFireAnim="AimedFire"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Optic
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_600
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=6000)
		PenetrationEnergy=48
		RangeAtten=0.75
		Damage=60
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=600.000000
		Chaos=0.065000 //
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_600
		FireInterval=0.25000
		FireAnimRate=0.85
		BurstFireRateFactor=0.55
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_600'
	End Object
		
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Relic
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=6000)
		PenetrationEnergy=48
		RangeAtten=0.75
		Damage=60
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=550.000000 //-50
		Chaos=0.075000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire3',Pitch=0.900000,Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Relic
		FireInterval=0.25000
		FireAnimRate=0.85
		BurstFireRateFactor=0.55
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Relic'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.250000,OutVal=-0.020000),(InVal=0.400000,OutVal=0.1000),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.120000,OutVal=0.11000),(InVal=0.300000,OutVal=0.330000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.5
	End Object
	 
	Begin Object Class=RecoilParams Name=ArenaRecoilParams_600
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.250000,OutVal=-0.020000),(InVal=0.400000,OutVal=0.1000),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.120000,OutVal=0.11000),(InVal=0.300000,OutVal=0.330000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.1000
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.5
	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=64,Max=768)
        ADSMultiplier=0.35
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams_600
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=64,Max=768)
        ADSMultiplier=0.35
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams_Scope
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
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		MagAmmo=20
		SightingTime=0.50000
		SightMoveSpeedFactor=0.6
        InventorySize=6
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_RDS
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
		//Function
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		MagAmmo=20
        InventorySize=6
		SightMoveSpeedFactor=0.8
		RecoilParams(0)=RecoilParams'ArenaRecoilParams_600'
		AimParams(0)=AimParams'ArenaAimParams_600'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_600'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_IRONS
		//Layout core
		LayoutName="Irons"
		LayoutTags="irons"
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
		SightOffset=(X=3.000000,Z=1.30000)
		//Function
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		MagAmmo=20
        InventorySize=6
		SightMoveSpeedFactor=0.9
		RecoilParams(0)=RecoilParams'ArenaRecoilParams_600'
		AimParams(0)=AimParams'ArenaAimParams_600'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_600'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Relic
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
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		MagAmmo=20
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
        InventorySize=6
		SightMoveSpeedFactor=0.9
		WeaponName="SR18 Battle Rifle"
		RecoilParams(0)=RecoilParams'ArenaRecoilParams_600'
		AimParams(0)=AimParams'ArenaAimParams_600'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Relic'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams_Scope'
    Layouts(1)=WeaponParams'ArenaParams_RDS'
	Layouts(2)=WeaponParams'ArenaParams_Irons'
	Layouts(3)=WeaponParams'ArenaParams_Relic'
	
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