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
        DecayRange=(Min=2300,Max=6000)
		RangeAtten=0.75
		Damage=52
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
        PenetrationEnergy=48
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.5
		Recoil=360.000000
		Chaos=0.070000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.20000
		BurstFireRateFactor=0.55
		FireEndAnim=	
		AimedFireAnim="AimedFire"
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_600
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=6000)
		RangeAtten=0.75
		Damage=52
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
        PenetrationEnergy=48
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		FlashScaleFactor=0.5
		Recoil=360.000000
		Chaos=0.065000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_600
		FireInterval=0.20000
		BurstFireRateFactor=0.55
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_600'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.5,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=1.00000
		DeclineDelay=0.400000
	End Object
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams_600
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.5,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.1000
		DeclineTime=1.00000
		DeclineDelay=0.400000
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=512,Max=2048)
		AimAdjustTime=0.8
        ADSMultiplier=0.5
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=AimParams Name=TacticalAimParams_600
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=512,Max=2048)
		AimAdjustTime=0.600000
        ADSMultiplier=0.5
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams_Scope
		//Layout core
		LayoutName="Adv Scope"
		Weight=30
		//Attachments
		//Function
		SightOffset=(X=20.000000,Z=11.750000)
		ViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
		MagAmmo=20
		SightingTime=0.5
		SightMoveSpeedFactor=0.4
        InventorySize=6
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="Holosight"
		Weight=10
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
		//Function
		SightOffset=(X=16.000000,Z=10.460000)
		ViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
        SightingTime=0.35
		SightMoveSpeedFactor=0.5
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_600'
		AimParams(0)=AimParams'TacticalAimParams_600'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_600'
    End Object 
	
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
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KMain",Index=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KScopeShine",Index=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRSCamos.SRS900-KAmmo",Index=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_DesertTac
		Index=2
		CamoName="Desert Tac"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Black
		Index=3
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRS600Camos.SRSNSGrey",Index=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Flecktarn
		Index=4
		CamoName="Flecktarn"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRS600Camos.SRSM2German",Index=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Blue
		Index=5
		CamoName="Blue"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRS600Camos.SRSNSJungle",Index=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_Red
		Index=6
		CamoName="Red"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRS600Camos.SRSNSTiger",Index=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=SRS_RedTiger
		Index=7
		CamoName="Red Tiger"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=3)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRS600Camos.SRSNSFlame",Index=0)
	End Object
	
    Layouts(0)=WeaponParams'TacticalParams_Scope'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
	Camos(0)=WeaponCamo'SRS_Gray'
    Camos(1)=WeaponCamo'SRS_Desert'
    Camos(2)=WeaponCamo'SRS_DesertTac'
    Camos(3)=WeaponCamo'SRS_Black'
    Camos(4)=WeaponCamo'SRS_Flecktarn'
    Camos(5)=WeaponCamo'SRS_Blue'
    Camos(6)=WeaponCamo'SRS_Red'
    Camos(7)=WeaponCamo'SRS_RedTiger'
}