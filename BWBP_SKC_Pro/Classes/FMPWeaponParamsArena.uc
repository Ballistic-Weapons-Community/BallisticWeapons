class FMPWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // FIRE PARAMS WEAPON MODE 0 - AUTOMATIC
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaStandardPrimaryEffectParams
			TraceRange=(Min=9000.000000,Max=9000.000000)
			RangeAtten=0.700000
			Damage=25
			DamageType=Class'BWBP_SKC_Pro.DT_MP40'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40'
			PenetrateForce=150
			HookStopFactor=0.200000
			HookPullForce=-10.000000
			MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
			FlashScaleFactor=0.900000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-Fire',Volume=1.200000)
			Recoil=90.000000
			Chaos=0.030000
		End Object

		Begin Object Class=FireParams Name=ArenaStandardPrimaryFireParams
			FireInterval=0.105000
			FireEndAnim=	
			AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaStandardPrimaryEffectParams'
		End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 1 - INCENDIARY AMP
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaIncPrimaryEffectParams
			TraceRange=(Min=9000.000000,Max=9000.000000)
			RangeAtten=0.700000
			Damage=35
			DamageType=Class'BWBP_SKC_Pro.DT_MP40'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40'
			PenetrateForce=150
			HookStopFactor=0.200000
			HookPullForce=-10.000000
			MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
			FlashScaleFactor=1.100000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-HotFire',Volume=1.600000)
			Recoil=512.000000
			Chaos=0.030000
		End Object

		Begin Object Class=FireParams Name=ArenaIncPrimaryFireParams
			FireInterval=0.235000
			FireEndAnim=
			AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaIncPrimaryEffectParams'
		End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 2 - CORROSIVE AMP
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ArenaCorrosivePrimaryEffectParams
			TraceRange=(Min=9000.000000,Max=9000.000000)
			RangeAtten=0.700000
			Damage=20
			DamageType=Class'BWBP_SKC_Pro.DT_MP40'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40'
			PenetrateForce=150
			HookStopFactor=0.200000
			HookPullForce=-10.000000
			MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
			FlashScaleFactor=0.400000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-AcidFire',Volume=1.000000)
			Recoil=60.000000
			Chaos=0.030000
		End Object

		Begin Object Class=FireParams Name=ArenaCorrosivePrimaryFireParams
			FireInterval=0.100000
			FireEndAnim=
			AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaCorrosivePrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 0 - AUTOMATIC
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaStandardRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.45000
		ViewBindFactor=0.45
		CrouchMultiplier=0.800000
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 1 - INCENDIARY AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaIncRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.45000
		ViewBindFactor=0.45
		CrouchMultiplier=0.800000
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 2 - CORROSIVE AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaCorrosiveRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		DeclineTime=0.500000
		DeclineDelay=0.45000
		ViewBindFactor=0.45
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=256)
		SprintOffset=(Pitch=-1000,Yaw=-2000)
		ChaosDeclineTime=0.75
		ChaosDeclineDelay=0.1
		ADSMultiplier=0.3
		SprintChaos=0.400000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		DisplaceDurationMult=1
		InventorySize=4
		SightMoveSpeedFactor=0.90000
		SightingTime=0.300000
		MagAmmo=24
		RecoilParams(0)=RecoilParams'ArenaStandardRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaIncRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaCorrosiveRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		FireParams(1)=FireParams'ArenaIncPrimaryFireParams'
		FireParams(2)=FireParams'ArenaCorrosivePrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=MP40_Black
		Index=0
		CamoName="Schwarz"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Rust
		Index=1
		CamoName="Rost"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainRust",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Jungle
		Index=2
		CamoName="Dschungel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainJungle",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Chrome
		Index=3
		CamoName="Chrom"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainChromeShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Quantum
		Index=4
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainQuantumShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainGoldShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'MP40_Black'
	Camos(1)=WeaponCamo'MP40_Rust'
	Camos(2)=WeaponCamo'MP40_Jungle'
	Camos(3)=WeaponCamo'MP40_Chrome'
	Camos(4)=WeaponCamo'MP40_Quantum'
	Camos(5)=WeaponCamo'MP40_Gold'
}