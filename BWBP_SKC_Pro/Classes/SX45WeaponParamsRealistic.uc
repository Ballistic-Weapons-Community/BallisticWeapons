class SX45WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - STANDARD
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000)  //.45
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.276595
		LimbMult=0.617021
		PenetrationEnergy=9.000000
		PenetrateForce=30
		bPenetrate=True
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol'
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyFire',Volume=1.300000)
		Recoil=640.000000
		Chaos=0.100000
		Inaccuracy=(X=18,Y=18)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
				
	//=================================================================
	// FIRE PARAMS WEAPON MODE 1 - CRYOGENIC
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticCryoPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=70
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_Cryo'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=1.10
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyFrostFire',Volume=2.800000)
		Recoil=700.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticCryoPrimaryFireParams
		FireInterval=0.400000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'RealisticCryoPrimaryEffectParams'
	End Object
	
	//=================================================================
	// FIRE PARAMS WEAPON MODE 2 - RADIATION
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticRadPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.3
		Damage=55
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_RAD'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45RadMuzzleFlash'
		FlashScaleFactor=0.9
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyRadFire',Volume=2.200000)
		Recoil=700.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=RealisticRadPrimaryFireParams
		FireInterval=0.500000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'RealisticRadPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.550000
		YawFactor=0.100000
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=1670.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1100)
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
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName="RDS"
		Weight=30
		//Attachments
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		ViewOffset=(X=8,Y=8,Z=-6)
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.130000
		MagAmmo=15
		bMagPlusOne=True
		WeaponName="SX-45 .45 Tech Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticCryoPrimaryFireParams'
		FireParams(2)=FireParams'RealisticRadPrimaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,PIndex=2)
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		ViewOffset=(X=8,Y=8,Z=-6)
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		SightingTime=0.130000
		MagAmmo=15
		bMagPlusOne=True
		WeaponName="SX-45 .45 Tech Pistol"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticCryoPrimaryFireParams'
		FireParams(2)=FireParams'RealisticRadPrimaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_RDS'
	Layouts(1)=WeaponParams'RealisticParams_Irons'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=FNX_Green
		Index=0
		CamoName="Olive Drab"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=FNX_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SX45Camos.SX45-MainBlack",Index=4,AIndex=3,PIndex=3)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=FNX_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SX45Camos.SX45-MainTan",Index=4,AIndex=3,PIndex=3)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=FNX_Ruby
		Index=3
		CamoName="Ruby"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SX45Camos.SX45-MainRedShine",Index=4,AIndex=3,PIndex=3)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=FNX_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SX45Camos.SX45-MainGoldShine",Index=4,AIndex=3,PIndex=3)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'FNX_Green'
	Camos(1)=WeaponCamo'FNX_Black'
	Camos(2)=WeaponCamo'FNX_Desert'
	Camos(3)=WeaponCamo'FNX_Ruby'
	Camos(4)=WeaponCamo'FNX_Gold'
}