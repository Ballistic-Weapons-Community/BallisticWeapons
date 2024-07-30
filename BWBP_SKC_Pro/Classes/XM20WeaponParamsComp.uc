class XM20WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{ 
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=7500.000000)
		Damage=25
		DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
		PenetrateForce=600
		bPenetrate=False
		MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20FlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=16.000000
		BotRefireRate=0.90
		WarnTargetPct=0.10000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.XM20.XM20-PulseFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.15
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Proto
		FireInterval=0.13
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE - QUICK CHARGE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=12
		HeadMult=2.00
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
		Chaos=0
		Recoil=16
		FlashScaleFactor=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		TargetState="Laser"
		FireInterval=0.070000
		PreFireAnim="LoopStart"
		FireLoopAnim="LoopFire"
		FireEndAnim="LoopEnd"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Shield
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Shield

	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Shield
		TargetState="Shield"
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="Cock"
		FireAnimRate=1.00
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Shield'
	End Object

	//=================================================================
    // SECONDARY FIRE - OVERCHARGE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParamsOvercharge
		Damage=18
		HeadMult=2.00
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_XM20_Body'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_XM20_Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_XM20_Body'
		Chaos=0
		Recoil=64
		FlashScaleFactor=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParamsOvercharge
		TargetState="Laser"
		FireInterval=0.07000
		PreFireAnim="LoopOpenStart"
		FireLoopAnim="LoopOpenFire"
		FireEndAnim="LoopOpenEnd"
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParamsOvercharge'
	End Object

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.150000,OutVal=0.020000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.11),(InVal=0.400000,OutVal=0.130000),(InVal=0.600000,OutVal=0.20000),(InVal=0.800000,OutVal=0.25000),(InVal=1.000000,OutVal=0.30000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.550000),(InVal=0.500000,OutVal=0.600000),(InVal=0.600000,OutVal=0.670000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.02
		DeclineDelay=0.2
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.5
		ChaosDeclineDelay=0.3
		ChaosSpeedThreshold=300
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Quick Charge"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		WeaponBoneScales(1)=(BoneName="Prototype",Slot=59,Scale=0f)
		//SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Fixed
		MaxZoom=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000
		//Function
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1         
		MagAmmo=34
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParamsOvercharge'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Shield
		//Layout core
		Weight=30
		LayoutName="Shield System"
		LayoutTags="shield"
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		AllowedCamos(4)=4
		//Attachments
		WeaponBoneScales(1)=(BoneName="Prototype",Slot=59,Scale=0f)
		//SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Fixed
		MaxZoom=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.40000
		//Function
		WeaponModes(0)=(ModeName="Laser Beam",bUnavailable=True)
		WeaponModes(1)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Laser: Overcharge",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1         
		MagAmmo=34
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Shield'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_Proto
		//Layout core
		Weight=10
		LayoutName="Prototype"
		LayoutTags="prototype"
		AllowedCamos(0)=5
		AllowedCamos(1)=6
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.XM20Prototype.XM20-MainProtoShine',Index=2,AIndex=1,PIndex=3)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.XM20Prototype.XM20-MiscProto',Index=3,AIndex=2,PIndex=0)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BWBP_SKC_Tex.XM20Prototype.XM20-WiresProto',Index=5,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Shader'BWBP_SKC_Tex.CYLO.CYLO-SightShader',Index=6,AIndex=-1,PIndex=-1)
		WeaponBoneScales(1)=(BoneName="Prototype",Slot=59,Scale=1f)
		//ADS
		SightOffset=(X=8.00,Y=0.00,Z=3.30)
		ZoomType=ZT_Fixed
		MaxZoom=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.35000
		ScopeScale=0.6
		ScopeViewTex=Texture'BWBP_SKC_Tex.XM20.XM20-ScopeViewReflex'
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=40
		WeaponModes(0)=(ModeName="Laser Beam",bUnavailable=True)
		WeaponModes(1)=(ModeName="Laser: Quick Charge",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(ModeName="Laser: Overcharge",ModeID="WM_FullAuto")
		InitialWeaponMode=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Proto'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParamsOvercharge'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Shield'
    Layouts(2)=WeaponParams'ArenaParams_Proto'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XM20_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexGreen
		Index=1
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoGreen",Index=2,AIndex=1,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexBlue
		Index=2
		CamoName="Blue Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoBlue",Index=2,AIndex=1,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_HexOrange
		Index=3
		CamoName="Yellow Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoWhite",Index=2,AIndex=1,PIndex=3)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XM20Camos.XM20-FinalCamoGold",Index=2,AIndex=1,PIndex=3)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20P_Blue
		Index=5
		CamoName="Prototype"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XM20P_Yellow
		Index=6
		CamoName="Test Bed"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.XM20Prototype.XM20-MainBurnedShine',Index=2,AIndex=1,PIndex=3)
		Weight=5
	End Object
	
	Camos(0)=WeaponCamo'XM20_Black'
	Camos(1)=WeaponCamo'XM20_HexGreen'
	Camos(2)=WeaponCamo'XM20_HexBlue'
	Camos(3)=WeaponCamo'XM20_HexOrange'
	Camos(4)=WeaponCamo'XM20_Gold'
	Camos(5)=WeaponCamo'XM20P_Blue'
	Camos(6)=WeaponCamo'XM20P_Yellow'
}