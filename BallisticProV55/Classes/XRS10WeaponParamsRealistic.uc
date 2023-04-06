class XRS10WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000) //.45
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=44.0
		HeadMult=2.318181
		LimbMult=0.568181
		DamageType=Class'BallisticProV55.DTXRS10SMG'
		DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Fire',Volume=0.900000)
		Recoil=700.000000
		Chaos=0.100000
		Inaccuracy=(X=48,Y=48)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireAnimRate=2.80000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.200000),(InVal=0.800000,OutVal=0.300000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		PitchFactor=0.800000
		YawFactor=0.300000
		XRandFactor=0.190000
		YRandFactor=0.190000
		MaxRecoil=2560.000000
		DeclineTime=0.600000
		DeclineDelay=0.145000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=650.000000
		ChaosTurnThreshold=160000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15
		MagAmmo=25
		//ViewOffset=(X=5.000000,Y=9.000000,Z=-11.000000)
		//SightOffset=(X=-10.000000,Z=9.45000)
		SightPivot=(Pitch=32)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=true)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=true)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		WeaponName="XRS-10 .45 Automatic"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XRS_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainBlack",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-SuppDesert",Index=3,AIndex=2,PIndex=5)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Purple
		Index=3
		CamoName="Purple"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainPurple",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_CandyCane
		Index=4
		CamoName="Candy Cane"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10RS-Main-Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10RS-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_GoldTiger
		Index=5
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Main-Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-LAM-Shine",Index=2,AIndex=1,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-LAM-Shine",Index=2,AIndex=1,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XRS_Silver'
	Camos(1)=WeaponCamo'XRS_Black'
	Camos(2)=WeaponCamo'XRS_Desert'
	Camos(3)=WeaponCamo'XRS_Purple'
	Camos(4)=WeaponCamo'XRS_CandyCane'
	Camos(5)=WeaponCamo'XRS_GoldTiger'
	Camos(6)=WeaponCamo'XRS_Gold'
}