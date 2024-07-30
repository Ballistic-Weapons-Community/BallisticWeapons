class SuperchargerWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=7
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2
		Chaos=0.01
		Heat=0.15
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.063150
		FireEndAnim="FireLoopEnd"	
		FireAnim="FireLoop"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=RealisticPrimarySpreadEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=10
		Chaos=0.01
		Heat=0.25
		Inaccuracy=(X=512,Y=512)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimarySpreadFireParams
		FireInterval=0.040150
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimarySpreadEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=20
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeChomped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeChomped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeChomped'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
        HookStopFactor=1.500000
        HookPullForce=150.000000
        WarnTargetPct=0.05
		FlashScaleFactor=0.500000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-ChompStart',Volume=0.750000,Radius=256.000000)
    End Object
    
    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        FireInterval=0.100000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="EndReload"
        FireEndAnim="MeleeLoopEnd"
        FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.400000)))
		CrouchMultiplier=0.800000
		XRandFactor=0.25000
		YRandFactor=0.25000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		DeclineDelay=0.350000
		ViewBindFactor=0.750000
		ADSViewBindFactor=0.750000
		HipMultiplier=1.000000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=900,Max=2308)
		AimAdjustTime=0.450000
		OffsetAdjustTime=0.500000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
		ChaosDeclineTime=1.200000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=8
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		//SightOffset=(X=40.000000,Y=3.000000,Z=30.000000)
		SightPivot=(Pitch=64)
		WeaponModes(0)=(ModeName="Mode: Area Charge",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Mode: Dolphin",ModeID="WM_FullAuto",Value=5.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Mode: Precise Charge",ModeID="WM_FullAuto")
		InitialWeaponMode=2
        ZoomType=ZT_Fixed
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimarySpreadFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=Super_Industrial
		Index=0
		CamoName="Industrial"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Super_Green
		Index=1
		CamoName="OD Green"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SuperchargerCamos.Supercharger-MainGreen",Index=3,AIndex=4,PIndex=4)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Super_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SuperchargerCamos.Supercharger-MainBlack",Index=3,AIndex=4,PIndex=4)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Super_Quantum
		Index=3
		CamoName="Quantum"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SuperchargerCamos.Supercharger-MainGreen",Index=3,AIndex=4,PIndex=4)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Super_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SuperchargerCamos.Supercharger-MainGreen",Index=3,AIndex=4,PIndex=4)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Super_Industrial'
	Camos(1)=WeaponCamo'Super_Green'
	Camos(2)=WeaponCamo'Super_Black'
	//Camos(3)=WeaponCamo'Super_Quantum'
	//Camos(4)=WeaponCamo'Super_Gold'
}