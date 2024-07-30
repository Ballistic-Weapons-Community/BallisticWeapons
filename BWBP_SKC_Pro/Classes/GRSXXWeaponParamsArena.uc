class GRSXXWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		RangeAtten=0.200000
		Damage=24
		HeadMult=1.4f
		LimbMult=0.5f
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXPistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXPistol'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.GRSXXFlashEmitter'
		FlashScaleFactor=1.250000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.GRSXX-Fire',Volume=1.100000)
		Recoil=150.000000
		Chaos=0.120000
		BotRefireRate=0.99
		WarnTargetPct=0.2
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.050000
		FireEndAnim=
		AimedFireAnim='SightFire'
		FireAnimRate=1.700000	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		RangeAtten=0.2
		Damage=18
		DamageType=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTGRSXXLaserHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTGRSXXLaser'
		PenetrateForce=200
		bPenetrate=True
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Glock_Gold.G-Glk-LaserFire')
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.080000
		AmmoPerFire=0
		FireAnim="Idle"	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.12),(InVal=0.300000,OutVal=0.150000),(InVal=0.4,OutVal=0.02),(InVal=0.550000,OutVal=-0.120000),(InVal=0.700000,OutVal=0.050000),(InVal=1.000000,OutVal=0.200000)))
        YCurve=(Points=(,(InVal=0.200000,OutVal=0.25000),(InVal=0.450000,OutVal=0.450000),(InVal=0.650000,OutVal=0.75000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.10000
        YRandFactor=0.10000
        DeclineTime=0.750000
        DeclineDelay=0.350000
        MaxRecoil=6144
        HipMultiplier=1.5
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
        SprintChaos=0.050000
        AimAdjustTime=0.350000
        ChaosDeclineTime=0.450000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.200000
		PlayerSpeedFactor=1.050000
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        MagAmmo=45
        InventorySize=7
		//SightOffset=(X=-15.000000,Z=6.600000)
		//ViewOffset=(X=6.000000,Y=8.000000,Z=-9.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'
	
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