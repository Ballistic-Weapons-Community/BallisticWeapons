class CX61WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
	
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.CX61Flechette'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=15000.000000
		MaxSpeed=20000.000000
		AccelSpeed=1000.000000
		Damage=45
		DamageRadius=8.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=256.000000
		Chaos=-1.00000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.375000
		BurstFireRateFactor=0.4
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="Flechette"
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_556mm
		TraceRange=(Min=10000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=24
		HeadMult=3.125
		LimbMult=0.5
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.6
		Recoil=150
		Chaos=0.03
		WarnTargetPct=0.200000
		Inaccuracy=(X=48,Y=48)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_556mm
		FireInterval=0.08000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams_556mm'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopStart',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.060000),(InVal=0.400000,OutVal=0.110000),(InVal=0.500000,OutVal=-0.120000),(InVal=0.600000,OutVal=0.130000),(InVal=0.800000,OutVal=0.160000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.1000),(InVal=0.200000,OutVal=0.19000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		DeclineTime=1.5
		DeclineDelay=0.150000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1024)
		ADSMultiplier=0.200000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.00000
		ChaosSpeedThreshold=1200.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		LayoutName="Cryon Spikes"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.300000
		//Attachments
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
		DisplaceDurationMult=1
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		bNeedCock=True
		MagAmmo=16
		WeaponName="CX61 Flechette Rifle"
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireHealParams'
    End Object 

	Begin Object Class=WeaponParams Name=ClassicParams_556mm
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.5
		SightingTime=0.300000
		//Stats
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=7
		DisplaceDurationMult=1
		WeaponModes(0)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		bNeedCock=True
		MagAmmo=30
		WeaponName="CX61 Assault Rifle"
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_556mm'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireHealParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
    Layouts(1)=WeaponParams'ClassicParams_556mm'
	
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