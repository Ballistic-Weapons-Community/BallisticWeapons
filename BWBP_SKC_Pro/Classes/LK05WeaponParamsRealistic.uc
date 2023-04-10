class LK05WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=7500.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=48.0
		HeadMult=2.333333
		LimbMult=0.666666
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
		PenetrationEnergy=19.000000
		PenetrateForce=55
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LK05.LK05-HeavyFire',Volume=1.500000)
		Recoil=465.000000 //700 hip
		Chaos=0.080000
		Inaccuracy=(X=10,Y=10)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.300000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.350000),(InVal=0.750000,OutVal=0.325000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.475000,OutVal=0.3250000),(InVal=0.750000,OutVal=0.425000),(InVal=1.000000,OutVal=0.400000)))
		XCurveAlt=(Points=(,(InVal=0.450000,OutVal=0.350000),(InVal=0.750000,OutVal=0.325000),(InVal=1.000000,OutVal=0.100000)))
		YCurveAlt=(Points=(,(InVal=0.475000,OutVal=0.1250000),(InVal=0.750000,OutVal=0.425000),(InVal=1.000000,OutVal=0.100000)))
		YawFactor=0.175000
		XRandFactor=0.165000
		YRandFactor=0.165000
		MaxRecoil=3000.000000
		DeclineTime=0.775000
		DeclineDelay=0.180000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.500000
		CrouchMultiplier=0.700000
		bViewDecline=True
		bUseAltSightCurve=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		SightOffset=(X=9,Y=0,Z=-0.09)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=8,AIndex=8)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=9,AIndex=2)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		//Function
		InventorySize=11
		MagAmmo=25
		bMagPlusOne=True
		SightMoveSpeedFactor=0.500000
		SightingTime=0.24
		//ViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="LK-05 6.8mm Assault Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		//SightOffset=(X=10.000000,Y=-8.600000,Z=24.250000)
		SightOffset=(X=7.00,Y=0.00,Z=-0.50)
		SightPivot=(Pitch=64,Roll=0,Yaw=-16)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="EOTech",Slot=54,Scale=0f)
		//Function
		InventorySize=11
		MagAmmo=25
		bMagPlusOne=True
		SightMoveSpeedFactor=0.500000
		SightingTime=0.24
		//ViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="LK-05 6.8mm Assault Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Irons'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=LK05_Tan
		Index=0
		CamoName="Tan"
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Gray
		Index=1
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-RecShine',Index=3,AIndex=4,PIndex=7)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-MainBlack",Index=3,AIndex=4,PIndex=7)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_BlueTiger //Credit TVoid
		Index=3
		CamoName="Blue Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecBlueCamo",Index=3,AIndex=4,PIndex=7)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_RedTiger
		Index=4
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecRedCamo",Index=3,AIndex=4,PIndex=7)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Meat
		Index=5
		CamoName="MEAT (WIP)"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoRed",Index=1,AIndex=4,PIndex=7)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecGold",Index=3,AIndex=4,PIndex=7)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'LK05_Tan'
	Camos(1)=WeaponCamo'LK05_Gray'
	Camos(2)=WeaponCamo'LK05_Black'
	Camos(3)=WeaponCamo'LK05_BlueTiger'
	Camos(4)=WeaponCamo'LK05_RedTiger'
	Camos(5)=WeaponCamo'LK05_Meat'
	Camos(6)=WeaponCamo'LK05_Gold'
}