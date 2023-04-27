class SX45WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// FIRE PARAMS WEAPON MODE 0 - STANDARD
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaStandardPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=1838)
		RangeAtten=0.67
		Damage=25
		HeadMult=2.00
		LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45FlashEmitter'
		FlashScaleFactor=0.9
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SX45.SX45-Fire',Volume=1.700000)
		Recoil=192.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaStandardPrimaryFireParams
		FireInterval=0.16000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaStandardPrimaryEffectParams'
	End Object
		
	//=================================================================
	// FIRE PARAMS WEAPON MODE 1 - CRYOGENIC
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaCryoPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=1838)
		RangeAtten=0.67
		Damage=35
		HeadMult=2.00
		LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_Cryo'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_Cryo'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=0.06
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-FrostFire',Volume=1.200000)
		Recoil=256.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaCryoPrimaryFireParams
		FireInterval=0.22
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaCryoPrimaryEffectParams'
	End Object
	
//=================================================================
	// FIRE PARAMS WEAPON MODE 2 - RADIATION
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaRadPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		DecayRange=(Min=788,Max=1838)
		RangeAtten=0.67
		Damage=26
		HeadMult=2.00
		LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead_RAD'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol_RAD'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45RadMuzzleFlash'
		FlashScaleFactor=2.5
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SX45.SX45-RadFire',Volume=1.200000)
		Recoil=128.000000
		Chaos=0.250000
		BotRefireRate=0.750000
	End Object

	Begin Object Class=FireParams Name=ArenaRadPrimaryFireParams
		FireInterval=0.22
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1	
	FireEffectParams(0)=InstantEffectParams'ArenaRadPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XRandFactor=0.05
		YRandFactor=0.05
		ClimbTime=0.05
		DeclineDelay=0.200000
		DeclineTime=0.500000
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,PIndex=2)
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		DisplaceDurationMult=0.33
		SightMoveSpeedFactor=0.9
		SightingTime=0.200000
		MagAmmo=9
        InventorySize=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		FireParams(1)=FireParams'ArenaCryoPrimaryFireParams'
		FireParams(2)=FireParams'ArenaRadPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		LayoutName="RDS"
		Weight=30
		//Attachments
		SightOffset=(X=-15.00,Y=0.00,Z=2.30)
		//Functions
		DisplaceDurationMult=0.33
		SightingTime=0.200000
		SightMoveSpeedFactor=0.9
		MagAmmo=20
        InventorySize=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardPrimaryFireParams'
		FireParams(1)=FireParams'ArenaCryoPrimaryFireParams'
		FireParams(2)=FireParams'ArenaRadPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Layouts(0)=WeaponParams'ArenaParams_Irons'
	//Layouts(1)=WeaponParams'ArenaParams_RDS'  // downgrade
	
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