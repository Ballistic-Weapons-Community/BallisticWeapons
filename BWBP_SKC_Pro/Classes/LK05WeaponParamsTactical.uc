class LK05WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=11000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=40
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
        PenetrationEnergy=32
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1
		Recoil=160.000000
		Chaos=0.028000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.095000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.4
		DeclineDelay=0.200000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1536)
        ADSMultiplier=0.5
		AimAdjustTime=0.600000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		SightOffset=(X=25.000000,Y=-8.600000,Z=24.250000)
		SightPivot=(Pitch=64,Roll=0,Yaw=-16)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="EOTech",Slot=54,Scale=0f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Irons'
	
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