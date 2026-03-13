class M99TW_WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000) //55 cal
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=205.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrationEnergy=300.000000
		PenetrateForce=1000
		bPenetrate=True
		PDamageFactor=0.900000
		WallPDamageFactor=0.900000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99-Fire',Volume=5.500000)
		Recoil=3000.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"	
		FireAnimRate=1.20000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=-8000)
		ADSMultiplier=0.15
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.010000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.880000
		SightOffset=(X=-10.000000,Y=-2.000000,Z=12.000000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M99_Desert
		Index=0
		CamoName="Desert"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Jungle
		Index=1
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainJungle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscJungle",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Winter
		Index=2
		CamoName="Winter"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainWinter",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Gray
		Index=3
		CamoName="Gray"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainGray",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_UTC
		Index=4
		CamoName="UTC"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99AShine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99BShine",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Hex
		Index=5
		CamoName="Blue Hex"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainHex",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Molten
		Index=6
		CamoName="Molten"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainMolten",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Gold
		Index=7
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'M99_Desert'
	Camos(1)=WeaponCamo'M99_Jungle'
	Camos(2)=WeaponCamo'M99_Winter'
	Camos(3)=WeaponCamo'M99_Gray'
	Camos(4)=WeaponCamo'M99_UTC'
	Camos(5)=WeaponCamo'M99_Hex'
	Camos(6)=WeaponCamo'M99_Molten'
	Camos(7)=WeaponCamo'M99_Gold'
}