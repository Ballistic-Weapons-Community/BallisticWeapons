class M925WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=50.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM925MG'
		DamageTypeHead=Class'BallisticProV55.DTM925MGHEad'
		DamageTypeArm=Class'BallisticProV55.DTM925MG'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.M925.M925-Fire',Volume=0.800000)
		Recoil=160.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
		FlashScaleFactor=1.000000
		PushbackForce=200.000000
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.180000
		BurstFireRateFactor=1.00
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.250000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.600000
		YRandFactor=0.500000
		MaxRecoil=3000.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		AimAdjustTime=0.800000
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.500000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.850000
		InventorySize=9
		SightMoveSpeedFactor=0.500000
		SightingTime=0.550000
		bNeedCock=True
		MagAmmo=50
		//SightOffset=(X=-20.000000,Z=9.150000)
		//SightPivot=(Pitch=512)
		//CockAnimRate=1.000000
		//ReloadAnimRate=1.000000
		ViewOffset=(X=8,Y=10,Z=-7)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M925_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Jungle
		Index=1
		CamoName="Jungle"
		Weight=15
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainJungle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BW_Core_WeaponTex.M925.M925Small",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,AIndex=2,Pindex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M925.M925AmmoBox',Index=4,AIndex=3,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Desert
		Index=2
		CamoName="Desert"
		Weight=15
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M925.M925Small',Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M925.M925HeatShield',Index=3,AIndex=2,Pindex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M925.M925AmmoBox',Index=4,AIndex=3,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Rust
		Index=3
		CamoName="Rust"
		Weight=10
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainRust",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MiscRust",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,AIndex=2,Pindex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-AmmoRust",Index=4,AIndex=3,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Ember
		Index=4
		CamoName="Ember"
		Weight=3
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainEmber",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MiscDark",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-ShieldEmber",Index=3,AIndex=2,Pindex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M925.M925AmmoBox',Index=4,AIndex=3,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Biohazard
		Index=5
		CamoName="Biohazard"
		Weight=3
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainBiohazardShine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MiscDark",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,AIndex=2,Pindex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M925.M925AmmoBox',Index=4,AIndex=3,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M925_Gold
		Index=6
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainGoldShine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MiscDark",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-ShieldBlack",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-AmmoGoldShine",Index=4,AIndex=3,PIndex=3)
	End Object
	
	Camos(0)=WeaponCamo'M925_Gray'
	Camos(1)=WeaponCamo'M925_Jungle'
	Camos(2)=WeaponCamo'M925_Desert'
	Camos(3)=WeaponCamo'M925_Rust'
	Camos(4)=WeaponCamo'M925_Ember'
	Camos(5)=WeaponCamo'M925_Biohazard'
	Camos(6)=WeaponCamo'M925_Gold'
}