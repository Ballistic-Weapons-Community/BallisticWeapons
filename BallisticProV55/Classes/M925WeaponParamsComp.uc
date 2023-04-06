class M925WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=3000,Max=7000)
		PenetrationEnergy=96
		RangeAtten=0.75
		Damage=50
        HeadMult=2.0f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTM925MG'
		DamageTypeHead=Class'BallisticProV55.DTM925MGHead'
		DamageTypeArm=Class'BallisticProV55.DTM925MG'
		PenetrateForce=300
		PushbackForce=128.000000
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=450.000000
		Chaos=0.150000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.M925.M925-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.250000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.250000
		CrouchMultiplier=0.700000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.40000),(InVal=0.500000,OutVal=0.550000),(InVal=0.700000,OutVal=0.70000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.500000,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.07
		YRandFactor=0.07
		MaxRecoil=6500.000000
		DeclineTime=1.500000
		DeclineDelay=0.40000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=128,Max=1280)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-4000)
        ADSMultiplier=0.75
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.750000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		WeaponBoneScales(0)=(BoneName="M925RearIronSides",Slot=5,Scale=0f)
		CockAnimRate=1.250000
		ReloadAnimRate=1.150000
		//SightOffset=(X=-6.000000,Z=7.100000)
		DisplaceDurationMult=1.4
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.7
		SightingTime=0.550000
		WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=True)
		MagAmmo=50
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainRust",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MiscRust",Index=2,AIndex=1,PIndex=1)
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
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.M925Camos.M925-MainBiohazardShine",Index=0,AIndex=0,PIndex=0)
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