class LK05WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//5.56mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.5
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
        PenetrationEnergy=32
		PenetrateForce=150
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1
		Recoil=190.000000
		Chaos=0.022000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.085000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//6.8mm
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_68mm
		TraceRange=(Min=9000.000000,Max=11000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=40 // 6.8mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
        PenetrationEnergy=32
		PenetrateForce=150
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.2
		Recoil=220.000000
		Chaos=0.028000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LK05.LK05-HeavyFire',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_68mm
		FireInterval=0.095000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_68mm'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.1,OutVal=0.03),(InVal=0.2,OutVal=0.045),(InVal=0.35,OutVal=-0.06),(InVal=0.5,OutVal=0.0),(InVal=0.7,OutVal=0.09),(InVal=0.85,OutVal=0.0),(InVal=1.000000,OutVal=-0.06)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=0.75
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
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=10
		LayoutName="5.56mm Holo"
		SightOffset=(X=1.5,Y=0,Z=2.16)
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Irons",Slot=57,Scale=-2f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.32
		DisplaceDurationMult=1
		MagAmmo=30
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_68mm
		//Layout core
		Weight=30
		LayoutName="6.8mm Holo"
		SightOffset=(X=1.5,Y=0,Z=2.16)
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Irons",Slot=57,Scale=-2f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_68mm'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Irons
		//Layout core
		Weight=10
		LayoutName="5.56mm Irons"
		//Attachments
		SightOffset=(X=3,Y=0,Z=1.59)
		SightPivot=(Pitch=64,Roll=0,Yaw=-16)
		WeaponBoneScales(0)=(BoneName="EOTech",Slot=54,Scale=0f)
		//Function
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.32
		DisplaceDurationMult=1
		MagAmmo=30
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 	
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_68mm'
    Layouts(2)=WeaponParams'TacticalParams_Irons'
	
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
	
	Begin Object Class=WeaponCamo Name=LK05_Jungle
		Index=3
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecJungle",Index=3,AIndex=4,PIndex=7)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Winter
		Index=4
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecWinter",Index=3,AIndex=4,PIndex=7)
		Weight=20
	End Object
	
	/*Begin Object Class=WeaponCamo Name=LK05_BlueTiger //Credit TVoid
		Index=5
		CamoName="Blue Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecBlueCamo",Index=3,AIndex=4,PIndex=7)
		Weight=3
	End Object*/
	
	Begin Object Class=WeaponCamo Name=LK05_RedTiger
		Index=5
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecRedCamo",Index=3,AIndex=4,PIndex=7)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Meat
		Index=6
		CamoName="Meat"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-HandleBlack",Index=1,AIndex=5,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-ButtBlack",Index=2,AIndex=7,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.LK05Camos.LK05-RecMeat",Index=3,AIndex=4,PIndex=7)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=LK05_Gold
		Index=7
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
	Camos(3)=WeaponCamo'LK05_Jungle'
	Camos(4)=WeaponCamo'LK05_Winter'
	Camos(5)=WeaponCamo'LK05_RedTiger'
	Camos(6)=WeaponCamo'LK05_Meat'
	Camos(7)=WeaponCamo'LK05_Gold'
}