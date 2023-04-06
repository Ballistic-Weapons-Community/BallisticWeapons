class FMPWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Automatic
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1000.000000,Max=4500.000000) //.40 SMG
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=44.0
		HeadMult=2.318181
		LimbMult=0.568181
		DamageType=Class'BWBP_SKC_Pro.DT_MP40Chest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40Chest'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.900000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-Fire',Volume=1.000000)
		Recoil=80.000000
		Chaos=0.06
		Inaccuracy=(X=28,Y=28)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.120000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 1 - INCENDIARY AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticIncPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.700000
		Damage=70
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

	Begin Object Class=FireParams Name=RealisticIncPrimaryFireParams
		FireInterval=0.235000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticIncPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 2 - CORROSIVE AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticCorrosivePrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.700000
		Damage=35
		DamageType=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head_Corrosive'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
		PenetrateForce=150
		HookStopFactor=0.200000
		HookPullForce=-10.000000
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-AcidFire',Volume=1.100000)
		Recoil=70.000000
		Chaos=0.030000
	End Object

	Begin Object Class=FireParams Name=RealisticCorrosivePrimaryFireParams
		FireInterval=0.090000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticCorrosivePrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL - Automatic
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.500000,OutVal=0.100000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.160000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.350000),(InVal=1.000000,OutVal=0.350000)))
		YawFactor=0.200000
		PitchFactor=0.600000
		XRandFactor=0.750000
		YRandFactor=0.750000
		MaxRecoil=4096.000000
		DeclineTime=0.5
		DeclineDelay=0.150000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 1 - INCENDIARY AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticIncRecoilParams
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

	Begin Object Class=RecoilParams Name=RealisticCorrosiveRecoilParams
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

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.600000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.185000
		MagAmmo=28
		//SightOffset=(X=5.000000,Y=-7.670000,Z=18.900000)
		SightPivot=(YAW=10)
		WeaponName="FMP-2012 .40 Machine Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticIncRecoilParams'
		RecoilParams(2)=RecoilParams'RealisticCorrosiveRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticIncPrimaryFireParams'
		FireParams(2)=FireParams'RealisticCorrosivePrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Jungle
		Index=2
		CamoName="Dschungel"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainJungle",Index=1,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Chrome
		Index=3
		CamoName="Chrom"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainChrome",Index=1,AIndex=1,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Quantum
		Index=4
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainQuantum",Index=1,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=MP40_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FMPCamos.MP40-MainGold",Index=1,AIndex=1,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'MP40_Black'
	Camos(1)=WeaponCamo'MP40_Rust'
	Camos(2)=WeaponCamo'MP40_Jungle'
	Camos(3)=WeaponCamo'MP40_Chrome'
	Camos(4)=WeaponCamo'MP40_Quantum'
	Camos(5)=WeaponCamo'MP40_Gold'
}