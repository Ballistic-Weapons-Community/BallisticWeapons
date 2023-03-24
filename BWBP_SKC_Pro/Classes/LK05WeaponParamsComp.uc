class LK05WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=11000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BWBP_SKC_Pro.DT_LK05Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_LK05AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_LK05Assault'
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1
		Recoil=160.000000
		Chaos=0.028000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LK05.LK05-RapidFire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.088000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.18),(InVal=0.35,OutVal=0.22),(InVal=0.5,OutVal=0.3),(InVal=0.7,OutVal=0.45),(InVal=0.85,OutVal=0.6),(InVal=1.000000,OutVal=0.66)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.4
		DeclineDelay=0.200000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Holosight"
		//Attachments
		SightOffset=(X=10.000000,Y=-8.550000,Z=24.660000)
		SightPivot=(Pitch=0,Roll=0,Yaw=0)
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=55,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=56,Scale=0f)
		//Function
		ViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
		
		PlayerJumpFactor=1
		InventorySize=6
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Irons
		//Layout core
		Weight=10
		LayoutName="Iron Sights"
		//Attachments
		SightOffset=(X=10.000000,Y=-8.600000,Z=24.250000)
		SightPivot=(Pitch=64,Roll=0,Yaw=-16)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponBoneScales(0)=(BoneName="EOTech",Slot=54,Scale=0f)
		//Function
		ViewOffset=(X=-6.000000,Y=12.000000,Z=-17.000000)
		
		PlayerJumpFactor=1
		InventorySize=6
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object	
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Irons'
	
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