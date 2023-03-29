class XK2WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		WaterTraceRange=2500.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.500000
		Damage=15.0
		HeadMult=4.0
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTXK2SMG'
		DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
		PenetrationEnergy=24.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Volume=0.500000)
		Recoil=48.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.070000
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

	//Ice
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryIceEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=14
		HeadMult=1.4f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.250000
		Recoil=98.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryIceFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryIceEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.400000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.200000
		DeclineTime=1.000000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=24,Max=2560)
		AimAdjustTime=0.400000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
		ChaosTurnThreshold=140000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		LayoutName="Default"
		
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=50
		SightOffset=(Y=-0.550000,Z=14.900000)
		SightPivot=(Pitch=600,Roll=-512)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst of Three",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Burst of Six",ModeID="WM_BigBurst",Value=6.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=3
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		FireParams(3)=FireParams'ClassicPrimaryFireParams'
		FireParams(4)=FireParams'ClassicPrimaryIceFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XK2_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Jungle
		Index=1
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainJungle",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Winter
		Index=3
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainWinter",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Silver
		Index=4
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-NickelShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Pink
		Index=5
		CamoName="Fabulous"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainPink",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-GoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XK2_Black'
	Camos(1)=WeaponCamo'XK2_Jungle'
	Camos(2)=WeaponCamo'XK2_Desert'
	Camos(3)=WeaponCamo'XK2_Winter'
	Camos(4)=WeaponCamo'XK2_Silver'
	Camos(5)=WeaponCamo'XK2_Pink'
	Camos(6)=WeaponCamo'XK2_Gold'
}