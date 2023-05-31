class XMV850TW_WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1600.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=45.0
		HeadMult=2.266666
		LimbMult=0.666666
		DamageType=Class'BallisticProV55.DTXMV850MG'
		DamageTypeHead=Class'BallisticProV55.DTXMV850MGHead'
		DamageTypeArm=Class'BallisticProV55.DTXMV850MG'
		PenetrationEnergy=18.000000
		PenetrateForce=65
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=24.000000
		Chaos=-0.010000
		Inaccuracy=(X=9,Y=9)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.050000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.100000
		YawFactor=0.100000
		XRandFactor=0.1500000
		YRandFactor=0.15000000
		MaxRecoil=800.000000
		DeclineTime=1.000000
		DeclineDelay=0.000000
		ViewBindFactor=0.000000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.900000
		ViewBindFactor=0.000000
		SprintChaos=0.400000
		ChaosDeclineTime=1.650000
		ChaosSpeedThreshold=350
		AimDamageThreshold=2000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.700000
		PlayerJumpFactor=0.750000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=900
		//ViewOffset=(X=7.000000,Y=6.000000,Z=-18.000000)
		//SightOffset=(X=8.000000,Z=28.000000)
		SightPivot=(Pitch=700,Roll=2048)
		WeaponModes(0)=(ModeName="1200 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="2400 RPM",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(2)=(ModeName="3600 RPM",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=0.800000
		//CockAnimRate=1.000000
		WeaponName="Mounted XMV-858 5.56mm Minigun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=XMV_Teal
		Index=0
		CamoName="Teal"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XMV_Green
		Index=1
		CamoName="Green"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV858_Main",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV858_Barrels_SD",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=XMV_Black
		Index=2
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV500_Main",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMVCamos.XMV500_Barrels_SD",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'XMV_Teal'
    Camos(1)=WeaponCamo'XMV_Green'
    Camos(2)=WeaponCamo'XMV_Black'
}