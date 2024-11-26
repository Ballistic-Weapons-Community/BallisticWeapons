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
		DamageType=Class'BWBP_SKC_Pro.DT_MP40Chest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40Chest'
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
		FireInterval=0.12800
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaStandardPrimaryEffectParams'
	End Object

	//Supp
	Begin Object Class=InstantEffectParams Name=ArenaStandardPrimaryEffectParams_Supp
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.700000
		Damage=25
		DamageType=Class'BWBP_SKC_Pro.DT_MP40Chest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40Chest'
		PenetrateForce=150
		HookStopFactor=0.200000
		HookPullForce=-10.000000
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.900000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK490-SilFire',Pitch=1.5,Volume=0.800000,Radius=256.000000,bAtten=True) //
		Recoil=80.000000 //
		Chaos=0.040000 //
	End Object

	Begin Object Class=FireParams Name=ArenaStandardPrimaryFireParams_Supp
		FireInterval=0.13 //
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaStandardPrimaryEffectParams_Supp'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 1 - INCENDIARY AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaIncPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.700000
		Damage=35
		DamageType=Class'BWBP_SKC_Pro.DT_MP40_Incendiary'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head_Incendiary'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40_Incendiary'
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
		DamageType=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head_Corrosive'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
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
    // SECONDARY FIRE
    //=================================================================	
	
	//Amp
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
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
		//Layout Core
		LayoutName="Amplifier"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.90000
		SightingTime=0.300000
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		DisplaceDurationMult=1
		InventorySize=4
		MagAmmo=24
		RecoilParams(0)=RecoilParams'ArenaStandardRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaIncRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaCorrosiveRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		FireParams(1)=FireParams'ArenaIncPrimaryFireParams'
		FireParams(2)=FireParams'ArenaCorrosivePrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Supp
		//Layout Core
		LayoutName="Suppressed"
		LayoutTags="no_amp"
		Weight=5
		//Visual
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorAK',BoneName="tip",AugmentOffset=(x=0,y=0.0,z=0.1),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightMoveSpeedFactor=0.90000
		SightingTime=0.300000
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		DisplaceDurationMult=1
		InventorySize=4
		MagAmmo=24
		RecoilParams(0)=RecoilParams'ArenaStandardRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Holo
		//Layout Core
		LayoutName="Holosight"
		LayoutTags="no_amp"
		Weight=5
		//Visual
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_RifleRail',BoneName="tip",AugmentOffset=(x=-25,y=1,z=0),Scale=0.05,AugmentRot=(Pitch=32768,Roll=16384,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_ReflexCircle',BoneName="tip",AugmentOffset=(x=-25,y=-1.75,z=-0.15),Scale=0.035,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//ADS
		SightMoveSpeedFactor=0.90000
		SightingTime=0.300000
		SightOffset=(X=-3.5,Y=-0.05,Z=4.45)
		SightPivot=(YAW=10)
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		DisplaceDurationMult=1
		InventorySize=4
		MagAmmo=24
		RecoilParams(0)=RecoilParams'ArenaStandardRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Supp'
	Layouts(2)=WeaponParams'ArenaParams_Holo'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainRust",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=1,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Jungle
		Index=2
		CamoName="Dschungel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainJungle",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=1,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Chrome
		Index=3
		CamoName="Chrom"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainChromeShine",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=1,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Quantum
		Index=4
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainQuantumShine",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=1,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainGoldShine",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.MP40.MP40-MagShine',Index=2,AIndex=1,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'MP40_Black'
	Camos(1)=WeaponCamo'MP40_Rust'
	Camos(2)=WeaponCamo'MP40_Jungle'
	Camos(3)=WeaponCamo'MP40_Chrome'
	Camos(4)=WeaponCamo'MP40_Quantum'
	Camos(5)=WeaponCamo'MP40_Gold'
}