class M353WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 1;
	BWA.ModeInfos[0].TracerMix = 4;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34  // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTM353MG'
		DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
		DamageTypeArm=Class'BallisticProV55.DTM353MG'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=110.000000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Fire1',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		BurstFireRateFactor=0.66
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Deploy weapon"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.01000),(InVal=0.180000,OutVal=-0.020000),(InVal=0.300000,OutVal=0.040000),(InVal=0.500000,OutVal=0.030000),(InVal=0.650000,OutVal=0.00000),(InVal=0.700000,OutVal=-0.0200000),(InVal=0.850000,OutVal=0.010000),(InVal=1.000000,OutVal=0.00)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.130000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.7
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=3000)
		ChaosDeclineTime=1.600000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		LayoutName="Default"
		//SightOffset=(X=10.000000,Z=4.70000)
		WeaponModes(0)=(bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst of Three",ModeID="WM_Burst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Burst of Five",ModeID="WM_Burst",Value=5.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=3
        DisplaceDurationMult=1.25
        SightMoveSpeedFactor=0.45
		MagAmmo=100
		SightingTime=0.45
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M353_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Jungle
		Index=1
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S2",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S2",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S2",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Arctic
		Index=2
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S1",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S1",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S1",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Ocean
		Index=3
		CamoName="Ocean"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S3",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S3",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S3",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S4",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S4",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S4",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Camos(0)=WeaponCamo'M353_Gray'
    Camos(1)=WeaponCamo'M353_Jungle'
    Camos(2)=WeaponCamo'M353_Arctic'
    Camos(3)=WeaponCamo'M353_Ocean'
    Camos(4)=WeaponCamo'M353_Gold'
}