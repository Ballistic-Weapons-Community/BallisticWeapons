class X82TW_WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=110
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrateForce=450
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=768.000000
     	PushbackForce=0.000000
     	Chaos=0.500000
		BotRefireRate=0.300000
		WarnTargetPct=0.700000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire4',Radius=750.000000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.530000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams

	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.000000
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=1
		PitchFactor=0.350000
		YawFactor=0.000000
		XRandFactor=0.000000
		YRandFactor=0.200000
		DeclineTime=0.500000
		DeclineDelay=0.150000
		MaxRecoil=8192
		HipMultiplier=1
		CrouchMultiplier=1
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=0,Max=0)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.1
		AimDamageThreshold=2000.000000
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.200000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.85
		PlayerJumpFactor=0.85
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.010000		
		DisplaceDurationMult=1.25
		MagAmmo=4
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=X83_Silver
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainDesert",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_HexGreen
		Index=2
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainHexGreen",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Winter
		Index=3
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainWinter",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Superfly
		Index=4
		CamoName="Superfly"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainFleur",Index=1,AIndex=0,PIndex=-1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Quantum
		Index=5
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainQuantumShine",Index=1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainGoldShine",Index=1,AIndex=0,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'X83_Silver'
	Camos(1)=WeaponCamo'X83_Desert'
	Camos(2)=WeaponCamo'X83_HexGreen'
	Camos(3)=WeaponCamo'X83_Winter'
	Camos(4)=WeaponCamo'X83_Superfly'
	Camos(5)=WeaponCamo'X83_Quantum'
	Camos(6)=WeaponCamo'X83_Gold'
}