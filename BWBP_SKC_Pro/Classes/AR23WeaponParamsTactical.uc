class AR23WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		Damage=70
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=96
		PenetrateForce=100.000000
		bPenetrate=True
		PDamageFactor=0.8
		PushbackForce=250.000000
		WallPDamageFactor=0.75
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=0.5
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=350.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.170000
		BurstFireRateFactor=1
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=1050,Max=2100)
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=13
		HeadMult=1.5f
        LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=1850.000000
		MomentumTransfer=50.000000
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2
		Recoil=768.000000
		Chaos=0.25
		Inaccuracy=(X=256,Y=256)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireAimed"
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.200000
		CrouchMultiplier=0.750000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.20000),(InVal=0.5,OutVal=0.220000),(InVal=0.700000,OutVal=0.35000),(InVal=0.5)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.5,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=1.500000
		DeclineDelay=0.40000
		HipMultiplier=1.5
		MaxMoveMultiplier=3
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=768,Max=3072)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-4000)
		ADSMultiplier=0.5
		AimAdjustTime=0.70000
		ChaosDeclineTime=1.750000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=7
        SightMoveSpeedFactor=0.45
		SightingTime=0.65000
		DisplaceDurationMult=1.2
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=3,Scale=1f)
		MagAmmo=18
		ViewOffset=(X=7.000000,Y=7.00000,Z=-12.000000)
		ViewPivot=(Pitch=384)
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=AR23_Tan
		Index=0
		CamoName="Tan"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Digital
		Index=1
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainDigital",Index=1,AIndex=0,PIndex=5)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Winter
		Index=2
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainWinterShine",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscWinterShine",Index=2,AIndex=1,PIndex=6)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Meat
		Index=3
		CamoName="MEAT"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainMeat",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscMeat",Index=2,AIndex=1,PIndex=6)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AR23_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MainGold",Index=1,AIndex=0,PIndex=5)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AR23Camos.AR23-MiscGold",Index=2,AIndex=1,PIndex=6)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AR23_Tan' //Black
	Camos(1)=WeaponCamo'AR23_Digital'
	Camos(2)=WeaponCamo'AR23_Winter'
	Camos(3)=WeaponCamo'AR23_Meat'
	Camos(4)=WeaponCamo'AR23_Gold'
}