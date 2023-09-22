class CX61WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//5.56mm mod
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.5
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
        PenetrationEnergy=32
		PenetrateForce=180
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.6
		Recoil=180
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-Fire',Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.200000
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//15mm Cryon Spike
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_Spike
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=4725) // 30-90m
		RangeAtten=0.35
		Damage=55
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrationEnergy=64.000000
		PenetrateForce=180
		bPenetrate=True
		Inaccuracy=(X=48,Y=48)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=768.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Spike
		FireInterval=0.375000
		BurstFireRateFactor=0.4
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_Spike'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.CX61.CX61-FlameLoopStart',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="Flamer"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireHealParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		TargetState="HealGas"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.2,OutVal=-0.03),(InVal=0.4,OutVal=0.11),(InVal=0.5,OutVal=0.05),(InVal=0.6,OutVal=-0.02),(InVal=0.8,OutVal=0.04),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.190000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.620000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.135000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="5.56mm Mod"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=30
		WeaponModes(0)=(ModeName="Flamethrower",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Healing Gas",ModeID="WM_FullAuto")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireHealParams'
    End Object 

	Begin Object Class=WeaponParams Name=TacticalParams_Spike
		//Layout core
		LayoutName="Cryon Spikes"
		Weight=10
		//ADS
		SightMoveSpeedFactor=0.6
		SightingTime=0.35
		//Stats
		InventorySize=6
		DisplaceDurationMult=1
		MagAmmo=16
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Spike'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondaryFireHealParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Spike'
	
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