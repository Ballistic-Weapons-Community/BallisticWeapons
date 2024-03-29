class SuperchargerWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	/*Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=9
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=100
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.100000
		FireEndAnim="FireLoopEnd"	
		FireAnim="FireLoop"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object*/
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=9
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=20
		Chaos=0.01
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.063150
		FireEndAnim="FireLoopEnd"	
		FireAnim="FireLoop"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaPrimarySpreadEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=9
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100
		Chaos=0.01
		Inaccuracy=(X=512,Y=512)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimarySpreadFireParams
		FireInterval=0.040150
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimarySpreadEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=75
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
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.500000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="MeleeLoopStart"
        FireEndAnim="MeleeLoopEnd"
        FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.000000
		ClimbTime=0.03
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
        ADSMultiplier=0.5
		ViewBindFactor=0.200000
		ChaosDeclineTime=1.500000
		SprintChaos=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpChaos=0.5
		JumpOffset=(Pitch=-6000,Yaw=2000)
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=8
		PlayerSpeedFactor=0.950000
		SightMoveSpeedFactor=0.950000
		SightingTime=0.500000
		ZoomType=ZT_Fixed
		MaxZoom=4
		InitialWeaponMode=2
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponModes(0)=(ModeName="Mode: Area Charge",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Mode: Dolphin",ModeID="WM_FullAuto",Value=5.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Mode: Precise Charge",ModeID="WM_FullAuto")
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimarySpreadFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		FireParams(2)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'
	
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