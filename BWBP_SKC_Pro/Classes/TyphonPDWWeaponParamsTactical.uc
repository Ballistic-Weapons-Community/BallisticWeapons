class TyphonPDWWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE - Rapid Fire
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		DamageType=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_TyphonPDWHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DecayRange=(Min=1050,Max=2100)
		TraceRange=(Max=6000.000000)
		Damage=27.000000
        HeadMult=2.75f
        LimbMult=0.75f
		RangeAtten=0.75
		PenetrationEnergy=32
		Inaccuracy=(X=32,Y=32)
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.TyphonPDWFlashEmitter'
		FlashScaleFactor=0.350000
		Recoil=48.000000
		Chaos=0.150000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Typhon.Typhon-Fire',Volume=9.500000,Slot=SLOT_Interact,bNoOverride=False)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.125000
		AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Charged Fire
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParamsCharged
		DamageType=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_TyphonPDWHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_TyphonPDW'
		DecayRange=(Min=1575,Max=3675)
		TraceRange=(Max=6000.000000)
		PenetrationEnergy=64
		Damage=72.000000
        HeadMult=2.75f
        LimbMult=0.75f
		RangeAtten=0.75
		Inaccuracy=(X=32,Y=32)
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
		FlashScaleFactor=0.350000
		Recoil=140.000000
		Chaos=0.150000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Typhon.Typhon-Overblast',Volume=7.800000)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParamsCharged
		FireInterval=0.400000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		AmmoPerFire=2
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParamsCharged'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.45
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
        YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
        XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.75
		DeclineDelay=0.185000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=768)
		ADSMultiplier=0.50000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.50000
		ChaosDeclineTime=0.90000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="Ladder",Slot=52,Scale=0f)
		SightingTime=0.250000
		InventorySize=4
		SightMoveSpeedFactor=0.6
		DisplaceDurationMult=1
		MagAmmo=20
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParamsCharged'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=TY_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=TY_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.UMPCamos.PUMA-ShineUrban",Index=1,AIndex=5,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=TY_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.UMPCamos.PUMA-ShineGreen",Index=1,AIndex=5,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=TY_UTC
		Index=3
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.UMPCamos.UMPMainShine",Index=1,AIndex=5,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=TY_Blue
		Index=4
		CamoName="Nebula"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.UMPCamos.PUMA-ShineBlue",Index=1,AIndex=5,PIndex=0)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'TY_Black'
	Camos(1)=WeaponCamo'TY_Urban'
	Camos(2)=WeaponCamo'TY_Jungle'
	Camos(3)=WeaponCamo'TY_UTC'
	Camos(4)=WeaponCamo'TY_Blue'
}