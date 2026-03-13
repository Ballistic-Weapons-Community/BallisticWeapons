class M99RifleWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
		HeadMult=2.25f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTM99Rifle'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTM99RifleHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTM99Rifle'
		PenetrationEnergy=300.000000
		PenetrateForce=1000
		bPenetrate=True
		PDamageFactor=0.900000
		WallPDamageFactor=0.900000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=3.000000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.M99.M99-FireOld',Volume=5.500000)
		Recoil=7000
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=2.000000
		FireAnim="Fire"
		AimedFireAnim="Fire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XRandFactor=0.300000
		YRandFactor=0.300000
		DeclineTime=1.000000
		DeclineDelay=1.2
		HipMultiplier=3
		CrouchMultiplier=0.95
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=128,Max=1156)
		SprintOffset=(Pitch=-3000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=-8000)
		ADSMultiplier=0.15
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=7
		SightMoveSpeedFactor=0.8
		SightingTime=0.65000		
		DisplaceDurationMult=1.25
		MagAmmo=1
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.800000
		SightOffset=(X=5.000000,Y=16.000000,Z=36.000000)
		SightPivot=(Roll=-1024)
		ViewOffset=(X=12.000000,Y=0.000000,Z=-25.000000)
		ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainJungle",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscJungle",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Winter
		Index=2
		CamoName="Winter"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainWinter",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Gray
		Index=3
		CamoName="Gray"
		Weight=15
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainGray",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_UTC
		Index=4
		CamoName="UTC"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99AShine",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99BShine",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Hex
		Index=5
		CamoName="Blue Hex"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainHex",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Molten
		Index=6
		CamoName="Molten"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainMolten",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=3,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M99_Gold
		Index=7
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MainGold",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M99Camos.M99_MiscGray",Index=3,AIndex=1,PIndex=1)
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