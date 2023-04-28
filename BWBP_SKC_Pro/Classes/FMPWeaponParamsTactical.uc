class FMPWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Automatic
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=72,Y=72)
		RangeAtten=0.5
     	PenetrationEnergy=16
		PenetrateForce=135
		Damage=30 // .40 SMG
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MP40Chest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40Chest'
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.900000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-Fire',Volume=1.000000)
		Recoil=80.000000
		Chaos=0.06
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.120000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 1 - INCENDIARY AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalIncPrimaryEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=28,Y=28)
		RangeAtten=0.5
     	PenetrationEnergy=16
		PenetrateForce=135
		Damage=60
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MP40_Incendiary'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head_Incendiary'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40_Incendiary'
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-HotFire',Volume=1.600000)
		Recoil=512.000000
		Chaos=0.030000
	End Object

	Begin Object Class=FireParams Name=TacticalIncPrimaryFireParams
		FireInterval=0.235000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'TacticalIncPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 2 - CORROSIVE AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalCorrosivePrimaryEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=788,Max=2363) // 15-45m
		Inaccuracy=(X=72,Y=72)
		RangeAtten=0.5
		Damage=35
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head_Corrosive'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40_Corrosive'
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-AcidFire',Volume=1.100000)
		Recoil=70.000000
		Chaos=0.030000
	End Object

	Begin Object Class=FireParams Name=TacticalCorrosivePrimaryFireParams
		FireInterval=0.090000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'TacticalCorrosivePrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL - Automatic
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.500000,OutVal=0.100000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.160000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.350000),(InVal=1.000000,OutVal=0.350000)))
		YawFactor=0.200000
		PitchFactor=0.600000
		XRandFactor=0.1
		YRandFactor=0.1
		MaxRecoil=4096.000000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.150000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.7
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=1.65
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 1 - INCENDIARY AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalIncRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.04
		DeclineTime=0.7500000
		DeclineDelay=0.45000
		ViewBindFactor=0.45
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=1.65
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 2 - CORROSIVE AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalCorrosiveRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		ClimbTime=0.04
		DeclineTime=0.7500000
		DeclineDelay=0.45000
		ViewBindFactor=0.45
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=1.65
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.25
		AimAdjustTime=0.6
    	AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=4
		SightMoveSpeedFactor=0.6
		SightingTime=0.185000
		MagAmmo=28
		bDualBlocked=True
		WeaponName="FMP-2012 .40 Machine Pistol"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalIncRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalCorrosiveRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalIncPrimaryFireParams'
		FireParams(2)=FireParams'TacticalCorrosivePrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
	
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