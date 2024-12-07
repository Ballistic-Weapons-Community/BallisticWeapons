class CX61WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//556
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1250,Max=3750)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.6
		Recoil=150
		Chaos=0.03
		WarnTargetPct=0.200000
		Inaccuracy=(X=48,Y=48)
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//spike shot
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Spike
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Spike
		FireInterval=0.375000
		BurstFireRateFactor=0.4
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		TargetState="Flechette"
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Spike'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopStart',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.2,OutVal=-0.03),(InVal=0.4,OutVal=0.11),(InVal=0.5,OutVal=0.05),(InVal=0.6,OutVal=-0.02),(InVal=0.8,OutVal=0.04),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.620000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.135000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.3500000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.300000
		//Stats
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=30
		WeaponModes(0)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireHealParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Spike
		//Layout core
		LayoutName="Cryon Spikes"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.8
		SightingTime=0.300000
		//Stats
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=16
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Spike'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireHealParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Spike'
	
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