class AR23WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Muzzle Brake
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		Damage=62
		HeadMult=2.00
		LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=96.000000
		PenetrateForce=100.000000
		bPenetrate=True
		PDamageFactor=0.8
		PushbackForce=250.000000
		WallPDamageFactor=0.75
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.170000
		BurstFireRateFactor=1
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Suppressor
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Supp
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		Damage=62
		HeadMult=2.00
		LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=96.000000
		PenetrateForce=100.000000
		bPenetrate=True
		PDamageFactor=0.8
		PushbackForce=250.000000
		WallPDamageFactor=0.75
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Sil',Volume=1.550000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		Recoil=1024.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Supp
		AimedFireAnim="SightFire"
		FireInterval=0.1850000
		BurstFireRateFactor=1
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Supp'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=1850.000000
		MomentumTransfer=50.000000
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2
		Recoil=1536.000000
		Chaos=0.25
		Inaccuracy=(X=512,Y=768)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireAimed"
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.200000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.075000),(InVal=0.500000,OutVal=-0.075000),(InVal=0.700000,OutVal=-0.09),(InVal=1,OutVal=0)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.500000,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.07
		YRandFactor=0.07
		MaxRecoil=5040.000000
		ClimbTime=0.06
		DeclineDelay=0.30000
		DeclineTime=1.500000
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-4000)
		ADSMultiplier=0.350000
		AimAdjustTime=0.450000
		ChaosDeclineTime=1.750000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	//Stock sight
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Adv Holo"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=1f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=1f)
		//Function
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.700000
		SightingTime=0.550000
		DisplaceDurationMult=1.2
		MagAmmo=10
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	//ACOG
	Begin Object Class=WeaponParams Name=ArenaParams_4X
		//Layout core
		Weight=10
		LayoutName="4X Scope"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=1f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_ACOG',BoneName="tip",Scale=0.12,AugmentOffset=(x=-25,y=0,z=-1),AugmentRot=(Pitch=32768,Yaw=0,Roll=0))
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		MaxZoom=4
		//Function
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.700000
		SightingTime=0.60000 //+0.5
		DisplaceDurationMult=1.2
		MagAmmo=10
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	//Sniper (Locked to semi)
	Begin Object Class=WeaponParams Name=ArenaParams_8X
		//Layout core
		Weight=10
		LayoutName="8X Scope"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=1f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_8XScope',BoneName="tip",Scale=0.05,AugmentOffset=(x=-25,y=0,z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=0))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Logarithmic// sniper 4-8x
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
		//Function
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.700000
		SightingTime=0.65000 //+1.0
		DisplaceDurationMult=1.2
		MagAmmo=10
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=true)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=0
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Supp //Suppressor, EO Tech
		//Layout core
		Weight=10
		LayoutName="Suppressor"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.2,AugmentRot=(Pitch=0,Yaw=32768,Roll=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-25,y=0,z=-1.1),AugmentRot=(Pitch=0,Yaw=32768,Roll=32768))
		//Function
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.700000
		SightingTime=0.550000
		DisplaceDurationMult=1.2
		MagAmmo=10
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Irons
		//Layout core
		Weight=3
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=51,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Holo",Slot=52,Scale=0f)
		//Function
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.700000
		SightingTime=0.450000 //-1
		DisplaceDurationMult=1.2
		MagAmmo=10
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_4X'
	Layouts(2)=WeaponParams'ArenaParams_8X'
	Layouts(3)=WeaponParams'ArenaParams_Supp'
	Layouts(4)=WeaponParams'ArenaParams_Irons'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=AR23_Tan
		Index=0
		CamoName="Tan"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Digital
		Index=1
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainDigital",Index=1,AIndex=0,PIndex=5)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Winter
		Index=2
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainWinterShine",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscWinterShine",Index=2,AIndex=1,PIndex=6)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Meat
		Index=3
		CamoName="Meat"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainMeat",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscMeat",Index=2,AIndex=1,PIndex=6)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainGold",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscGold",Index=2,AIndex=1,PIndex=6)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AR23_Tan'
	Camos(1)=WeaponCamo'AR23_Digital'
	Camos(2)=WeaponCamo'AR23_Winter'
	Camos(3)=WeaponCamo'AR23_Meat'
	Camos(4)=WeaponCamo'AR23_Gold'
}