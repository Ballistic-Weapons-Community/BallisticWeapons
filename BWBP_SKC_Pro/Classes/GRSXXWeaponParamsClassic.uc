class GRSXXWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

//=================================================================
// PRIMARY FIRE
//=================================================================	
		
	// Semi-Auto
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsSemi
		TraceRange=(Max=16000.000000)
		WaterTraceRange=12800.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.200000
		Damage=45
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=64.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.200000)
		Recoil=768.000000
		Chaos=0.008000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsSemi
		FireInterval=0.050000
		BurstFireRateFactor=1.00
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsSemi'
	End Object

	//Burst
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsBurst
		TraceRange=(Max=16000.000000)
		WaterTraceRange=12800.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.200000
		Damage=45
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=64.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.200000)
		Recoil=64.000000
		Chaos=0.050000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsBurst
		FireInterval=0.100000
		BurstFireRateFactor=0.50
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsBurst'
	End Object
	
	//Automatic
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsAuto
		TraceRange=(Max=16000.000000)
		WaterTraceRange=12800.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.200000
		Damage=45
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrationEnergy=64.000000
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.200000)
		Recoil=96.000000
		Chaos=0.050000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsAuto
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsAuto'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		WaterTraceRange=3500.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.350000
		Damage=35
		HeadMult=2.0
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXLaserHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		PenetrateForce=300
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.G-Glk-LaserFire',Volume=1.200000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.080000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsAuto
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsSemi
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.350000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=8192)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.050000
		JumpChaos=0.050000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.050000
		AimDamageThreshold=480.000000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=11200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25000
		bNeedCock=True
		MagAmmo=45
		ViewOffset=(X=5.000000,Y=12.000000,Z=-11.000000)
		bDualMixing=true
		//SightOffset=(X=-15.000000,Y=0.000000,Z=6.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParamsSemi'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsAuto'
		RecoilParams(2)=RecoilParams'ClassicRecoilParamsAuto'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParamsSemi'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsBurst'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsAuto'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Glock_Gold
		Index=0
		CamoName="Gold"
		Weight=60
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.Glock.Glock_Shiny',Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Brown
		Index=2
		CamoName="Brown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Green
		Index=3
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainTigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Silver
		Index=4
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainBlackShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_UTC
		Index=5
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.UTCGlockShine",Index=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Glock_Butter
		Index=6
		CamoName="Butter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.GRS9Camos.Glock_GoldShine",Index=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Glock_Gold'
	Camos(1)=WeaponCamo'Glock_Black'
	Camos(2)=WeaponCamo'Glock_Brown'
	Camos(3)=WeaponCamo'Glock_Green'
	Camos(4)=WeaponCamo'Glock_Silver'
	Camos(5)=WeaponCamo'Glock_UTC'
	Camos(6)=WeaponCamo'Glock_Butter'
}