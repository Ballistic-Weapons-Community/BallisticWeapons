class AR23WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Muzzle Brake
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=125.0
		HeadMult=2.1
		LimbMult=0.66
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.5
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
		PushbackForce=300.000000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.170000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Suppressor
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Supp
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=125.0
		HeadMult=2.1
		LimbMult=0.66
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-Sil',Volume=1.550000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
		Recoil=1024.000000
		Chaos=0.5
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
		PushbackForce=250.000000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Supp
		FireInterval=0.185000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Supp'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=36
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=25
		LimbMult=1.0
		DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
		PenetrationEnergy=16.000000
		PenetrateForce=500
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
		Recoil=2048.000000
		Chaos=0.5
		Inaccuracy=(X=1600,Y=1600)
		HipSpreadFactor=1
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=2.500000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireAimed"
		FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=4096.000000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=4096.000000
		ViewBindFactor=0.200000
		ADSViewBindFactor=1.000000 //Locked to 1
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=2560)
		AimAdjustTime=0.650000
		OffsetAdjustTime=0.325000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.450000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.450000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams //Stock sight
		//Layout core
		Weight=30
		LayoutName="Adv Holo"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(1)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=53,Scale=1f)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.27
		MagAmmo=9
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="2 Shot Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="AR-23 .50 Heavy Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	//ACOG
	Begin Object Class=WeaponParams Name=RealisticParams_4X
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
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30 //+0.3
		MagAmmo=9
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="2 Shot Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="AR-23 .50 Heavy Rifle (4X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	//Sniper
	Begin Object Class=WeaponParams Name=RealisticParams_8X
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
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.33 //+0.6
		MagAmmo=9
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="2 Shot Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=true)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=0
		WeaponName="AR-23 .50 Heavy Rifle (8X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Supp //Suppressor, EO Tech
		//Layout core
		Weight=10
		LayoutName="Suppressor"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.2,AugmentOffset=(x=-3,y=0,z=0),AugmentRot=(Pitch=0,Yaw=32768,Roll=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-25,y=0,z=-1.1),AugmentRot=(Pitch=0,Yaw=32768,Roll=32768))
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.27
		MagAmmo=9
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="2 Shot Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=true)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=0
		WeaponName="AR-23 .50 Heavy Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		Weight=3
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsFront",Slot=50,Scale=1f)
		WeaponBoneScales(1)=(BoneName="IronsRear",Slot=51,Scale=1f)
		WeaponBoneScales(2)=(BoneName="GLIrons",Slot=52,Scale=1f)
		WeaponBoneScales(3)=(BoneName="Holo",Slot=53,Scale=0f)
		WeaponBoneScales(4)=(BoneName="MuzzleAttachment",Slot=54,Scale=1f)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23 //-0.4
		MagAmmo=9
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="2 Shot Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="AR-23 .50 Heavy Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_4X'
	Layouts(2)=WeaponParams'RealisticParams_8X'
	Layouts(3)=WeaponParams'RealisticParams_Supp'
	Layouts(4)=WeaponParams'RealisticParams_Irons'
	
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