class SuperchargerWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=3
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-FireSingle',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=35
		Chaos=0.01
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.063150
		FireEndAnim=""	
		FireAnim=""
		FireLoopAnim=""
		AimedFireAnim=""
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams_Sniper
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
		Recoil=5
		Chaos=0.01
		Inaccuracy=(X=32,Y=32)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Sniper
		FireInterval=0.063150
		FireEndAnim="FireLoopEnd"	
		FireAnim="FireLoop"
		FireLoopAnim="FireLoop"
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=75
		DamageType=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_SuperchargeZapped'
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
        HookStopFactor=1.500000
        HookPullForce=150.000000
        WarnTargetPct=0.05
		FlashScaleFactor=0.500000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.Supercharger.SC-ChompStart',Volume=0.750000,Radius=256.000000)
    End Object
    
    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        FireInterval=0.500000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="MeleeLoopStart"
        FireEndAnim="MeleeLoopEnd"
        FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=0.800000,OutVal=0.000000),(InVal=1.000000,OutVal=-0.400000)))
		ViewBindFactor=0.400000
		CrouchMultiplier=0.800000
		XRandFactor=0.25000
		YRandFactor=0.25000
		MaxRecoil=1600
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2048)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.500000
		CrouchMultiplier=0.850000
		ADSMultiplier=0.850000
		ViewBindFactor=0.050000
		ChaosDeclineTime=0.800000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=11
		SightingTime=0.300000
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		//SightOffset=(X=40.000000,Y=3.000000,Z=30.000000)
		SightPivot=(Pitch=64)
        ZoomType=ZT_Fixed
		ViewOffset=(X=1,Y=10.00,Z=0)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_Sniper
		InventorySize=11
		SightingTime=0.300000
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		//SightOffset=(X=40.000000,Y=3.000000,Z=30.000000)
		SightPivot=(Pitch=64)
        ZoomType=ZT_Fixed
		ViewOffset=(X=1,Y=10.00,Z=0)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Sniper'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	//Layouts(1)=WeaponParams'ClassicParams_Sniper'
	
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