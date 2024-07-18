class AH104PistolWeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		DecayRange=(Min=1050,Max=3150) // 20-60m
		Inaccuracy=(X=128,Y=128)
		PenetrationEnergy=96
		Damage=80.000000 //.600 HEAT
		HeadMult=2.5
		LimbMult=0.75
		RangeAtten=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=0.900000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AH104.AH104-HFire',Volume=7.100000)
		Recoil=1536.000000
		Chaos=0.2
		WarnTargetPct=0.400000
		BotRefireRate=0.7
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireEndAnim=
		FireAnimRate=0.5
		FireInterval=1.00
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.01
		Chaos=0.05
		Damage=20.000000
		DamageRadius=192
		Inaccuracy=(X=0,Y=0)
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.5,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=8192.000000
		ClimbTime=0.1
		DeclineTime=1.5
		DeclineDelay=0.400000
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		CrouchMultiplier=0.85
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
		SightOffset=(X=-11.50000,Y=0,Z=2.030000)
		//Function
		InventorySize=5
		SightingTime=0.40
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.45
		MagAmmo=9
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel-MainSpec',Index=4,AIndex=-1,PIndex=-1)
		SightOffset=(X=-29.500000,Y=-0.020000,Z=5.050000)
		//Function
		InventorySize=5
		SightingTime=0.40
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.45
		MagAmmo=9
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams'
	Layouts(1)=WeaponParams'TacticalParams_Holo'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=AH_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainRed",Index=1,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Green
		Index=2
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainGreen",Index=1,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Tiger
		Index=3
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainTiger",Index=1,AIndex=0,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Meat
		Index=4
		CamoName="Meat"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainMeat",Index=1,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainGoldShine",Index=1,AIndex=0,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AH_Black'
	Camos(1)=WeaponCamo'AH_Red'
	Camos(2)=WeaponCamo'AH_Green'
	Camos(3)=WeaponCamo'AH_Tiger'
	Camos(4)=WeaponCamo'AH_Meat'
	Camos(5)=WeaponCamo'AH_Gold'
}