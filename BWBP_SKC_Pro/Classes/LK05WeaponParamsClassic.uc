class LK05WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.800000
		Damage=24
		HeadMult=3.125
		LimbMult=0.541666
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
		PenetrationEnergy=32.000000
		PenetrateForce=75
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		HookStopFactor=0.2
		HookPullForce=-10
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
		Recoil=128.000000
		Chaos=-1.0
		Inaccuracy=(X=96,Y=96)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
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

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.7
		DeclineDelay=0.150000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.450000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2250)
		CrouchMultiplier=0.450000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Holo
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=8,AIndex=8)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-EOTechGlow2',Index=9,AIndex=2)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		//Function
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=25
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		SightOffset=(X=10.000000,Y=-8.600000,Z=24.250000)
		SightPivot=(Pitch=64,Roll=0,Yaw=-16)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="EOTech",Slot=54,Scale=0f)
		//Function
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=25
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams_Holo'
	Layouts(1)=WeaponParams'ClassicParams_Irons'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=LK05_Tan
		Index=0
		CamoName="Tan"
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Gray
		Index=1
		CamoName="Gray"
		WeaponMaterialSwaps(0)=(Material=Shader'BWBP_SKC_Tex.LK05.LK05-RecShine',Index=3,AIndex=4,PIndex=7)
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
		CamoName="MEAT"
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