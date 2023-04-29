class M575MachinegunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=55 // 7.62 NATO
		DamageType=Class'BWBP_OP_Pro.DTM575MG'
		DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
		PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.700000
		Recoil=250.000000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.M575.M575-FireHeavy',Volume=2.300000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.120000
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=65
		DamageType=Class'BWBP_OP_Pro.DTM575Freeze'
		DamageTypeHead=Class'BWBP_OP_Pro.DTM575Freeze'
		DamageTypeArm=Class'BWBP_OP_Pro.DTM575Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45CryoFlash'
		FlashScaleFactor=0.250000
		Recoil=250.000000
		Chaos=0.050000
	FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-FireFrost',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.122000
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.01000),(InVal=0.180000,OutVal=-0.020000),(InVal=0.300000,OutVal=0.040000),(InVal=0.500000,OutVal=0.030000),(InVal=0.650000,OutVal=0.00000),(InVal=0.700000,OutVal=-0.0200000),(InVal=0.850000,OutVal=0.010000),(InVal=1.000000,OutVal=0.00)))		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=12288.000000
		ClimbTime=0.04
		DeclineDelay=0.13000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		AimAdjustTime=0.7
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//SightOffset=(X=5.000000,Y=-0.35000,Z=12.850000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.35
		SightingTime=0.55
		DisplaceDurationMult=1
		MagAmmo=50
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M575_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M575_Blacker
		Index=1
		CamoName="Midnight"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M575Camos.M575_body_CM2",Index=3,AIndex=3,PIndex=3)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M575_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M575Camos.M575_body_SH2",Index=3,AIndex=3,PIndex=3)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M575_Oil
		Index=3
		CamoName="Oil Slick"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M575Camos.M575_body_SH3",Index=3,AIndex=3,PIndex=3)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'M575_Black'
	Camos(1)=WeaponCamo'M575_Blacker'
	Camos(2)=WeaponCamo'M575_Jungle'
	Camos(3)=WeaponCamo'M575_Oil'
}