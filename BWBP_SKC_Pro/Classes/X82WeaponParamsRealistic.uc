class X82WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000) //50 cal
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=185.0
		HeadMult=2.0
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
		PenetrationEnergy=48.000000
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire8',Volume=12.100000,Radius=450.000000)
		Recoil=2000.000000
		Chaos=0.050000
		PushbackForce=100.000000
		Inaccuracy=(X=12,Y=12)
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.850000
		BurstFireRateFactor=1.00
		FireAnimRate=0.950000
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.500000
		XRandFactor=0.850000
		YRandFactor=0.450000
		MaxRecoil=3000.000000
		DeclineTime=1.150000
		DeclineDelay=0.500000
		ViewBindFactor=0.300000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=740,Max=2008)
		AimAdjustTime=0.900000
		OffsetAdjustTime=0.325000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.850000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		SightingTime=0.4
		MagAmmo=5
		bMagPlusOne=True
		ViewOffset=(X=1,Y=3,Z=-5)
		//SightOffset=(X=13.000000,Y=-1.600000,Z=7.200000)
		SightPivot=(Roll=-1024)
		ZoomType=ZT_Logarithmic
		//CockAnimRate=1.000000
		//ReloadAnimRate=0.400000
		WeaponName="X83A1 12.7mm Anti-Materiel Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=X83_Silver
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainDesert",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_HexGreen
		Index=2
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainHexGreen",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Winter
		Index=3
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainWinter",Index=1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Superfly
		Index=4
		CamoName="Superfly"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainFleur",Index=1,AIndex=0,PIndex=-1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Quantum
		Index=5
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainQuantumShine",Index=1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=X83_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X83Camos.X83-MainGoldShine",Index=1,AIndex=0,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'X83_Silver'
	Camos(1)=WeaponCamo'X83_Desert'
	Camos(2)=WeaponCamo'X83_HexGreen'
	Camos(3)=WeaponCamo'X83_Winter'
	Camos(4)=WeaponCamo'X83_Superfly'
	Camos(5)=WeaponCamo'X83_Quantum'
	Camos(6)=WeaponCamo'X83_Gold'
}