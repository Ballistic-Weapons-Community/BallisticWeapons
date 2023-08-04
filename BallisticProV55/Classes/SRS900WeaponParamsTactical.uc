class SRS900WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=55 // 7.62 NATO
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
        PenetrationEnergy=48
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.5
		Recoil=600.000000
		Chaos=0.070000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.25000
		FireEndAnim=	
		AimedFireAnim="AimedFire"
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_600
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=65 //?
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
        PenetrationEnergy=48
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.5
		Recoil=600.000000
		Chaos=0.065000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_600
		FireInterval=0.25000
		FireEndAnim=
		FireAnimRate=0.85
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_600'
	End Object
		
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Relic
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=65 //?
        HeadMult=3
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
        PenetrationEnergy=48
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire3',Volume=1.500000,Pitch=0.900000,Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.5
		Recoil=550.000000
		Chaos=0.065000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Relic
		FireInterval=0.25000
		FireEndAnim=
		FireAnimRate=0.85
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Relic'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.250000,OutVal=-0.02000),(InVal=0.400000,OutVal=0.1000),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.120000,OutVal=0.11000),(InVal=0.300000,OutVal=0.330000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5.5
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_600
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.250000,OutVal=-0.020000),(InVal=0.400000,OutVal=0.1000),(InVal=0.800000,OutVal=-0.04000),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.120000,OutVal=0.11000),(InVal=0.300000,OutVal=0.330000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.1000
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=0.75
		CrouchMultiplier=1
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5.5
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=384,Max=1280)
		AimAdjustTime=0.8
        ADSMultiplier=0.7
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=TacticalAimParams_600
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=384,Max=1280)
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout core
		LayoutName="Adv Scope"
		LayoutTags="no_suppress"
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
		//Function
		SightOffset=(X=9.000000,Z=3.150000)
		MagAmmo=20
		SightingTime=0.50
		SightMoveSpeedFactor=0.35
        InventorySize=6
		// sniper 4-8x
        ZoomType=ZT_Logarithmic
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="Holosight"
		LayoutTags="no_suppress"
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
		//Function
		SightOffset=(X=2.000000,Z=2.03)
        SightingTime=0.40
		SightMoveSpeedFactor=0.45
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_600'
		AimParams(0)=AimParams'TacticalAimParams_600'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_600'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_IRONS
		//Layout core
		LayoutName="Suppressor"
		LayoutTags="irons, start_suppressed"
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
		//Function
		SightOffset=(X=3.000000,Z=1.30000)
		MagAmmo=20
        InventorySize=6
		SightingTime=0.40
		SightMoveSpeedFactor=0.45
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_600'
		AimParams(0)=AimParams'TacticalAimParams_600'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_600'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Relic
		//Layout core
		LayoutName="Relic"
		Weight=1
		AllowedCamos(0)=8
		AllowedCamos(1)=9
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SR18'
		AttachmentMesh=SkeletalMesh'BW_Core_WeaponAnim.SR18_TPm'
		SightOffset=(X=1.000000,Z=0.85000)
		//Function
		MagAmmo=20
        InventorySize=6
		SightingTime=0.40
		SightMoveSpeedFactor=0.45
		WeaponName="SR18 Battle Rifle"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_600'
		AimParams(0)=AimParams'TacticalAimParams_600'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Relic'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams_Scope'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
	Layouts(2)=WeaponParams'TacticalParams_IRONS'
	Layouts(3)=WeaponParams'TacticalParams_Relic'
	
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