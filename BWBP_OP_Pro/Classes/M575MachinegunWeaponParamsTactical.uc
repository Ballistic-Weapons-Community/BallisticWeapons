class M575MachinegunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
			TraceRange=(Min=15000.000000,Max=15000.000000)
            DecayRange=(Min=2363,Max=5000)
			RangeAtten=0.67
			Damage=34
			DamageType=Class'BWBP_OP_Pro.DTM575MG'
			DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
			DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
			PenetrationEnergy=32
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
			FlashScaleFactor=0.050000
			Recoil=200.000000
			WarnTargetPct=0.200000
			FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		End Object

		Begin Object Class=FireParams Name=TacticalPrimaryFireParams
			FireInterval=0.082000
			FireEndAnim=
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
            DecayRange=(Min=2363,Max=5000)
			RangeAtten=0.200000
			Damage=14
			DamageType=Class'BWBP_OP_Pro.DTM575Freeze'
			DamageTypeHead=Class'BWBP_OP_Pro.DTM575Freeze'
			DamageTypeArm=Class'BWBP_OP_Pro.DTM575Freeze'
			PenetrateForce=150
			bPenetrate=True
			MuzzleFlashClass=Class'BWBP_OP_Pro.M575FlashEmitter'
			FlashScaleFactor=0.250000
			Recoil=70.000000
			Chaos=0.050000
			FireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
		End Object

		Begin Object Class=FireParams Name=TacticalSecondaryFireParams
			FireInterval=0.090000
			AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.45
		XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		MaxRecoil=12288.000000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.13000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2048)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.700000
		ChaosDeclineTime=1.60000
		ChaosSpeedThreshold=15000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(2)=(BoneName="AMP",Slot=53,Scale=0f)
		//SightOffset=(X=5.000000,Y=-0.35000,Z=12.850000)
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.35
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=85
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