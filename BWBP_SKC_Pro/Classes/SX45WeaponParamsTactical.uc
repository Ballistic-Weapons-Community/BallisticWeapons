class SX45WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	// BWA.ModeInfos[0].TracerChance = 0; needs complex fix
}

defaultproperties
{

	//=================================================================
	// FIRE PARAMS WEAPON MODE 0 - STANDARD
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalStandardPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.5
		Damage=28 // .45
		HeadMult=3.5
		LimbMult=0.75
		PenetrationEnergy=16
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol'
		PenetrateForce=135
		bPenetrate=True
		Inaccuracy=(X=128,Y=128)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45FlashEmitter'
		FlashScaleFactor=0.9
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyFire',Volume=1.300000)
		Recoil=256.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=TacticalStandardPrimaryFireParams
		FireInterval=0.2000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'TacticalStandardPrimaryEffectParams'
	End Object
		
	//=================================================================
	// FIRE PARAMS WEAPON MODE 1 - CRYOGENIC
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalCryoPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.5
		Damage=40
		HeadMult=3
		LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_Cryo'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		PenetrateForce=135
		bPenetrate=True
		Inaccuracy=(X=128,Y=128)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=0.06
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyFrostFire',Volume=2.800000)
		Recoil=256.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=TacticalCryoPrimaryFireParams
		FireInterval=0.275
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'TacticalCryoPrimaryEffectParams'
	End Object
	
	//=================================================================
	// FIRE PARAMS WEAPON MODE 2 - RADIATION
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalRadPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=2363) // 15-45m
		RangeAtten=0.5
		Damage=34
		HeadMult=1
		LimbMult=1
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_RAD'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		PenetrateForce=135
		bPenetrate=True
		Inaccuracy=(X=128,Y=128)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45RadMuzzleFlash'
		FlashScaleFactor=2.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-HeavyRadFire',Volume=2.200000)
		Recoil=256.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=TacticalRadPrimaryFireParams
		FireInterval=0.275
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'TacticalRadPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.1
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.05
		DeclineDelay=0.200000
		DeclineTime=0.500000
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.5
    	AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ChaosDeclineTime=0.400000
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,PIndex=2)
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		DisplaceDurationMult=0.33
		SightMoveSpeedFactor=0.6
		SightingTime=0.20
		MagAmmo=15
        InventorySize=3
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalStandardPrimaryFireParams'
		FireParams(1)=FireParams'TacticalCryoPrimaryFireParams'
		FireParams(2)=FireParams'TacticalRadPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		LayoutName="RDS"
		Weight=30
		//Attachments
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		InventorySize=3
		DisplaceDurationMult=0.33
		SightMoveSpeedFactor=0.6
		SightingTime=0.20
		MagAmmo=15
		bDualBlocked=True
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalStandardPrimaryFireParams'
		FireParams(1)=FireParams'TacticalCryoPrimaryFireParams'
		FireParams(2)=FireParams'TacticalRadPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Irons'
	//Layouts(1)=WeaponParams'TacticalParams_RDS' // downgrade
	
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