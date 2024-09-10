class X82WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=125
        HeadMult=1.40
        LimbMult=0.90
		PenetrationEnergy=128
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrateForce=450
		PushbackForce=255.000000
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=3072.000000
		Chaos=0.700000
		BotRefireRate=0.300000
		WarnTargetPct=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire',Volume=10.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.25
		FireEndAnim=	
		AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams

	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		XRandFactor=0.45
		YRandFactor=0.25
		MinRandFactor=0.45
		MaxRecoil=8192
		ClimbTime=0.15
		DeclineDelay=0.35
		DeclineTime=1
		CrouchMultiplier=0.750000
		HipMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.35
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="NV Scope"
		LayoutTags="nv"
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.6	
        ZoomType=ZT_Logarithmic
		ScopeScale=0.8	
		//Stats
		CockAnimRate=1.700000
		ReloadAnimRate=0.70000
		SightPivot=(Roll=-1024)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.4
		InventorySize=7
		MagAmmo=5
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_ACOG
		//Layout core
		Weight=10
		LayoutName="4X Scope"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_3XScope',BoneName="RearSight",Scale=0.04,AugmentOffset=(x=3.90,y=-0.25,z=0),AugmentRot=(Pitch=0,Yaw=0,Roll=-16384))
		//ADS
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=4
		SightOffset=(X=5.00,Y=-0.50,Z=4.25)
		SightPivot=(Roll=-1024)
		SightMoveSpeedFactor=0.6
		SightingTime=0.6	
		//Stats
		CockAnimRate=1.700000
		ReloadAnimRate=0.70000
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.4
		InventorySize=7
		MagAmmo=5
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Irons
		//Layout core
		Weight=1
		LayoutName="Irons"
		LayoutTags="irons"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=50,Scale=0f)
		//ADS
        ZoomType=ZT_Irons
		SightOffset=(X=3,Y=-0.0215,Z=4.372500)
		SightPivot=(Roll=0)
		SightMoveSpeedFactor=0.900000
		SightingTime=0.400000
		//Function
		CockAnimRate=1.700000
		ReloadAnimRate=0.70000
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
        DisplaceDurationMult=1.4
		InventorySize=7
		MagAmmo=5
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_ACOG'
    Layouts(2)=WeaponParams'ArenaParams_Irons'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=X83_Silver
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainDesert",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_HexGreen
		Index=2
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainHexGreen",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Winter
		Index=3
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainWinter",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Superfly
		Index=4
		CamoName="Superfly"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainFleur",Index=1,AIndex=0,PIndex=-1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Quantum
		Index=5
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainQuantumShine",Index=1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainGoldShine",Index=1,AIndex=0,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'X83_Silver'
	Camos(1)=WeaponCamo'X83_Desert'
	Camos(2)=WeaponCamo'X83_HexGreen'
	Camos(3)=WeaponCamo'X83_Winter'
	Camos(4)=WeaponCamo'X83_Superfly'
	Camos(5)=WeaponCamo'X83_Quantum'
	Camos(6)=WeaponCamo'X83_Gold'
}