class CX61WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//15mm Cryon Spike
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=85
		HeadMult=2.0
		LimbMult=0.6
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrationEnergy=24.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=768.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.375000
		BurstFireRateFactor=0.4
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//5.56mm modification
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_556mm
		TraceRange=(Min=5200.000000,Max=5200.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		RangeAtten=0.5
		DecayRange=(Min=1400.0,Max=5200.0)
		Damage=43.0
		HeadMult=2.0
		LimbMult=0.6
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrationEnergy=24.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FlashScaleFactor=1.6
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=180
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_556mm
		FireInterval=0.150000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_556mm'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopStart',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.1000),(InVal=0.200000,OutVal=0.19000),(InVal=0.400000,OutVal=0.360000),(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		MaxRecoil=4096.000000
		DeclineTime=1.5
		DeclineDelay=0.150000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=550.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Cryon Spikes"
		Weight=10
		WeaponPrice=3200
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.350000
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=16
		bMagPlusOne=True
		WeaponName="CX61 15mm Flechette Rifle"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireHealParams'
    End Object 

	Begin Object Class=WeaponParams Name=RealisticParams_556mm
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		WeaponPrice=3200
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.350000
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		WeaponModes(0)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=30
		bMagPlusOne=True
		WeaponName="CX61 5.56mm Modified Rifle"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_556mm'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireHealParams'
    End Object 
	
    Layouts(0)=WeaponParams'RealisticParams'
    Layouts(1)=WeaponParams'RealisticParams_556mm'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=CX61_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainRedShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=TexOscillator'BW_Core_WeaponTex.A73RedLayout.A73BEnergyOsc',Index=4,AIndex=2,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_White
		Index=2
		CamoName="White"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainWhiteShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_Hex
		Index=3
		CamoName="Hex Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainHexShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_Stripes
		Index=4
		CamoName="Limited"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainStripesShine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=7
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_Meat
		Index=5
		CamoName="MEAT"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainMeat",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=TexOscillator'BW_Core_WeaponTex.A73RedLayout.A73BEnergyOsc',Index=4,AIndex=2,PIndex=2)
		
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=CX61_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CX61Camos.CX61-MainGold",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.CX61.CX61-MagShine',Index=2,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'CX61_Blue'
	Camos(1)=WeaponCamo'CX61_Red'
	Camos(2)=WeaponCamo'CX61_White'
	Camos(3)=WeaponCamo'CX61_Hex'
	Camos(4)=WeaponCamo'CX61_Stripes'
	Camos(5)=WeaponCamo'CX61_Meat'
	Camos(6)=WeaponCamo'CX61_Gold'
}