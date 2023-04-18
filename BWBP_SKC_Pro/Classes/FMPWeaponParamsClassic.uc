class FMPWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Automatic
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		WaterTraceRange=7200.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.700000
		Damage=20
		HeadMult=3.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_MP40Chest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MP40Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MP40Chest'
		bPenetrate=True
		PenetrationEnergy=16.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		HookStopFactor=0.2
		HookPullForce=-10
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.900000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MP40.MP40-Fire',Volume=1.000000)
		Recoil=128.000000
		Chaos=-1.0
		Inaccuracy=(X=28,Y=28)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.122500
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 1 - INCENDIARY AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicIncPrimaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicIncPrimaryFireParams
		FireInterval=0.235000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ClassicIncPrimaryEffectParams'
	End Object
		
	//=================================================================
    // FIRE PARAMS WEAPON MODE 2 - CORROSIVE AMP
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicCorrosivePrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.700000
		Damage=22
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

	Begin Object Class=FireParams Name=ClassicCorrosivePrimaryFireParams
		FireInterval=0.100000
		FireEndAnim=
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ClassicCorrosivePrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL - Automatic
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.600000
		MaxRecoil=2048.000000
		DeclineTime=0.5
		DeclineDelay=0.100000
		ViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object
	
	//=================================================================
	// RECOIL PARAMS WEAPON MODE 1 - INCENDIARY AMP
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicIncRecoilParams
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

	Begin Object Class=RecoilParams Name=ClassicCorrosiveRecoilParams
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

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=1024) //Heavy SMG
		CrouchMultiplier=0.500000
		ADSMultiplier=0.3
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
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		MagAmmo=28
		//SightOffset=(X=5.000000,Y=-7.670000,Z=18.900000)
		SightPivot=(YAW=10)
		ViewOffset=(X=8.000000,Y=6.000000,Z=-3.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicIncRecoilParams'
		RecoilParams(2)=RecoilParams'ClassicCorrosiveRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicIncPrimaryFireParams'
		FireParams(2)=FireParams'ClassicCorrosivePrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
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